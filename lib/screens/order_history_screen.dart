import 'package:flutter/material.dart';
import 'package:matget/screens/home_screen.dart';

// ─── Constants ────────────────────────────────────────────────────────────────

class _AppColors {
  static const primary = Color(0xFFE8541A);
  static const textDark = Color(0xFF1A1A2E);
  static const textGrey = Color(0xFF6B7280);
  static const textLight = Color(0xFF9CA3AF);
  static const divider = Color(0xFFE5E7EB);
  static const scaffoldBg = Color(0xFFF5F5F5);
  static const delivered = Color(0xFF10B981);
  static const deliveredBg = Color(0xFFD1FAE5);
  static const cancelled = Color(0xFFEF4444);
  static const cancelledBg = Color(0xFFFFE4E4);
}

// ─── Model ────────────────────────────────────────────────────────────────────

enum OrderStatus { delivered, cancelled, processing, pending }

class OrderItem {
  final String orderId;
  final String date;
  final String items;
  final double total;
  final OrderStatus status;

  const OrderItem({
    required this.orderId,
    required this.date,
    required this.items,
    required this.total,
    required this.status,
  });
}

// ─── Page ─────────────────────────────────────────────────────────────────────

class OrderHistoryPage extends StatelessWidget {
  const OrderHistoryPage({super.key});

  static const List<OrderItem> _orders = [
    OrderItem(
      orderId: '#10254',
      date: 'Oct 28, 2025',
      items: '2x Cement Bags, 1x TMT Steel Bar',
      total: 150.00,
      status: OrderStatus.delivered,
    ),
    OrderItem(
      orderId: '#10211',
      date: 'Oct 15, 2025',
      items: '5x Paint Buckets (Asian)',
      total: 85.50,
      status: OrderStatus.cancelled,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _AppColors.scaffoldBg,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        centerTitle: true,
        // ── Back arrow button
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: _AppColors.textDark),
          onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => HomeScreen(),
                          ),
                        ),
        ),
        title: const Text(
          'Order History',
          style: TextStyle(
            color: _AppColors.textDark,
            fontSize: 17,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: _orders.isEmpty ? _buildEmptyState() : _buildOrderList(),
    );
  }

  Widget _buildOrderList() {
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: _orders.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (_, i) => _OrderCard(order: _orders[i]),
    );
  }

  Widget _buildEmptyState() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.receipt_long_outlined, size: 72, color: _AppColors.textLight),
          SizedBox(height: 16),
          Text(
            'No orders yet',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: _AppColors.textDark,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Your order history will appear here',
            style: TextStyle(fontSize: 14, color: _AppColors.textGrey),
          ),
        ],
      ),
    );
  }
}

// ─── Order Card ───────────────────────────────────────────────────────────────

class _OrderCard extends StatelessWidget {
  final OrderItem order;
  const _OrderCard({required this.order});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Order ${order.orderId}',
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: _AppColors.textDark,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    order.date,
                    style: const TextStyle(fontSize: 12, color: _AppColors.textGrey),
                  ),
                ],
              ),
              _StatusBadge(status: order.status),
            ],
          ),

          const SizedBox(height: 12),
          const Divider(height: 1, color: _AppColors.divider),
          const SizedBox(height: 12),

          // ── Items
          Text(
            order.items,
            style: const TextStyle(
              fontSize: 13,
              color: _AppColors.textGrey,
              height: 1.4,
            ),
          ),

          const SizedBox(height: 12),

          // ── Price + Button
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '\$${order.total.toStringAsFixed(2)}',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                  color: _AppColors.textDark,
                ),
              ),
              _ActionButton(status: order.status),
            ],
          ),
        ],
      ),
    );
  }
}

// ─── Status Badge ─────────────────────────────────────────────────────────────

class _StatusBadge extends StatelessWidget {
  final OrderStatus status;
  const _StatusBadge({required this.status});

  String get _label {
    switch (status) {
      case OrderStatus.delivered:  return 'Delivered';
      case OrderStatus.cancelled:  return 'Cancelled';
      case OrderStatus.processing: return 'Processing';
      case OrderStatus.pending:    return 'Pending';
    }
  }

  Color get _textColor {
    switch (status) {
      case OrderStatus.delivered:  return _AppColors.delivered;
      case OrderStatus.cancelled:  return _AppColors.cancelled;
      case OrderStatus.processing: return const Color(0xFF3B82F6);
      case OrderStatus.pending:    return const Color(0xFFF59E0B);
    }
  }

  Color get _bgColor {
    switch (status) {
      case OrderStatus.delivered:  return _AppColors.deliveredBg;
      case OrderStatus.cancelled:  return _AppColors.cancelledBg;
      case OrderStatus.processing: return const Color(0xFFDBEAFE);
      case OrderStatus.pending:    return const Color(0xFFFEF3C7);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: _bgColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        _label,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: _textColor,
        ),
      ),
    );
  }
}

// ─── Action Button ────────────────────────────────────────────────────────────

class _ActionButton extends StatelessWidget {
  final OrderStatus status;
  const _ActionButton({required this.status});

  String get _label {
    switch (status) {
      case OrderStatus.delivered:  return 'Reorder';
      case OrderStatus.cancelled:  return 'Order Again';
      case OrderStatus.processing: return 'Track Order';
      case OrderStatus.pending:    return 'View Details';
    }
  }

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: () {},
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
        side: const BorderSide(color: _AppColors.primary, width: 1.5),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      ),
      child: Text(
        _label,
        style: const TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w600,
          color: _AppColors.primary,
        ),
      ),
    );
  }
}