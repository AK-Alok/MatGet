import 'package:flutter/material.dart';
//import 'package:matget/screens/home_screen.dart';

// ─── Constants ────────────────────────────────────────────────────────────────

class _AppColors {
  static const primary = Color(0xFFE8541A);
  static const primaryLight = Color(0xFFFFF0EB);
  static const textDark = Color(0xFF1A1A2E);
  static const textGrey = Color(0xFF6B7280);
  static const textLight = Color(0xFF9CA3AF);
  static const divider = Color(0xFFE5E7EB);
  static const starYellow = Color(0xFFFBBF24);
  static const green = Color(0xFF10B981);
  static const greenBg = Color(0xFFD1FAE5);
  static const scaffoldBg = Color(0xFFFFFFFF);
  //static const priceBg = Color(0xFFFFF0EB);
}

// ─── Model ────────────────────────────────────────────────────────────────────

class _Review {
  final String name;
  final double rating;
  final String comment;
  const _Review({
    required this.name,
    required this.rating,
    required this.comment,
  });
}

class _Spec {
  final String label;
  final String value;
  const _Spec({required this.label, required this.value});
}

// ─── Page ─────────────────────────────────────────────────────────────────────

class ProductDetailsPage extends StatefulWidget {
  const ProductDetailsPage({super.key});

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  int _quantity = 24;
  int _selectedImage = 0;
  bool _isFavorite = false;

  static const double _unitPrice = 45.99;
  static const double _originalPrice = 52.99;

  final List<_Spec> _specs = const [
    _Spec(label: 'Dimensions', value: '16" x 8" x 8"'),
    _Spec(label: 'Weight', value: '35 lbs'),
    _Spec(label: 'Material', value: 'Concrete'),
    _Spec(label: 'Compression Strength', value: '3000 PSI'),
    _Spec(label: 'Certification', value: 'ASTM C90'),
  ];

  final List<_Review> _reviews = const [
    _Review(
      name: 'Rakesh Kumar',
      rating: 5,
      comment:
          'Excellent quality blocks. Used for our foundation project and they exceeded expectations. Fast delivery too!',
    ),
    _Review(
      name: 'Sunita Das',
      rating: 4,
      comment:
          'Good product, arrived on time. Packaging could be better but the blocks themselves are solid.',
    ),
    _Review(
      name: 'Pankaj Mishra',
      rating: 5,
      comment:
          'Excellent quality blocks. Used for our foundation project and they exceeded expectations. Fast delivery too!',
    ),
    _Review(
      name: 'Anoop Bhatiya',
      rating: 4,
      comment:
          'Good product, arrived on time. Packaging could be better but the blocks themselves are solid.',
    ),
  ];

  double get _subtotal => _unitPrice * _quantity;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _AppColors.scaffoldBg,
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              _buildSliverAppBar(context),
              SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildImageThumbnails(),
                    _buildProductHeader(),
                    _divider(),
                    _buildSpecifications(),
                    _divider(),
                    _buildQuantitySection(),
                    _divider(),
                    _buildDeliveryInfo(),
                    _divider(),
                    _buildReviews(),
                    const SizedBox(height: 50),
                  ],
                ),
              ),
            ],
          ),
          _buildBottomBar(context),
        ],
      ),
    );
  }

  // ── Sliver App Bar ─────────────────────────────────────────────────────────

  Widget _buildSliverAppBar(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 280,
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
            boxShadow: [
              BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 6),
            ],
          ),
          child: const Icon(
            Icons.arrow_back,
            color: _AppColors.textDark,
            size: 20,
          ),
        ),
      ),
      title: const Text(
        'Product Details',
        style: TextStyle(
          color: _AppColors.textDark,
          fontSize: 17,
          fontWeight: FontWeight.w600,
        ),
      ),
      centerTitle: true,
      actions: [
        Container(
          margin: const EdgeInsets.all(8),
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.9),
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 6),
            ],
          ),
          child: const Icon(
            Icons.share_outlined,
            color: _AppColors.textDark,
            size: 20,
          ),
        ),
        GestureDetector(
          onTap: () => setState(() => _isFavorite = !_isFavorite),
          child: Container(
            margin: const EdgeInsets.only(right: 8, top: 8, bottom: 8),
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.9),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 6),
              ],
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
        background: Stack(
          fit: StackFit.expand,
          children: [
            // Hero product image placeholder
            Container(
              color: const Color(0xFF7A8A9A),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 40),
                  Icon(
                    Icons.view_in_ar,
                    size: 80,
                    color: Colors.white.withOpacity(0.4),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Premium Concrete Blocks',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.6),
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            // In Stock badge
            Positioned(
              top: 95,
              left: 12,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: _AppColors.green,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: const Text(
                  'In Stock',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            // Image counter
            Positioned(
              bottom: 12,
              right: 12,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Text(
                  '1/4',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            // Bottom gradient
            // Positioned(
            //   bottom: 0,
            //   left: 0,
            //   right: 0,
            //   child: Container(
            //     height: 40,
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
      ),
    );
  }

  // ── Image Thumbnails ───────────────────────────────────────────────────────

  Widget _buildImageThumbnails() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
      child: Row(
        children: List.generate(4, (i) {
          final isSelected = _selectedImage == i;
          return GestureDetector(
            onTap: () => setState(() => _selectedImage = i),
            child: Container(
              width: 58,
              height: 58,
              margin: const EdgeInsets.only(right: 8),
              decoration: BoxDecoration(
                color: const Color(0xFFF3F4F6),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: isSelected ? _AppColors.primary : _AppColors.divider,
                  width: isSelected ? 2 : 1,
                ),
              ),
              child: Icon(
                Icons.view_in_ar,
                size: 24,
                color: isSelected ? _AppColors.primary : _AppColors.textLight,
              ),
            ),
          );
        }),
      ),
    );
  }

  // ── Product Header ─────────────────────────────────────────────────────────

  Widget _buildProductHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Name + Price
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Expanded(
                child: Text(
                  'Premium Concrete\nBlocks',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                    color: _AppColors.textDark,
                    height: 1.2,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '${_unitPrice.toStringAsFixed(2)} Rs/pc',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                      color: _AppColors.primary,
                    ),
                  ),
                  Text(
                    '${_originalPrice.toStringAsFixed(2)} Rs/pc',
                    style: const TextStyle(
                      fontSize: 12,
                      color: _AppColors.textLight,
                      decoration: TextDecoration.lineThrough,
                    ),
                  ),
                ],
              ),
            ],
          ),

          const SizedBox(height: 10),

          // Rating + Reviews
          Row(
            children: [
              ...List.generate(
                5,
                (i) => Icon(
                  i < 4 ? Icons.star : Icons.star_half,
                  color: _AppColors.starYellow,
                  size: 16,
                ),
              ),
              const SizedBox(width: 6),
              const Text(
                '4.7',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: _AppColors.textDark,
                ),
              ),
              const SizedBox(width: 4),
              const Text(
                '(324 reviews)',
                style: TextStyle(fontSize: 13, color: _AppColors.textGrey),
              ),
            ],
          ),

          const SizedBox(height: 10),

          // SKU + Delivery badges
          Row(
            children: [
              const Icon(Icons.tag, size: 14, color: _AppColors.textGrey),
              const SizedBox(width: 4),
              const Text(
                'SKU: CB-2024-001',
                style: TextStyle(fontSize: 12, color: _AppColors.textGrey),
              ),
              const SizedBox(width: 16),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: _AppColors.greenBg,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Icon(
                      Icons.local_shipping_outlined,
                      size: 12,
                      color: _AppColors.green,
                    ),
                    SizedBox(width: 4),
                    Text(
                      'Same day delivery',
                      style: TextStyle(
                        fontSize: 11,
                        color: _AppColors.green,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          // Description
          const Text(
            'High-quality concrete blocks perfect for construction projects. Durable, weather-resistant, and meets all industry standards. Ideal for foundations, walls, and structural applications.',
            style: TextStyle(
              fontSize: 13,
              color: _AppColors.textGrey,
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }

  // ── Specifications ─────────────────────────────────────────────────────────

  Widget _buildSpecifications() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Specifications',
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w700,
              color: _AppColors.textDark,
            ),
          ),
          const SizedBox(height: 2),
          ...List.generate(_specs.length, (i) {
            final spec = _specs[i];
            return Container(
              padding: const EdgeInsets.symmetric(vertical: 11),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: i < _specs.length - 1
                        ? _AppColors.divider
                        : Colors.transparent,
                  ),
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Text(
                      spec.label,
                      style: const TextStyle(
                        fontSize: 13,
                        color: _AppColors.textGrey,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Text(
                      spec.value,
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: _AppColors.textDark,
                      ),
                      textAlign: TextAlign.right,
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  // ── Quantity ───────────────────────────────────────────────────────────────

  Widget _buildQuantitySection() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Quantity',
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w700,
              color: _AppColors.textDark,
            ),
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              // Minus
              GestureDetector(
                onTap: () {
                  if (_quantity > 1) setState(() => _quantity--);
                },
                child: Container(
                  width: 38,
                  height: 38,
                  decoration: BoxDecoration(
                    color: _quantity > 1
                        ? _AppColors.primaryLight
                        : const Color(0xFFF3F4F6),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.remove,
                    size: 18,
                    color: _quantity > 1
                        ? _AppColors.primary
                        : _AppColors.textLight,
                  ),
                ),
              ),
              const SizedBox(width: 20),
              Text(
                '$_quantity',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: _AppColors.textDark,
                ),
              ),
              const SizedBox(width: 20),
              // Plus
              GestureDetector(
                onTap: () => setState(() => _quantity++),
                child: Container(
                  width: 38,
                  height: 38,
                  decoration: const BoxDecoration(
                    color: _AppColors.primary,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.add, size: 18, color: Colors.white),
                ),
              ),
              const Spacer(),
            ],
          ),
          const SizedBox(height: 16),
          // Price summary
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: const Color(0xFFF9FAFB),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: _AppColors.divider),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Unit price:',
                      style: TextStyle(
                        fontSize: 13,
                        color: _AppColors.textGrey,
                      ),
                    ),
                    Text(
                      '${_unitPrice.toStringAsFixed(2)} Rs',
                      style: const TextStyle(
                        fontSize: 13,
                        color: _AppColors.textDark,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Subtotal:',
                      style: TextStyle(
                        fontSize: 13,
                        color: _AppColors.textGrey,
                      ),
                    ),
                    Text(
                      '${_subtotal.toStringAsFixed(2)} Rs',
                      style: const TextStyle(
                        fontSize: 15,
                        color: _AppColors.primary,
                        fontWeight: FontWeight.w800,
                      ),
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

  // ── Delivery Info ──────────────────────────────────────────────────────────

  Widget _buildDeliveryInfo() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Delivery Information',
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w700,
              color: _AppColors.textDark,
            ),
          ),
          const SizedBox(height: 14),

          // Deliver to
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: _AppColors.primaryLight,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.location_on,
                  color: _AppColors.primary,
                  size: 20,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Deliver to: Downtown Construction\nSite',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: _AppColors.textDark,
                            height: 1.4,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: const Text(
                            'Change',
                            style: TextStyle(
                              fontSize: 13,
                              color: _AppColors.primary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 2),
                    const Text(
                      '1234, Chandpur, Bijnor(UP), India',
                      style: TextStyle(
                        fontSize: 12,
                        color: _AppColors.textGrey,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 14),

          // Same Day
          _DeliveryRow(
            icon: Icons.flash_on,
            title: 'Same Day Delivery',
            subtitle: 'Order by 2 PM for same day delivery',
          ),

          const SizedBox(height: 12),

          // Insured
          _DeliveryRow(
            icon: Icons.shield,
            title: 'Insured Delivery',
            subtitle: 'Full coverage for damage or loss',
          ),
        ],
      ),
    );
  }

  // ── Customer Reviews ───────────────────────────────────────────────────────

  Widget _buildReviews() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Customer Reviews',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                  color: _AppColors.textDark,
                ),
              ),
              GestureDetector(
                onTap: () {},
                child: const Text(
                  'View All',
                  style: TextStyle(
                    fontSize: 13,
                    color: _AppColors.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          ..._reviews.map((r) => _ReviewCard(review: r)).toList(),

          Container(
            width: double.infinity,
            color: Colors.white,
            padding: EdgeInsets.only(
              left: 6,
              right: 6,
              bottom: MediaQuery.of(context).padding.bottom + 10,
            ),
            child: ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.flash_on, size: 18, color: Colors.white),
              label: const Text(
                'Order Now – Same Day Delivery',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF1A1A2E),
                padding: const EdgeInsets.symmetric(vertical: 14),
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ── Bottom Bar ─────────────────────────────────────────────────────────────

  Widget _buildBottomBar(BuildContext context) {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Chat + Add to Cart
          Container(
            padding: EdgeInsets.only(left: 16, right: 16, top: 10, bottom: 8),
            color: Colors.white,
            child: Row(
              children: [
                OutlinedButton.icon(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.chat_bubble_outline,
                    size: 18,
                    color: _AppColors.primary,
                  ),
                  label: const Text(
                    'Chat',
                    style: TextStyle(
                      color: _AppColors.primary,
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 18,
                      vertical: 12,
                    ),
                    side: const BorderSide(
                      color: _AppColors.primary,
                      width: 1.5,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.shopping_cart_outlined,
                      size: 18,
                      color: Colors.white,
                    ),
                    label: const Text(
                      'Add to Cart',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _AppColors.primary,
                      padding: const EdgeInsets.symmetric(vertical: 13),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Order Now
        ],
      ),
    );
  }

  Widget _divider() => const Divider(height: 1, color: _AppColors.divider);
}

// ─── Sub Widgets ──────────────────────────────────────────────────────────────

class _DeliveryRow extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  const _DeliveryRow({
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: _AppColors.primaryLight,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: _AppColors.primary, size: 18),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: _AppColors.textDark,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                subtitle,
                style: const TextStyle(
                  fontSize: 12,
                  color: _AppColors.textGrey,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _ReviewCard extends StatelessWidget {
  final _Review review;
  const _ReviewCard({required this.review});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFFF9FAFB),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _AppColors.divider),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 18,
                backgroundColor: _AppColors.primaryLight,
                child: Text(
                  review.name[0],
                  style: const TextStyle(
                    color: _AppColors.primary,
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  review.name,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: _AppColors.textDark,
                  ),
                ),
              ),
              Row(
                children: List.generate(
                  5,
                  (i) => Icon(
                    i < review.rating.floor() ? Icons.star : Icons.star_border,
                    size: 14,
                    color: _AppColors.starYellow,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            review.comment,
            style: const TextStyle(
              fontSize: 13,
              color: _AppColors.textGrey,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}
