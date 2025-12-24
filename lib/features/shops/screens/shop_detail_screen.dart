import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile/common/providers/providers.dart';
import 'package:mobile/features/barbers/models/barber.dart';
import 'package:mobile/features/shops/models/shop.dart';
import 'package:url_launcher/url_launcher.dart';

/// Shop Detail Page with workers list and map navigation
class ShopDetailScreen extends ConsumerStatefulWidget {
  final int shopId;

  const ShopDetailScreen({super.key, required this.shopId});

  @override
  ConsumerState<ShopDetailScreen> createState() => _ShopDetailScreenState();
}

class _ShopDetailScreenState extends ConsumerState<ShopDetailScreen> {
  String? _statusFilter; // online|offline|busy|walk_in

  Future<void> _openMap(double lat, double lng, String shopName) async {
    // Using Yandex Maps (can be changed to Google Maps)
    final url = 'yandexmaps://maps.yandex.ru/?rtext=~$lat,$lng&rtt=auto';
    final fallbackUrl = 'https://yandex.ru/maps/?rtext=~$lat,$lng&rtt=auto';

    try {
      if (await canLaunchUrl(Uri.parse(url))) {
        await launchUrl(Uri.parse(url));
      } else {
        await launchUrl(
          Uri.parse(fallbackUrl),
          mode: LaunchMode.externalApplication,
        );
      }
    } catch (e) {
      // Fallback: open in browser
      await launchUrl(
        Uri.parse(fallbackUrl),
        mode: LaunchMode.externalApplication,
      );
    }
  }

  Color _statusColor(String? status) {
    switch ((status ?? '').toLowerCase()) {
      case 'online':
        return Colors.green;
      case 'busy':
        return Colors.orange;
      case 'walk_in':
        return Colors.purple;
      case 'offline':
      default:
        return Colors.grey;
    }
  }

  String _statusLabel(String? status) {
    switch ((status ?? '').toLowerCase()) {
      case 'online':
        return 'Bo‘sh';
      case 'busy':
        return 'Band';
      case 'walk_in':
        return 'Walk-in';
      case 'offline':
      default:
        return 'Offline';
    }
  }

  Future<void> _openChat(Barber barber) async {
    try {
      final chat = await ref
          .read(chatServiceProvider)
          .createOrGetChat(barber.id);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      body: FutureBuilder<Shop>(
        future: ref.read(shopServiceProvider).getShop(widget.shopId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, size: 48, color: Colors.red),
                  const SizedBox(height: 16),
                  Text('Error: ${snapshot.error}'),
                ],
              ),
            );
          }
          if (!snapshot.hasData) {
            return const Center(child: Text('Shop not found'));
          }

          final shop = snapshot.data!;
          final barbersFuture = ref
              .read(shopServiceProvider)
              .getShopBarbers(shopId: widget.shopId, status: _statusFilter);
          return CustomScrollView(
            slivers: [
              // App bar
              SliverAppBar(
                expandedHeight: 180,
                pinned: true,
                backgroundColor: const Color(0xFF1E3A5F),
                flexibleSpace: FlexibleSpaceBar(
                  centerTitle: true,
                  titlePadding: const EdgeInsets.only(bottom: 16),
                  title: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      shop.name,
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        shadows: [
                          Shadow(
                            offset: Offset(0, 1),
                            blurRadius: 4,
                            color: Colors.black26,
                          ),
                        ],
                      ),
                    ),
                  ),
                  background: Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [Color(0xFF1E3A5F), Color(0xFF2C4B77)],
                      ),
                    ),
                    child: const Center(
                      child: Icon(Icons.store, size: 70, color: Colors.white30),
                    ),
                  ),
                ),
              ),

              // Shop info section
              SliverToBoxAdapter(
                child: Container(
                  margin: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.06),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Address
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: const Color(0xFF2C4B77).withOpacity(0.1),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Icon(
                              Icons.location_on,
                              color: Color(0xFF2C4B77),
                              size: 20,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              shop.address ?? 'Manzil ko\'rsatilmagan',
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFF212121),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),

                      // Phone
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: const Color(0xFF2C4B77).withOpacity(0.1),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Icon(
                              Icons.phone,
                              color: Color(0xFF2C4B77),
                              size: 20,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Text(
                            shop.phone,
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF212121),
                            ),
                          ),
                        ],
                      ),
                      if (shop.locationLat != null &&
                          shop.locationLng != null) ...[
                        const SizedBox(height: 20),
                        // Go to Shop button (Map)
                        ElevatedButton.icon(
                          onPressed: () => _openMap(
                            shop.locationLat!,
                            shop.locationLng!,
                            shop.name,
                          ),
                          icon: const Icon(Icons.directions, size: 20),
                          label: const Text(
                            'Go to Shop',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF2C4B77),
                            foregroundColor: Colors.white,
                            minimumSize: const Size(double.infinity, 48),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            elevation: 0,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ),

              // Barbers section header
              SliverToBoxAdapter(
                child: Container(
                  padding: const EdgeInsets.fromLTRB(16, 24, 16, 12),
                  child: Row(
                    children: [
                      const Text(
                        'Barbers',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF212121),
                          letterSpacing: -0.5,
                        ),
                      ),
                      const SizedBox(width: 10),
                      FutureBuilder<List<Barber>>(
                        future: barbersFuture,
                        builder: (context, s) {
                          final count = s.hasData ? s.data!.length : 0;
                          return Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 5,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFF2C4B77),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              '$count',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),

              // Status filter chips
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        ChoiceChip(
                          label: const Text(
                            'All',
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          selected: _statusFilter == null,
                          onSelected: (_) =>
                              setState(() => _statusFilter = null),
                          selectedColor: const Color(0xFF2C4B77),
                          labelStyle: TextStyle(
                            color: _statusFilter == null
                                ? Colors.white
                                : const Color(0xFF212121),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 8,
                          ),
                        ),
                        const SizedBox(width: 8),
                        ChoiceChip(
                          label: const Text(
                            'Bo‘sh',
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          selected: _statusFilter == 'online',
                          onSelected: (_) =>
                              setState(() => _statusFilter = 'online'),
                          selectedColor: const Color(0xFF2C4B77),
                          labelStyle: TextStyle(
                            color: _statusFilter == 'online'
                                ? Colors.white
                                : const Color(0xFF212121),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 8,
                          ),
                        ),
                        const SizedBox(width: 8),
                        ChoiceChip(
                          label: const Text(
                            'Band',
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          selected: _statusFilter == 'busy',
                          onSelected: (_) =>
                              setState(() => _statusFilter = 'busy'),
                          selectedColor: const Color(0xFF2C4B77),
                          labelStyle: TextStyle(
                            color: _statusFilter == 'busy'
                                ? Colors.white
                                : const Color(0xFF212121),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 8,
                          ),
                        ),
                        const SizedBox(width: 8),
                        ChoiceChip(
                          label: const Text(
                            'Walk-in',
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          selected: _statusFilter == 'walk_in',
                          onSelected: (_) =>
                              setState(() => _statusFilter = 'walk_in'),
                          selectedColor: const Color(0xFF2C4B77),
                          labelStyle: TextStyle(
                            color: _statusFilter == 'walk_in'
                                ? Colors.white
                                : const Color(0xFF212121),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 8,
                          ),
                        ),
                        const SizedBox(width: 8),
                        ChoiceChip(
                          label: const Text(
                            'Offline',
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          selected: _statusFilter == 'offline',
                          onSelected: (_) =>
                              setState(() => _statusFilter = 'offline'),
                          selectedColor: const Color(0xFF2C4B77),
                          labelStyle: TextStyle(
                            color: _statusFilter == 'offline'
                                ? Colors.white
                                : const Color(0xFF212121),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 8,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // Barbers list
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                sliver: SliverToBoxAdapter(
                  child: FutureBuilder<List<Barber>>(
                    future: barbersFuture,
                    builder: (context, s) {
                      if (s.connectionState == ConnectionState.waiting) {
                        return const Padding(
                          padding: EdgeInsets.only(top: 24),
                          child: Center(child: CircularProgressIndicator()),
                        );
                      }
                      if (s.hasError) {
                        return Padding(
                          padding: const EdgeInsets.only(top: 24),
                          child: Center(child: Text('Error: ${s.error}')),
                        );
                      }
                      final barbers = s.data ?? const <Barber>[];
                      if (barbers.isEmpty) {
                        return const Padding(
                          padding: EdgeInsets.only(top: 24),
                          child: Center(child: Text('No barbers available')),
                        );
                      }

                      return Column(
                        children: barbers.map((barber) {
                          final status = barber.scheduleStatus;
                          final statusColor = _statusColor(status);
                          final statusLabel = _statusLabel(status);

                          return InkWell(
                            onTap: () => context.push(
                              '/barbers/${barber.id}/book',
                              extra: barber,
                            ),
                            borderRadius: BorderRadius.circular(16),
                            child: Card(
                              margin: const EdgeInsets.only(bottom: 12),
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                                side: BorderSide(
                                  color: Colors.grey.shade200,
                                  width: 1,
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(16),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          width: 56,
                                          height: 56,
                                          decoration: BoxDecoration(
                                            color: const Color(0xFF2C4B77),
                                            borderRadius: BorderRadius.circular(
                                              12,
                                            ),
                                          ),
                                          child: const Icon(
                                            Icons.person,
                                            color: Colors.white,
                                            size: 28,
                                          ),
                                        ),
                                        const SizedBox(width: 12),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                barber.name,
                                                style: const TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600,
                                                  color: Color(0xFF212121),
                                                ),
                                              ),
                                              const SizedBox(height: 6),
                                              if (barber.phone != null &&
                                                  barber.phone!.isNotEmpty)
                                                Text(
                                                  barber.phone!,
                                                  style: const TextStyle(
                                                    fontSize: 13,
                                                    color: Color(0xFF757575),
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                              if (barber.ratingAvg != null) ...[
                                                const SizedBox(height: 4),
                                                Row(
                                                  children: [
                                                    Icon(
                                                      Icons.star,
                                                      color:
                                                          Colors.amber.shade700,
                                                      size: 16,
                                                    ),
                                                    const SizedBox(width: 4),
                                                    Text(
                                                      barber.ratingAvg!
                                                          .toStringAsFixed(1),
                                                      style: const TextStyle(
                                                        fontSize: 13,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color: Color(
                                                          0xFF212121,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ],
                                          ),
                                        ),
                                        Column(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            // Status badge
                                            Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                    horizontal: 10,
                                                    vertical: 5,
                                                  ),
                                              decoration: BoxDecoration(
                                                color: statusColor.withOpacity(
                                                  0.12,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(999),
                                                border: Border.all(
                                                  color: statusColor
                                                      .withOpacity(0.35),
                                                  width: 1,
                                                ),
                                              ),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Container(
                                                    width: 8,
                                                    height: 8,
                                                    decoration: BoxDecoration(
                                                      color: statusColor,
                                                      shape: BoxShape.circle,
                                                    ),
                                                  ),
                                                  const SizedBox(width: 6),
                                                  Text(
                                                    statusLabel,
                                                    style: TextStyle(
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: statusColor,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            const SizedBox(height: 8),
                                            // Message icon
                                            Container(
                                              decoration: BoxDecoration(
                                                color: const Color(
                                                  0xFF2C4B77,
                                                ).withOpacity(0.1),
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                              child: IconButton(
                                                icon: const Icon(
                                                  Icons.chat_bubble_outline,
                                                  size: 18,
                                                ),
                                                color: const Color(0xFF2C4B77),
                                                padding: const EdgeInsets.all(
                                                  8,
                                                ),
                                                constraints:
                                                    const BoxConstraints(
                                                      minWidth: 36,
                                                      minHeight: 36,
                                                    ),
                                                onPressed: () =>
                                                    _openChat(barber),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 16),
                                    ElevatedButton(
                                      onPressed: () => context.push(
                                        '/barbers/${barber.id}/book',
                                        extra: barber,
                                      ),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: const Color(
                                          0xFF2C4B77,
                                        ),
                                        foregroundColor: Colors.white,
                                        minimumSize: const Size(
                                          double.infinity,
                                          44,
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
                                        ),
                                        elevation: 0,
                                      ),
                                      child: const Text(
                                        'Book Appointment',
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      );
                    },
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
