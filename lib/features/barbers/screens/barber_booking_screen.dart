import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile/common/providers/providers.dart';
import 'package:mobile/features/barbers/models/barber.dart';
import 'package:mobile/features/services/models/service.dart' as svc;
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
  DateTime? _selectedDate;
  String? _selectedTimeSlot;
  List<svc.Service> _selectedServices = [];
  bool _isLoading = false;
  Barber? _barber;
  List<BarberSchedule> _schedules = [];
  List<String> _timeSlots = [];

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

        _timeSlots.add(DateFormat('HH:mm').format(slot));
        slot = slot.add(const Duration(minutes: 30));
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _barber = widget.barber;
    _schedules = widget.barber?.schedules ?? [];
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
      final primaryService = _selectedServices.first;

      final order = await ref.read(orderServiceProvider).createOrder(
            barberId: widget.barberId,
            serviceId: primaryService.id,
            startTime: startTime,
          );

      // Create or get chat with this barber and send booking info message
      try {
        final currentUser =
            await ref.read(authServiceProvider).getCurrentUser();
        final chat = await ref
            .read(chatServiceProvider)
            .createOrGetChat(widget.barberId);

        final message =
            '${currentUser.name} booked services on $dateStr at ${_selectedTimeSlot!}';

        await ref.read(chatServiceProvider).sendMessage(
              chatId: chat.id,
              message: message,
              orderId: order.id,
            );
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
                                _generateTimeSlotsForDate(date);
                              });
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
                          future:
                              ref.read(serviceServiceProvider).listServices(),
                          builder: (context, servicesSnapshot) {
                            if (servicesSnapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                  child: CircularProgressIndicator());
                            }

                            if (!servicesSnapshot.hasData ||
                                servicesSnapshot.data!.data.isEmpty) {
                              return const Text('No services available');
                            }

                            final services = servicesSnapshot.data!.data;
                            return Column(
                              children: services.map((service) {
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
                  onPressed: _isLoading ? null : _bookAppointment,
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

