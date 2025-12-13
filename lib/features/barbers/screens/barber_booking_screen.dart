import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile/common/providers/providers.dart';
import 'package:mobile/features/barbers/models/barber.dart';
import 'package:mobile/features/orders/models/order.dart';
import 'package:mobile/features/services/models/service.dart' as svc;
import 'package:mobile/features/shops/services/shop_service.dart';
import 'package:intl/intl.dart';

/// Barber Profile/Booking Page with calendar, time slots, and services
class BarberBookingScreen extends ConsumerStatefulWidget {
  final int barberId;
  final Barber? barber;

  const BarberBookingScreen({
    super.key,
    required this.barberId,
    this.barber,
  });

  @override
  ConsumerState<BarberBookingScreen> createState() =>
      _BarberBookingScreenState();
}

class _BarberBookingScreenState extends ConsumerState<BarberBookingScreen> {
  static final Set<int> _twoHourReminderScheduled = <int>{};
  DateTime? _selectedDate;
  String? _selectedTimeSlot;
  List<svc.Service> _selectedServices = [];
  bool _isLoading = false;
  Barber? _barber;
  List<BarberSchedule> _schedules = [];
  List<String> _timeSlots = [];
  Future<PaginatedResponse<svc.Service>>? _servicesFuture;
  List<Order> _existingOrders = [];
  bool _isLoadingOrders = false;

  DateTime? _initialDateFromSchedules() {
    if (_schedules.isEmpty) return null;
    final now = DateTime.now();
    for (int i = 0; i <= 30; i++) {
      final d = DateTime(now.year, now.month, now.day).add(Duration(days: i));
      final dayIndex = d.weekday % 7;
      final has = _schedules.any((s) => s.isActive && s.dayOfWeek == dayIndex);
      if (has) return d;
    }
    return null;
  }

  /// Fetch existing orders for this barber to filter out booked slots
  Future<void> _fetchExistingOrders() async {
    if (_isLoadingOrders) return;
    setState(() => _isLoadingOrders = true);

    try {
      final ordersResponse = await ref
          .read(orderServiceProvider)
          .listOrders(role: 'client', perPage: 100);

      // Filter orders for this barber with pending/in_progress status
      final now = DateTime.now();
      _existingOrders = ordersResponse.data.where((order) {
        // Only consider orders for this barber
        if (order.barberId != widget.barberId) return false;

        // Only consider pending or in_progress orders
        final status = order.status.toLowerCase();
        if (status != 'pending' && status != 'in_progress') return false;

        // Only consider future orders
        try {
          final startTime = DateTime.parse(order.startTime);
          return startTime.isAfter(now);
        } catch (_) {
          return false;
        }
      }).toList();

      // Regenerate time slots with updated orders
      if (_selectedDate != null) {
        _generateTimeSlotsForDate(_selectedDate!);
      }
    } catch (_) {
      // Ignore errors, continue with available slots
    } finally {
      if (mounted) {
        setState(() => _isLoadingOrders = false);
      }
    }
  }

  /// Check if a time slot is already booked
  bool _isSlotBooked(DateTime slotDateTime) {
    for (final order in _existingOrders) {
      try {
        final orderStartTime = DateTime.parse(order.startTime);
        // Check if the slot overlaps with an existing order
        // Orders are typically 30 minutes, so we check exact match or overlap
        final slotEnd = slotDateTime.add(const Duration(minutes: 30));
        final orderEnd = order.endTime != null
            ? DateTime.parse(order.endTime!)
            : orderStartTime.add(const Duration(minutes: 30));

        // Check if slots overlap
        if (slotDateTime.isBefore(orderEnd) && slotEnd.isAfter(orderStartTime)) {
          return true;
        }
      } catch (_) {
        // Skip invalid dates
      }
    }
    return false;
  }

  void _generateTimeSlotsForDate(DateTime date) {
    _timeSlots = [];
    if (_schedules.isEmpty) return;

    // Laravel docs: day_of_week 0-6 (yakshanba-shanba)
    final dayIndex = date.weekday % 7; // DateTime: 1=Mon..7=Sun

    final daySchedules =
        _schedules.where((s) => s.dayOfWeek == dayIndex && s.isActive).toList();
    if (daySchedules.isEmpty) return;

    for (final sched in daySchedules) {
      DateTime? start;
      DateTime? end;
      DateTime? breakStart;
      DateTime? breakEnd;

      try {
        final startParts = sched.startTime.split(':');
        final endParts = sched.endTime.split(':');
        start = DateTime(date.year, date.month, date.day,
            int.parse(startParts[0]), int.parse(startParts[1]));
        end = DateTime(date.year, date.month, date.day,
            int.parse(endParts[0]), int.parse(endParts[1]));

        if (sched.breakStart != null && sched.breakEnd != null) {
          final bStartParts = sched.breakStart!.split(':');
          final bEndParts = sched.breakEnd!.split(':');
          breakStart = DateTime(date.year, date.month, date.day,
              int.parse(bStartParts[0]), int.parse(bStartParts[1]));
          breakEnd = DateTime(date.year, date.month, date.day,
              int.parse(bEndParts[0]), int.parse(bEndParts[1]));
        }
      } catch (_) {
        continue;
      }

      var slot = start;
      final now = DateTime.now();

      while (slot.isBefore(end)) {
        // Skip past times for today
        if (date.year == now.year &&
            date.month == now.month &&
            date.day == now.day &&
            slot.isBefore(now)) {
          slot = slot.add(const Duration(minutes: 30));
          continue;
        }

        // Skip break time
        if (breakStart != null &&
            breakEnd != null &&
            !slot.isBefore(breakStart) &&
            slot.isBefore(breakEnd)) {
          slot = slot.add(const Duration(minutes: 30));
          continue;
        }

        // Skip if this slot is already booked
        if (_isSlotBooked(slot)) {
          slot = slot.add(const Duration(minutes: 30));
          continue;
        }

        _timeSlots.add(DateFormat('HH:mm').format(slot));
        slot = slot.add(const Duration(minutes: 30));
      }
    }

    // If previously selected time is not available for this date, reset it.
    if (_selectedTimeSlot != null && !_timeSlots.contains(_selectedTimeSlot)) {
      _selectedTimeSlot = null;
    }
  }

  @override
  void initState() {
    super.initState();
    _barber = widget.barber;
    _schedules = widget.barber?.schedules ?? [];

    // Cache services future so selecting services doesn't refetch (no flicker).
    _servicesFuture = ref.read(serviceServiceProvider).listServices(
          shopId: _barber?.shopId,
          perPage: 200,
        );

    // Fetch existing orders to filter out booked slots
    _fetchExistingOrders();

    // Show time slots even before user picks a date:
    // preselect the nearest working date (usually today).
    _selectedDate = _initialDateFromSchedules();
    if (_selectedDate != null) {
      _generateTimeSlotsForDate(_selectedDate!);
    }
  }

  int get _totalPrice {
    return _selectedServices.fold(
        0, (sum, service) => sum + service.price);
  }

  Future<void> _openChat() async {
    try {
      final chat = await ref
          .read(chatServiceProvider)
          .createOrGetChat(widget.barberId);
      if (!mounted) return;
      context.push('/chats/${chat.id}');
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Could not open chat: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<void> _bookAppointment() async {
    if (_selectedDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a date')),
      );
      return;
    }

    if (_selectedTimeSlot == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a time slot')),
      );
      return;
    }

    if (_selectedServices.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select at least one service')),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      final dateStr = DateFormat('yyyy-MM-dd').format(_selectedDate!);
      final startTime = '$dateStr ${_selectedTimeSlot!}:00';
      final serviceIds = _selectedServices.map((s) => s.id).toList();
      final startDateTime = DateTime(
        _selectedDate!.year,
        _selectedDate!.month,
        _selectedDate!.day,
        int.parse(_selectedTimeSlot!.split(':')[0]),
        int.parse(_selectedTimeSlot!.split(':')[1]),
      );

      final order = await ref.read(orderServiceProvider).createOrder(
            barberId: widget.barberId,
            serviceIds: serviceIds,
            startTime: startTime,
          );

      // Refresh orders list to update available slots
      await _fetchExistingOrders();

      // Create or get chat with this barber and send booking info message
      try {
        final chat = await ref
            .read(chatServiceProvider)
            .createOrGetChat(widget.barberId);

        final servicesText = _selectedServices.map((s) => s.name).join(', ');
        final message = [
          'New booking',
          'Date: $dateStr',
          'Time: ${_selectedTimeSlot!}',
          'Services: $servicesText',
          'Total: $_totalPrice UZS',
        ].join('\n');

        await ref.read(chatServiceProvider).sendMessage(
              chatId: chat.id,
              message: message,
              orderId: order.id,
            );

        // Schedule "2 hours left" reminder (in-app, when app is running)
        if (!_twoHourReminderScheduled.contains(order.id)) {
          final remindAt = startDateTime.subtract(const Duration(hours: 2));
          final delay = remindAt.difference(DateTime.now());
          if (delay.inMilliseconds > 0) {
            _twoHourReminderScheduled.add(order.id);
            Future.delayed(delay, () async {
              try {
                final reminderChat = await ref
                    .read(chatServiceProvider)
                    .createOrGetChat(widget.barberId);
                final reminderMessage = [
                  'Reminder',
                  'Order #${order.id}',
                  'Bookingga 2 soat qoldi',
                  'Date: $dateStr',
                  'Time: ${_selectedTimeSlot!}',
                ].join('\n');
                await ref.read(chatServiceProvider).sendMessage(
                      chatId: reminderChat.id,
                      message: reminderMessage,
                      orderId: order.id,
                    );
              } catch (_) {
                // ignore
              }
            });
          }
        }
      } catch (_) {
        // Ignore chat errors, booking is already successful
      }

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Booking successful!'),
            backgroundColor: Colors.green,
          ),
        );
        context.go('/orders');
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      body: CustomScrollView(
        slivers: [
          // App bar with barber info
          SliverAppBar(
            expandedHeight: 200,
            pinned: true,
            backgroundColor: const Color(0xFF2196F3),
            actions: [
              IconButton(
                icon: const Icon(Icons.chat_bubble_outline),
                onPressed: _openChat,
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                _barber?.name ?? 'Barber #${widget.barberId}',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  shadows: [
                    Shadow(
                      offset: Offset(0, 1),
                      blurRadius: 3,
                      color: Colors.black45,
                    ),
                  ],
                ),
              ),
              background: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xFF2196F3),
                      Color(0xFF1976D2),
                    ],
                  ),
                ),
                child: const Center(
                  child: Icon(
                    Icons.person,
                    size: 80,
                    color: Colors.white54,
                  ),
                ),
              ),
            ),
          ),

          // Barber info card
          SliverToBoxAdapter(
            child: Container(
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  if (_barber?.ratingAvg != null)
                    _InfoChip(
                      icon: Icons.star,
                      label: _barber!.ratingAvg!.toStringAsFixed(1),
                      color: Colors.amber,
                    ),
                  _InfoChip(
                    icon: Icons.access_time,
                    label: _barber?.scheduleStatus ?? 'offline',
                    color: _barber?.scheduleStatus == 'online'
                        ? Colors.green
                        : Colors.grey,
                  ),
                ],
              ),
            ),
          ),

          // Date selection
          SliverToBoxAdapter(
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Select Date',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 12),
                        InkWell(
                          onTap: () async {
                            final date = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime.now(),
                              lastDate: DateTime.now()
                                  .add(const Duration(days: 30)),
                            );
                            if (date != null) {
                              setState(() {
                                _selectedDate = date;
                              });
                              // Refresh orders and regenerate time slots
                              await _fetchExistingOrders();
                              _generateTimeSlotsForDate(date);
                            }
                          },
                          borderRadius: BorderRadius.circular(12),
                          child: Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: const Color(0xFF2196F3),
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              children: [
                                const Icon(Icons.calendar_today,
                                    color: Color(0xFF2196F3)),
                                const SizedBox(width: 12),
                                Text(
                                  _selectedDate == null
                                      ? 'Choose a date'
                                      : DateFormat('MMM dd, yyyy')
                                          .format(_selectedDate!),
                                  style: const TextStyle(fontSize: 15),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

          const SliverToBoxAdapter(child: SizedBox(height: 16)),

          // Time slots
          SliverToBoxAdapter(
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Select Time',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 12),
                        if (_selectedDate != null && _timeSlots.isEmpty)
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: const Color(0xFFFFF3E0),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: Colors.orange.withOpacity(0.35),
                              ),
                            ),
                            child: const Text(
                              'Bu kunga bo‘sh vaqt yo‘q',
                              style: TextStyle(
                                color: Color(0xFFB45309),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          )
                        else
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: _timeSlots.map((time) {
                            final isSelected = _selectedTimeSlot == time;
                            return ChoiceChip(
                              label: Text(time),
                              selected: isSelected,
                              onSelected: (selected) {
                                setState(() {
                                  _selectedTimeSlot = selected ? time : null;
                                });
                              },
                              selectedColor: const Color(0xFF2196F3),
                              labelStyle: TextStyle(
                                color:
                                    isSelected ? Colors.white : Colors.black87,
                              ),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ),
                ),

          const SliverToBoxAdapter(child: SizedBox(height: 16)),

          // Services selection
          SliverToBoxAdapter(
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Select Services',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 12),
                        FutureBuilder(
                          future: _servicesFuture,
                          builder: (context, servicesSnapshot) {
                            if (_servicesFuture == null) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                            if (servicesSnapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                  child: CircularProgressIndicator());
                            }

                            if (servicesSnapshot.hasError) {
                              return Text('Error: ${servicesSnapshot.error}');
                            }

                            if (!servicesSnapshot.hasData ||
                                servicesSnapshot.data!.data.isEmpty) {
                              return const Text('No services available');
                            }

                            final allServices = servicesSnapshot.data!.data
                                .where((s) => s.isActive)
                                .toList();

                            // Shop-wide services (same for all barbers in this shop)
                            allServices.sort((a, b) => a.name.compareTo(b.name));

                            if (allServices.isEmpty) {
                              return const Text('No services available');
                            }
                            return Column(
                              children: allServices.map((service) {
                                final isSelected =
                                    _selectedServices.contains(service);
                                return CheckboxListTile(
                                  value: isSelected,
                                  onChanged: (checked) {
                                    setState(() {
                                      if (checked == true) {
                                        _selectedServices.add(service);
                                      } else {
                                        _selectedServices.remove(service);
                                      }
                                    });
                                  },
                                  title: Text(service.name),
                                  subtitle: Text(
                                    '${service.price} UZS • ${service.durationMinutes} min',
                                  ),
                                  activeColor: const Color(0xFF2196F3),
                                );
                              }).toList(),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),

          const SliverToBoxAdapter(child: SizedBox(height: 100)),
        ],
      ),

      // Bottom bar with total and book button
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: SafeArea(
          child: Row(
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Total Price',
                    style: TextStyle(
                      fontSize: 12,
                      color: Color(0xFF757575),
                    ),
                  ),
                  Text(
                    '$_totalPrice UZS',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2196F3),
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 16),
              Expanded(
                child: ElevatedButton(
                  onPressed: (_isLoading ||
                          _selectedDate == null ||
                          _timeSlots.isEmpty ||
                          _selectedTimeSlot == null ||
                          _selectedServices.isEmpty)
                      ? null
                      : _bookAppointment,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2196F3),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: _isLoading
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.white),
                          ),
                        )
                      : const Text(
                          'Book Appointment',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Color _getColorShade(Color color) {
  if (color == Colors.amber) return Colors.amber[700]!;
  if (color == Colors.green) return Colors.green[700]!;
  if (color == Colors.grey) return Colors.grey[700]!;
  return color;
}

class _InfoChip extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;

  const _InfoChip({
    required this.icon,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: color, size: 18),
          const SizedBox(width: 6),
          Text(
            label,
            style: TextStyle(
              color: _getColorShade(color),
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

