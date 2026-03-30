import 'package:flutter/material.dart';
import 'package:matget/screens/main_shell.dart';

// ─── Constants ────────────────────────────────────────────────────────────────

class _AppColors {
  static const primary = Color(0xFFE8541A);
  static const primaryLight = Color(0xFFFFF0EB);
  static const textDark = Color(0xFF1A1A2E);
  static const textGrey = Color(0xFF6B7280);
  static const textLight = Color(0xFF9CA3AF);
  static const divider = Color(0xFFE5E7EB);
  static const scaffoldBg = Color(0xFFF5F5F5);
  static const cardBg = Colors.white;
}

// ─── Model ────────────────────────────────────────────────────────────────────

class CartItem {
  final String id;
  final String name;
  final String subtitle;
  final double unitPrice;
  int quantity;

  CartItem({
    required this.id,
    required this.name,
    required this.subtitle,
    required this.unitPrice,
    required this.quantity,
  });

  double get total => unitPrice * quantity;
}

// ─── Page ─────────────────────────────────────────────────────────────────────

class MyCartPage extends StatefulWidget {
  const MyCartPage({super.key});

  @override
  State<MyCartPage> createState() => _MyCartPageState();
}

class _MyCartPageState extends State<MyCartPage> {
  final List<CartItem> _items = [
    CartItem(
      id: '1',
      name: 'UltraTech Cement',
      subtitle: '50kg Bag',
      unitPrice: 380.00,
      quantity: 2,
    ),
    CartItem(
      id: '2',
      name: 'TMT Steel Bar',
      subtitle: '12mm, 1 Ton',
      unitPrice: 6500.00,
      quantity: 1,
    ),
    CartItem(
      id: '3',
      name: 'Gravel',
      subtitle: '50kg bag',
      unitPrice: 540.00,
      quantity: 1,
    ),
    CartItem(
      id: '4',
      name: 'River Sand',
      subtitle: '25Kg Bag',
      unitPrice: 175.00,
      quantity: 1,
    ),
  ];

  static const double _deliveryFee = 180.00;

  double get _subtotal => _items.fold(0, (sum, item) => sum + item.total);
  double get _total => _subtotal + _deliveryFee;

  void _increment(CartItem item) => setState(() => item.quantity++);

  void _decrement(CartItem item) {
    if (item.quantity > 1) {
      setState(() => item.quantity--);
    } else {
      _showRemoveDialog(item);
    }
  }

  void _removeItem(CartItem item) {
    setState(() => _items.removeWhere((e) => e.id == item.id));
  }

  void _showRemoveDialog(CartItem item) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        title: const Text(
          'Remove Item?',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
        ),
        content: Text(
          'Remove "${item.name}" from your cart?',
          style: const TextStyle(fontSize: 14, color: _AppColors.textGrey),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel', style: TextStyle(color: _AppColors.textGrey)),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _removeItem(item);
            },
            child: const Text('Remove', style: TextStyle(color: _AppColors.primary)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _AppColors.scaffoldBg,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: _AppColors.textDark),
          onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => MainShell(),
                          ),
                        ),
        ),
        title: const Text(
          'My Cart',
          style: TextStyle(
            color: _AppColors.textDark,
            fontSize: 17,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: _items.isEmpty ? _buildEmptyCart() : _buildCartContent(),
    );
  }

  // ── Empty State ────────────────────────────────────────────────────────────

  Widget _buildEmptyCart() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.shopping_cart_outlined, size: 80, color: _AppColors.textLight),
          const SizedBox(height: 16),
          const Text(
            'Your cart is empty',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: _AppColors.textDark,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Add items to get started',
            style: TextStyle(fontSize: 14, color: _AppColors.textGrey),
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            style: ElevatedButton.styleFrom(
              backgroundColor: _AppColors.primary,
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 13),
              elevation: 0,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            ),
            child: const Text(
              'Browse Products',
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }

  // ── Cart Content ───────────────────────────────────────────────────────────

  Widget _buildCartContent() {
    return Stack(
      children: [
        ListView(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 180),
          children: [
            // Cart items
            ..._items.map((item) => _CartItemCard(
                  item: item,
                  onIncrement: () => _increment(item),
                  onDecrement: () => _decrement(item),
                  onDismiss: () => _removeItem(item),
                )),
            const SizedBox(height: 16),
            // Price summary
            _buildPriceSummary(),
          ],
        ),
        // Bottom checkout bar
        _buildCheckoutBar(),
      ],
    );
  }

  // ── Price Summary ──────────────────────────────────────────────────────────

  Widget _buildPriceSummary() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _AppColors.cardBg,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          _PriceRow(label: 'Subtotal', value: '\₹${_subtotal.toStringAsFixed(2)}'),
          const SizedBox(height: 10),
          _PriceRow(label: 'Delivery Fee', value: '\₹${_deliveryFee.toStringAsFixed(2)}'),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 12),
            child: Divider(height: 1, color: _AppColors.divider),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Total',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                  color: _AppColors.textDark,
                ),
              ),
              Text(
                '\₹${_total.toStringAsFixed(2)}',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  color: _AppColors.textDark,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ── Checkout Bar ───────────────────────────────────────────────────────────

  Widget _buildCheckoutBar() {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        padding: EdgeInsets.only(
          left: 16,
          right: 16,
          top: 16,
          bottom: MediaQuery.of(context).padding.bottom + 16,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 16,
              offset: const Offset(0, -4),
            ),
          ],
        ),
        child: ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: _AppColors.primary,
            elevation: 0,
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          ),
          child: const Text(
            'Proceed to Checkout',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
    );
  }
}

// ─── Cart Item Card ───────────────────────────────────────────────────────────

class _CartItemCard extends StatelessWidget {
  final CartItem item;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;
  final VoidCallback onDismiss;

  const _CartItemCard({
    required this.item,
    required this.onIncrement,
    required this.onDecrement,
    required this.onDismiss,
  });

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(item.id),
      direction: DismissDirection.endToStart,
      onDismissed: (_) => onDismiss(),
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: const Color(0xFFFFE4E4),
          borderRadius: BorderRadius.circular(14),
        ),
        child: const Icon(Icons.delete_outline, color: Color(0xFFEF4444), size: 26),
      ),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: _AppColors.cardBg,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            // Product image placeholder
            Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                color: const Color(0xFFF3F4F6),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: _AppColors.divider),
              ),
              child: Icon(
                Icons.inventory_2_outlined,
                size: 30,
                color: _AppColors.primary.withOpacity(0.5),
              ),
            ),
            const SizedBox(width: 12),
            // Name + price
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.name,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: _AppColors.textDark,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    item.subtitle,
                    style: const TextStyle(fontSize: 12, color: _AppColors.textGrey),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '\₹${item.total.toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w800,
                      color: _AppColors.primary,
                    ),
                  ),
                ],
              ),
            ),
            // Quantity control
            Row(
              children: [
                _QtyButton(
                  icon: Icons.remove,
                  onTap: onDecrement,
                  active: true,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    '${item.quantity}',
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: _AppColors.textDark,
                    ),
                  ),
                ),
                _QtyButton(
                  icon: Icons.add,
                  onTap: onIncrement,
                  active: true,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Quantity Button ──────────────────────────────────────────────────────────

class _QtyButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  final bool active;

  const _QtyButton({
    required this.icon,
    required this.onTap,
    required this.active,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 28,
        height: 28,
        decoration: BoxDecoration(
          color: active ? _AppColors.primaryLight : const Color(0xFFF3F4F6),
          shape: BoxShape.circle,
          border: Border.all(
            color: active ? _AppColors.primary.withOpacity(0.4) : _AppColors.divider,
          ),
        ),
        child: Icon(
          icon,
          size: 15,
          color: active ? _AppColors.primary : _AppColors.textLight,
        ),
      ),
    );
  }
}

// ─── Price Row ────────────────────────────────────────────────────────────────

class _PriceRow extends StatelessWidget {
  final String label;
  final String value;

  const _PriceRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: const TextStyle(fontSize: 14, color: _AppColors.textGrey)),
        Text(
          value,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: _AppColors.textDark,
          ),
        ),
      ],
    );
  }
}