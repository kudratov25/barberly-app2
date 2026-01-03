import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile/common/providers/providers.dart';
import 'package:mobile/features/barbers/models/barber.dart';
import 'package:mobile/features/barbers/models/available_slots.dart';
import 'package:mobile/features/services/models/service.dart' as svc;
import 'package:mobile/features/shops/services/shop_service.dart';
import 'package:intl/intl.dart';

/// Barber Profile/Booking Page with calendar, time slots, and services
class BarberBookingScreen extends ConsumerStatefulWidget {
  final int barberId;
  final Barber? barber;

  const BarberBookingScreen({super.key, required this.barberId, this.barber});

  @override
  ConsumerState<BarberBookingScreen> createState() =>
      _BarberBookingScreenState();
}

class _BarberBookingScreenState extends ConsumerState<BarberBookingScreen> {
  static final Set<int> _twoHourReminderScheduled = <int>{};
  DateTime? _selectedDate;
  String? _selectedTimeSlot;
  final List<svc.Service> _selectedServices = [];
  bool _isLoading = false;
  Barber? _barber;
  List<BarberSchedule> _schedules = [];
  List<String> _timeSlots = [];
  Future<PaginatedResponse<svc.Service>>? _servicesFuture;
  bool _isLoadingAvailableSlots = false;
  AvailableSlotsResponse? _availableSlotsResponse;
  String? _availableSlotsError;
  bool _isLoadingBarber = false;

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

  /// Fetch available slots from API
  Future<void> _fetchAvailableSlots() async {
    if (_selectedDate == null) {
      setState(() {
        _timeSlots = [];
        _availableSlotsResponse = null;
      });
      return;
    }

    if (_isLoadingAvailableSlots) return;
    setState(() {
      _isLoadingAvailableSlots = true;
      _availableSlotsError = null;
    });

    try {
      final dateStr = DateFormat('yyyy-MM-dd').format(_selectedDate!);
      final serviceIds = _selectedServices.map((s) => s.id).toList();

      // Calculate total duration from services if available
      int? durationMinutes;
      if (_selectedServices.isEmpty) {
        // Default duration if no services selected
        durationMinutes = 30;
      } else {
        // Calculate total duration from selected services
        durationMinutes = _selectedServices.fold<int>(
          0,
          (sum, service) => sum + service.durationMinutes,
        );
      }

      final response = await ref
          .read(availableSlotsServiceProvider)
          .getAvailableSlots(
            barberId: widget.barberId,
            date: dateStr,
            serviceIds: serviceIds.isNotEmpty ? serviceIds : null,
            durationMinutes: serviceIds.isEmpty ? durationMinutes : null,
          );

      if (mounted) {
        setState(() {
          _availableSlotsResponse = response;
          _timeSlots = response.availableSlots;
          _isLoadingAvailableSlots = false;
          _availableSlotsError = null;
        });

        // If previously selected time is not available for this date, reset it.
        if (_selectedTimeSlot != null &&
            !_timeSlots.contains(_selectedTimeSlot)) {
          setState(() {
            _selectedTimeSlot = null;
          });
        }
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoadingAvailableSlots = false;
          _availableSlotsError = e.toString();
          _timeSlots = [];
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _barber = widget.barber;
    _schedules = widget.barber?.schedules ?? [];

    // Cache services future so selecting services doesn't refetch (no flicker).
    _servicesFuture = ref
        .read(serviceServiceProvider)
        .listServices(shopId: _barber?.shopId, perPage: 200);

    // Show time slots even before user picks a date:
    // preselect the nearest working date (usually today).
    _selectedDate = _initialDateFromSchedules();
    if (_selectedDate != null) {
      // Fetch available slots when date is selected
      _fetchAvailableSlots();
    }

    // If barber wasn't provided (e.g. deep link / re-book button), fetch it so
    // we can show barber name instead of "Barber #id" and load schedules/services.
    if (_barber == null) {
      _loadBarber();
    }
  }

  Future<void> _loadBarber() async {
    if (_isLoadingBarber) return;
    setState(() {
      _isLoadingBarber = true;
    });

    try {
      final barber = await ref
          .read(barberServiceProvider)
          .getBarber(widget.barberId);

      if (!mounted) return;
      setState(() {
        _barber = barber;
        _schedules = barber.schedules ?? <BarberSchedule>[];
        _servicesFuture = ref
            .read(serviceServiceProvider)
            .listServices(shopId: _barber?.shopId, perPage: 200);
        _isLoadingBarber = false;
      });

      // Recompute initial date based on fetched schedules and load slots
      final initial = _initialDateFromSchedules();
      if (mounted) {
        setState(() {
          _selectedDate = initial;
        });
      }
      if (initial != null) {
        await _fetchAvailableSlots();
      }
    } catch (_) {
      if (!mounted) return;
      setState(() {
        _isLoadingBarber = false;
      });
    }
  }

  int get _totalPrice {
    return _selectedServices.fold(0, (sum, service) => sum + service.price);
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
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Please select a date')));
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

      // Parse time slot safely (format: "HH:mm" or "HH:mm:ss")
      final timeParts = _selectedTimeSlot!.split(':');
      if (timeParts.length < 2) {
        throw 'Invalid time format: $_selectedTimeSlot';
      }

      final hour = int.parse(timeParts[0]);
      final minute = int.parse(timeParts[1]);

      // Format startTime as "YYYY-MM-DD HH:mm:ss"
      final timeStr =
          '${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}:00';
      final startTime = '$dateStr $timeStr';

      final serviceIds = _selectedServices.map((s) => s.id).toList();
      final startDateTime = DateTime(
        _selectedDate!.year,
        _selectedDate!.month,
        _selectedDate!.day,
        hour,
        minute,
      );

      final order = await ref
          .read(orderServiceProvider)
          .createOrder(
            barberId: widget.barberId,
            serviceIds: serviceIds,
            startTime: startTime,
          );

      // Refresh available slots after booking
      await _fetchAvailableSlots();

      try {
        // NOTE:
        // Backend already sends a booking-created message to chat.
        // Sending another message from client caused duplicates, so we don't send it here.

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
                await ref
                    .read(chatServiceProvider)
                    .sendMessage(
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
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Error: $e')));
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
            backgroundColor: const Color(0xFF2C4B77),
            actions: [
              IconButton(
                icon: const Icon(
                  Icons.chat_bubble_outline,
                  color: Colors.white,
                ),
                onPressed: _openChat,
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                _barber?.name ??
                    (_isLoadingBarber
                        ? 'Loading...'
                        : 'Barber #${widget.barberId}'),
                style: const TextStyle(
                  color: Colors.white,
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
                color: const Color(0xFF2C4B77),
                child: const Center(
                  child: Icon(Icons.person, size: 80, color: Colors.white70),
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
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  InkWell(
                    onTap: () async {
                      final date = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime.now(),
                        lastDate: DateTime.now().add(const Duration(days: 30)),
                      );
                      if (date != null) {
                        setState(() {
                          _selectedDate = date;
                          _selectedTimeSlot =
                              null; // Reset selected time when date changes
                        });
                        // Fetch available slots for new date
                        await _fetchAvailableSlots();
                      }
                    },
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        border: Border.all(color: const Color(0xFF2C4B77)),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.calendar_today,
                            color: Color(0xFF2C4B77),
                          ),
                          const SizedBox(width: 12),
                          Text(
                            _selectedDate == null
                                ? 'Choose a date'
                                : DateFormat(
                                    'MMM dd, yyyy',
                                  ).format(_selectedDate!),
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
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  if (_isLoadingAvailableSlots)
                    const Center(
                      child: Padding(
                        padding: EdgeInsets.all(16.0),
                        child: CircularProgressIndicator(),
                      ),
                    )
                  else if (_availableSlotsError != null)
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFEBEE),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.red.withOpacity(0.35)),
                      ),
                      child: Text(
                        'Xatolik: $_availableSlotsError',
                        style: const TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    )
                  else if (_selectedDate != null && _timeSlots.isEmpty)
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
                        'Bu kunga bo\'sh vaqt yo\'q',
                        style: TextStyle(
                          color: Color(0xFFB45309),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    )
                  else ...[
                    // Show booked slots info if available
                    if (_availableSlotsResponse?.bookedSlots != null &&
                        _availableSlotsResponse!.bookedSlots!.isNotEmpty)
                      Container(
                        margin: const EdgeInsets.only(bottom: 12),
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: const Color(0xFFE3F2FD),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: const Color(0xFF2C4B77).withOpacity(0.3),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const Icon(
                                  Icons.info_outline,
                                  size: 16,
                                  color: Color(0xFF2C4B77),
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  'Band vaqtlar (${_availableSlotsResponse!.bookedSlots!.length})',
                                  style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xFF2C4B77),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Wrap(
                              spacing: 6,
                              runSpacing: 6,
                              children: _availableSlotsResponse!.bookedSlots!.map((
                                booked,
                              ) {
                                // Parse time safely - backend returns "HH:mm" format, but handle other formats too
                                String startTime = booked.startTime;
                                String endTime = booked.endTime;

                                // Helper function to extract HH:mm from various formats
                                String extractTime(String timeStr) {
                                  // If already in HH:mm format (5 chars), return as-is
                                  if (timeStr.length == 5 &&
                                      timeStr.contains(':')) {
                                    return timeStr;
                                  }

                                  // If format is "YYYY-MM-DDTHH:mm:ss" or "YYYY-MM-DDTHH:mm", extract time part
                                  if (timeStr.contains('T')) {
                                    final parts = timeStr.split('T');
                                    if (parts.length >= 2) {
                                      final timePart = parts[1];
                                      // Extract HH:mm (first 5 chars after T)
                                      return timePart.length >= 5
                                          ? timePart.substring(0, 5)
                                          : timePart;
                                    }
                                  }

                                  // If format is "YYYY-MM-DD HH:mm:ss" or "YYYY-MM-DD HH:mm", extract time part
                                  if (timeStr.contains(' ')) {
                                    final parts = timeStr.split(' ');
                                    if (parts.length >= 2) {
                                      final timePart = parts[1];
                                      // Extract HH:mm (first 5 chars after space)
                                      return timePart.length >= 5
                                          ? timePart.substring(0, 5)
                                          : timePart;
                                    }
                                  }

                                  // If longer than 5 chars, take first 5
                                  return timeStr.length > 5
                                      ? timeStr.substring(0, 5)
                                      : timeStr;
                                }

                                startTime = extractTime(startTime);
                                endTime = extractTime(endTime);
                                return Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade200,
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: Text(
                                    '$startTime-$endTime',
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: Colors.grey.shade700,
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                          ],
                        ),
                      ),
                    // Available time slots
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
                          selectedColor: const Color(0xFF2C4B77),
                          labelStyle: TextStyle(
                            color: isSelected ? Colors.white : Colors.black87,
                          ),
                        );
                      }).toList(),
                    ),
                  ],
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
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  FutureBuilder(
                    future: _servicesFuture,
                    builder: (context, servicesSnapshot) {
                      if (_servicesFuture == null) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      if (servicesSnapshot.connectionState ==
                          ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
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
                          final isSelected = _selectedServices.contains(
                            service,
                          );
                          return CheckboxListTile(
                            value: isSelected,
                            onChanged: (checked) async {
                              setState(() {
                                if (checked == true) {
                                  _selectedServices.add(service);
                                } else {
                                  _selectedServices.remove(service);
                                }
                                _selectedTimeSlot =
                                    null; // Reset selected time when services change
                              });
                              // Refresh available slots when services change
                              if (_selectedDate != null) {
                                await _fetchAvailableSlots();
                              }
                            },
                            title: Text(service.name),
                            subtitle: Text(
                              '${service.price} UZS • ${service.durationMinutes} min',
                            ),
                            activeColor: const Color(0xFF2C4B77),
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
                    style: TextStyle(fontSize: 12, color: Color(0xFF757575)),
                  ),
                  Text(
                    '$_totalPrice UZS',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2C4B77),
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 16),
              Expanded(
                child: ElevatedButton(
                  onPressed:
                      (_isLoading ||
                          _selectedDate == null ||
                          _timeSlots.isEmpty ||
                          _selectedTimeSlot == null ||
                          _selectedServices.isEmpty)
                      ? null
                      : _bookAppointment,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2C4B77),
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
                            valueColor: AlwaysStoppedAnimation<Color>(
                              Colors.white,
                            ),
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
