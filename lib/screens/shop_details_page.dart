import 'package:flutter/material.dart';

// ─── Constants ────────────────────────────────────────────────────────────────

class _AppColors {
  static const primary = Color(0xFFE8541A);
  static const primaryLight = Color(0xFFFFF0EB);
  static const textDark = Color(0xFF1A1A2E);
  static const textGrey = Color(0xFF6B7280);
  static const textLight = Color(0xFF9CA3AF);
  static const cardBg = Color(0xFFF9FAFB);
  static const divider = Color(0xFFE5E7EB);
  static const openGreen = Color(0xFF10B981);
  static const starYellow = Color(0xFFFBBF24);
}

// ─── Data Models ──────────────────────────────────────────────────────────────

class _MaterialCategory {
  final IconData icon;
  final String label;
  const _MaterialCategory({required this.icon, required this.label});
}

class _Product {
  final String name;
  final double rating;
  final double price;
  final Color bgColor;
  const _Product({
    required this.name,
    required this.rating,
    required this.price,
    required this.bgColor,
  });
}

// ─── Page ─────────────────────────────────────────────────────────────────────

class ShopDetailsPage extends StatefulWidget {
  const ShopDetailsPage({super.key});

  @override
  State<ShopDetailsPage> createState() => _ShopDetailsPageState();
}

class _ShopDetailsPageState extends State<ShopDetailsPage> {
  bool _isFavorite = false;

  final List<_MaterialCategory> _categories = const [
    _MaterialCategory(icon: Icons.water_drop_outlined, label: 'Cement &\nConcrete'),
    _MaterialCategory(icon: Icons.layers_outlined, label: 'Bricks &\nBlocks'),
    _MaterialCategory(icon: Icons.build_outlined, label: 'Hardware'),
    _MaterialCategory(icon: Icons.park_outlined, label: 'Timber &\nWood'),
    _MaterialCategory(icon: Icons.format_paint_outlined, label: 'Paint &\nCoating'),
    _MaterialCategory(icon: Icons.flash_on_outlined, label: 'Electrical'),
    _MaterialCategory(icon: Icons.plumbing_outlined, label: 'Plumbing'),
    _MaterialCategory(icon: Icons.handyman_outlined, label: 'Tools'),
  ];

  final List<_Product> _products = const [
    _Product(name: 'Portland Cement 50kg', rating: 4.7, price: 12.50, bgColor: Color(0xFFFFF9C4)),
    _Product(name: 'Red Bricks (100 pcs)', rating: 4.9, price: 45.00, bgColor: Color(0xFFFFE0B2)),
    _Product(name: 'Steel Rebar (Gr. 60)', rating: 4.6, price: 85.00, bgColor: Color(0xFFE8EAF6)),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              _buildSliverAppBar(),
              SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildShopInfo(),
                    _divider(),
                    _buildCategories(),
                    _divider(),
                    _buildFeaturedProducts(),
                    _divider(),
                    _buildStats(),
                    _divider(),
                    _buildLocation(),
                    _divider(),
                    _buildContact(),
                    const SizedBox(height: 100),
                  ],
                ),
              ),
            ],
          ),
          _buildBottomBar(),
        ],
      ),
    );
  }

  // ── Sliver App Bar ─────────────────────────────────────────────────────────

  Widget _buildSliverAppBar() {
    return SliverAppBar(
      expandedHeight: 220,
      pinned: true,
      backgroundColor: Colors.white,
      elevation: 0.5,
      leading: GestureDetector(
        onTap: () => Navigator.maybePop(context),
        child: Container(
          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.9),
            shape: BoxShape.circle,
            boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 6)],
          ),
          child: const Icon(Icons.arrow_back, color: _AppColors.textDark, size: 20),
        ),
      ),
      title: const Text(
        'Shop Details',
        style: TextStyle(color: _AppColors.textDark, fontSize: 17, fontWeight: FontWeight.w600),
      ),
      centerTitle: true,
      actions: [
        GestureDetector(
          onTap: () => setState(() => _isFavorite = !_isFavorite),
          child: Container(
            margin: const EdgeInsets.all(8),
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.9),
              shape: BoxShape.circle,
              boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 6)],
            ),
            child: Icon(
              _isFavorite ? Icons.favorite : Icons.favorite_border,
              color: _isFavorite ? _AppColors.primary : _AppColors.textGrey,
              size: 20,
            ),
          ),
        ),
      ],
      flexibleSpace: FlexibleSpaceBar(
        background: _ShopHeroBanner(),
      ),
    );
  }

  // ── Shop Info ──────────────────────────────────────────────────────────────

  Widget _buildShopInfo() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Expanded(
                child: Text(
                  'Bharat Hardware Store',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: _AppColors.textDark),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: _AppColors.openGreen.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 6, height: 6,
                      decoration: const BoxDecoration(color: _AppColors.openGreen, shape: BoxShape.circle),
                    ),
                    const SizedBox(width: 4),
                    const Text(
                      'Open',
                      style: TextStyle(color: _AppColors.openGreen, fontSize: 12, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              const Icon(Icons.star, color: _AppColors.starYellow, size: 16),
              const SizedBox(width: 4),
              const Text('4.8', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: _AppColors.textDark)),
              const SizedBox(width: 4),
              const Text('(324 reviews)', style: TextStyle(fontSize: 13, color: _AppColors.textGrey)),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Icon(Icons.location_on, color: _AppColors.primary, size: 16),
              SizedBox(width: 6),
              Expanded(
                child: Text(
                  '1243 Chandpur ,Bijnor (UP) ,India',
                  style: TextStyle(fontSize: 13, color: _AppColors.textGrey, height: 1.4),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              const Icon(Icons.access_time, color: _AppColors.primary, size: 16),
              const SizedBox(width: 6),
              RichText(
                text: const TextSpan(
                  style: TextStyle(fontSize: 13, color: _AppColors.textGrey),
                  children: [
                    TextSpan(text: 'Mon-Sat: 7:00 AM – 8:00 PM  '),
                    TextSpan(text: 'Sun: Closed', style: TextStyle(color: Color(0xFFEF4444))),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ── Material Categories ────────────────────────────────────────────────────

  Widget _buildCategories() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Material Categories',
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700, color: _AppColors.textDark)),
          Transform.translate(
                  offset: Offset(0, -12),
                  child: GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              childAspectRatio: 0.85,
              crossAxisSpacing: 8,
              mainAxisSpacing: 12,
            ),
            itemCount: _categories.length,
            itemBuilder: (_, i) => _CategoryTile(category: _categories[i]),
          ),
          ),
        ],
      ),
    );
  }

  // ── Featured Products ──────────────────────────────────────────────────────

  Widget _buildFeaturedProducts() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Featured Products',
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700, color: _AppColors.textDark)),
                GestureDetector(
                  onTap: () {},
                  child: const Text('View All',
                      style: TextStyle(fontSize: 13, color: _AppColors.primary, fontWeight: FontWeight.w600)),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 200,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: _products.length,
              itemBuilder: (_, i) => _ProductCard(product: _products[i]),
            ),
          ),
        ],
      ),
    );
  }

  // ── Stats ──────────────────────────────────────────────────────────────────

  Widget _buildStats() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Row(
        children: [
          _StatItem(icon: Icons.inventory_2_outlined, value: '850+', label: 'Products'),
          Container(width: 1, height: 50, color: _AppColors.divider),
          _StatItem(icon: Icons.local_shipping_outlined, value: '2-3 hrs', label: 'Delivery'),
          Container(width: 1, height: 50, color: _AppColors.divider),
          _StatItem(icon: Icons.people_outline, value: '12K+', label: 'Customers'),
        ],
      ),
    );
  }

  // ── Location ───────────────────────────────────────────────────────────────

  Widget _buildLocation() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Location',
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700, color: _AppColors.textDark)),
          const SizedBox(height: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: SizedBox(
              height: 160,
              child: Stack(
                children: [
                  CustomPaint(
                    size: const Size(double.infinity, 160),
                    painter: _MapPainter(),
                  ),
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 36, height: 36,
                          decoration: const BoxDecoration(color: _AppColors.primary, shape: BoxShape.circle),
                          child: const Icon(Icons.store, color: Colors.white, size: 20),
                        ),
                        CustomPaint(painter: _PinTailPainter(), size: const Size(12, 8)),
                      ],
                    ),
                  ),
                  Positioned(
                    top: 8, right: 8,
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 4)],
                      ),
                      child: const Icon(Icons.my_location, color: _AppColors.primary, size: 16),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 8),
          const Row(
            children: [
              Icon(Icons.navigation, color: _AppColors.primary, size: 14),
              SizedBox(width: 4),
              Text('2.3 km away from your location',
                  style: TextStyle(fontSize: 12, color: _AppColors.textGrey)),
            ],
          ),
        ],
      ),
    );
  }

  // ── Contact ────────────────────────────────────────────────────────────────

  Widget _buildContact() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Contact Information',
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700, color: _AppColors.textDark)),
          const SizedBox(height: 12),
          _ContactRow(icon: Icons.phone_outlined, label: 'Phone', value: '+91 8151745365'),
          const SizedBox(height: 10),
          _ContactRow(icon: Icons.email_outlined, label: 'Email', value: 'info@bharat.com'),
          const SizedBox(height: 10),
          _ContactRow(icon: Icons.language_outlined, label: 'Website', value: 'www.BHS.com'),
        ],
      ),
    );
  }

  // ── Bottom Bar ─────────────────────────────────────────────────────────────

  Widget _buildBottomBar() {
    return Positioned(
      bottom: 0, left: 0, right: 0,
      child: Container(
        padding: EdgeInsets.only(
          left: 16, right: 16, top: 12,
          bottom: MediaQuery.of(context).padding.bottom + 12,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 16, offset: const Offset(0, -4))],
        ),
        child: Row(
          children: [
            Expanded(
              child: OutlinedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.phone, size: 18, color: _AppColors.primary),
                label: const Text('Call Shop',
                    style: TextStyle(color: _AppColors.primary, fontWeight: FontWeight.w600, fontSize: 15)),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  side: const BorderSide(color: _AppColors.primary, width: 1.5),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.shopping_bag_outlined, size: 18, color: Colors.white),
                label: const Text('Shop Now',
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 15)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: _AppColors.primary,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  elevation: 0,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _divider() => const Divider(height: 1, color: _AppColors.divider);
}

// ─── Sub-Widgets ──────────────────────────────────────────────────────────────

class _ShopHeroBanner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFF3D2B1F), Color(0xFF6B4226)],
        ),
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 40),
                Container(
                  width: 160, height: 100,
                  decoration: BoxDecoration(
                    color: const Color(0xFF8B5E3C),
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(color: const Color(0xFFD4A574), width: 2),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 120, height: 50,
                        decoration: BoxDecoration(
                          color: const Color(0xFFFFD580).withOpacity(0.85),
                          borderRadius: BorderRadius.circular(2),
                        ),
                        child: const Icon(Icons.storefront, color: Color(0xFF8B5E3C), size: 36),
                      ),
                      const SizedBox(height: 6),
                      const Text('Bharat Hardware Store ',
                          style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.w600)),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Positioned(
          //   bottom: 0, left: 0, right: 0,
          //   child: Container(
          //     height: 60,
          //     decoration: const BoxDecoration(
          //       gradient: LinearGradient(
          //         begin: Alignment.bottomCenter,
          //         end: Alignment.topCenter,
          //         colors: [Colors.white, Colors.transparent],
          //       ),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}

class _CategoryTile extends StatelessWidget {
  final _MaterialCategory category;
  const _CategoryTile({required this.category});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 52, height: 52,
          decoration: BoxDecoration(
            color: _AppColors.primaryLight,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(category.icon, color: _AppColors.primary, size: 24),
        ),
        const SizedBox(height: 6),
        Text(
          category.label,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 10.5, color: _AppColors.textDark,
            fontWeight: FontWeight.w500, height: 1.3,
          ),
        ),
      ],
    );
  }
}

class _ProductCard extends StatelessWidget {
  final _Product product;
  const _ProductCard({required this.product});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      margin: const EdgeInsets.only(right: 12),
      decoration: BoxDecoration(
        color: _AppColors.cardBg,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: _AppColors.divider),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 100,
            decoration: BoxDecoration(
              color: product.bgColor,
              borderRadius: const BorderRadius.vertical(top: Radius.circular(13)),
            ),
            child: Center(
              child: Icon(Icons.inventory_2, size: 50, color: _AppColors.primary.withOpacity(0.6)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(product.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        fontSize: 12, fontWeight: FontWeight.w600, color: _AppColors.textDark, height: 1.3)),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(Icons.star, color: _AppColors.starYellow, size: 12),
                    const SizedBox(width: 2),
                    Text('${product.rating}',
                        style: const TextStyle(fontSize: 11, color: _AppColors.textGrey, fontWeight: FontWeight.w500)),
                  ],
                ),
                const SizedBox(height: 6),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('\₹${product.price.toStringAsFixed(2)}',
                        style: const TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w700, color: _AppColors.primary)),
                    Container(
                      width: 26, height: 26,
                      decoration: const BoxDecoration(color: _AppColors.primary, shape: BoxShape.circle),
                      child: const Icon(Icons.add, color: Colors.white, size: 16),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;
  const _StatItem({required this.icon, required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Container(
            width: 44, height: 44,
            decoration: BoxDecoration(color: _AppColors.primaryLight, borderRadius: BorderRadius.circular(10)),
            child: Icon(icon, color: _AppColors.primary, size: 22),
          ),
          const SizedBox(height: 6),
          Text(value,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: _AppColors.textDark)),
          Text(label, style: const TextStyle(fontSize: 12, color: _AppColors.textGrey)),
        ],
      ),
    );
  }
}

class _ContactRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  const _ContactRow({required this.icon, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 38, height: 38,
          decoration: BoxDecoration(color: _AppColors.primaryLight, borderRadius: BorderRadius.circular(10)),
          child: Icon(icon, color: _AppColors.primary, size: 18),
        ),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label,
                style: const TextStyle(fontSize: 11, color: _AppColors.textLight, fontWeight: FontWeight.w500)),
            Text(value,
                style: const TextStyle(fontSize: 14, color: _AppColors.textDark, fontWeight: FontWeight.w500)),
          ],
        ),
      ],
    );
  }
}

// ─── Custom Painters ──────────────────────────────────────────────────────────

class _MapPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height),
        Paint()..color = const Color(0xFFD4E8C2));

    final grid = Paint()..color = const Color(0xFFB8D4A0)..strokeWidth = 1;
    for (double y = 0; y < size.height; y += 30) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), grid);
    }
    for (double x = 0; x < size.width; x += 40) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), grid);
    }

    final road = Paint()..color = Colors.white.withOpacity(0.7)..strokeWidth = 8;
    canvas.drawLine(Offset(0, size.height * 0.5), Offset(size.width, size.height * 0.5), road);
    canvas.drawLine(Offset(size.width * 0.5, 0), Offset(size.width * 0.5, size.height), road);
  }

  @override
  bool shouldRepaint(covariant CustomPainter _) => false;
}

class _PinTailPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final path = Path()
      ..moveTo(0, 0)
      ..lineTo(size.width / 2, size.height)
      ..lineTo(size.width, 0)
      ..close();
    canvas.drawPath(path, Paint()..color = _AppColors.primary);
  }

  @override
  bool shouldRepaint(covariant CustomPainter _) => false;
}