import 'package:flutter/material.dart';
import 'package:matget/screens/main_shell.dart';

// ─── Constants ────────────────────────────────────────────────────────────────

class _AppColors {
  static const primary = Color(0xFFE8541A);
  //static const primaryLight = Color(0xFFFFF0EB);
  static const textDark = Color(0xFF1A1A2E);
  static const textGrey = Color(0xFF6B7280);
  static const textLight = Color(0xFF9CA3AF);
  static const divider = Color(0xFFE5E7EB);
  static const scaffoldBg = Color(0xFFF5F5F5);
  static const green = Color(0xFF10B981);
  static const starYellow = Color(0xFFFBBF24);
  static const cardBg = Colors.white;
}

// ─── Models ───────────────────────────────────────────────────────────────────

enum StepStatus { completed, active, pending }

class _TrackStep {
  final String title;
  final String subtitle;
  final StepStatus status;
  const _TrackStep({
    required this.title,
    required this.subtitle,
    required this.status,
  });
}

class _OrderSummaryItem {
  final String name;
  final String qty;
  const _OrderSummaryItem({required this.name, required this.qty});
}

// ─── Page ─────────────────────────────────────────────────────────────────────

class TrackOrderPage extends StatelessWidget {
  const TrackOrderPage({super.key});

  static const List<_TrackStep> _steps = [
    _TrackStep(title: 'Order Confirmed', subtitle: 'Today, 9:00 AM', status: StepStatus.completed),
    _TrackStep(title: 'Picked Up', subtitle: 'Today, 11:30 AM', status: StepStatus.completed),
    _TrackStep(title: 'In Transit', subtitle: 'ETA: 45 minutes', status: StepStatus.active),
    _TrackStep(title: 'Delivered', subtitle: 'Pending', status: StepStatus.pending),
  ];

  static const List<_OrderSummaryItem> _summaryItems = [
    _OrderSummaryItem(name: 'Portland Cement (50kg)', qty: '×20 bags'),
    _OrderSummaryItem(name: 'Steel Bars (12mm)', qty: '×15 pieces'),
  ];

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
          'Track Order',
          style: TextStyle(
            color: _AppColors.textDark,
            fontSize: 17,
            fontWeight: FontWeight.w700,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert, color: _AppColors.textDark),
            onPressed: () {},
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildOrderBanner(),
          const SizedBox(height: 16),
          _buildDeliveryProgress(),
          const SizedBox(height: 16),
          _buildLiveTracking(),
          const SizedBox(height: 16),
          _buildCurrentLocation(context),
          const SizedBox(height: 16),
          _buildDriverDetails(),
          const SizedBox(height: 16),
          _buildActionButtons(),
          const SizedBox(height: 16),
          _buildOrderSummary(),
          const SizedBox(height: 16),
          _buildNeedHelp(),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  // ── Order Banner ───────────────────────────────────────────────────────────

  Widget _buildOrderBanner() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _AppColors.primary,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Order #CM-2024-001',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.white38),
                ),
                child: const Text(
                  'In Transit',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          const Text(
            'Cement & Steel Bars',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 4),
          const Row(
            children: [
              Icon(Icons.access_time, color: Colors.white70, size: 13),
              SizedBox(width: 4),
              Text(
                'Expected delivery: Today, 3:30 PM',
                style: TextStyle(color: Colors.white70, fontSize: 12),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ── Delivery Progress ──────────────────────────────────────────────────────

  Widget _buildDeliveryProgress() {
    return _Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Delivery Progress',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: _AppColors.textDark,
            ),
          ),
          const SizedBox(height: 16),
          ...List.generate(_steps.length, (i) => _StepRow(
            step: _steps[i],
            isLast: i == _steps.length - 1,
          )),
        ],
      ),
    );
  }

  // ── Live Tracking ──────────────────────────────────────────────────────────

  Widget _buildLiveTracking() {
    return Container(
      height: 160,
      decoration: BoxDecoration(
        color: const Color(0xFFE8F5E9),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFC8E6C9)),
      ),
      child: Stack(
        children: [
          // Grid pattern
          CustomPaint(
            size: const Size(double.infinity, 160),
            painter: _MapGridPainter(),
          ),
          // Centre content
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 52,
                  height: 52,
                  decoration: BoxDecoration(
                    color: _AppColors.primary,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: _AppColors.primary.withOpacity(0.35),
                        blurRadius: 12,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: const Icon(Icons.local_shipping, color: Colors.white, size: 26),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Live Tracking',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: _AppColors.textDark,
                  ),
                ),
                const SizedBox(height: 2),
                const Text(
                  'Driver is 8.2 km away',
                  style: TextStyle(fontSize: 12, color: _AppColors.textGrey),
                ),
              ],
            ),
          ),
          // LIVE badge
          Positioned(
            top: 10,
            right: 10,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(
                color: _AppColors.green,
                borderRadius: BorderRadius.circular(6),
              ),
              child: const Text(
                'LIVE',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 0.5,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ── Current Location ───────────────────────────────────────────────────────

  Widget _buildCurrentLocation(BuildContext context) {
    return _Card(
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'Current Location',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: _AppColors.textDark,
                  ),
                ),
                SizedBox(height: 3),
                Text(
                  'Highway Junction, Sector 13',
                  style: TextStyle(fontSize: 12, color: _AppColors.textGrey),
                ),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: _AppColors.primary,
              elevation: 0,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            ),
            child: const Text(
              'View Map',
              style: TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ── Driver Details ─────────────────────────────────────────────────────────

  Widget _buildDriverDetails() {
    return _Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Driver Details',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: _AppColors.textDark,
            ),
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              // Avatar
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: const Color(0xFFD1D5DB),
                  shape: BoxShape.circle,
                  border: Border.all(color: _AppColors.divider, width: 2),
                ),
                child: const Icon(Icons.person, color: Colors.white, size: 30),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Rajesh Kumar',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: _AppColors.textDark,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Row(
                      children: [
                        ...List.generate(
                          5,
                          (i) => Icon(
                            i < 4 ? Icons.star : Icons.star_half,
                            color: _AppColors.starYellow,
                            size: 13,
                          ),
                        ),
                        const SizedBox(width: 4),
                        const Text(
                          '4.9 (127 reviews)',
                          style: TextStyle(fontSize: 11, color: _AppColors.textGrey),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              // Truck number
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const Text(
                    'TR-1234',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: _AppColors.textDark,
                    ),
                  ),
                  const SizedBox(height: 2),
                  const Text(
                    'Truck Number',
                    style: TextStyle(fontSize: 10, color: _AppColors.textLight),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ── Action Buttons ─────────────────────────────────────────────────────────

  Widget _buildActionButtons() {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.phone, size: 18, color: Colors.white),
            label: const Text(
              'Call Driver',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: _AppColors.primary,
              elevation: 0,
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: ElevatedButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.chat_bubble_outline, size: 18, color: Colors.white),
            label: const Text(
              'Message',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: _AppColors.textDark,
              elevation: 0,
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            ),
          ),
        ),
      ],
    );
  }

  // ── Order Summary ──────────────────────────────────────────────────────────

  Widget _buildOrderSummary() {
    return _Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Order Summary',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: _AppColors.textDark,
            ),
          ),
          const SizedBox(height: 14),
          ..._summaryItems.map(
            (item) => Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    item.name,
                    style: const TextStyle(fontSize: 13, color: _AppColors.textGrey),
                  ),
                  Text(
                    item.qty,
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: _AppColors.textDark,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const Divider(height: 16, color: _AppColors.divider),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                'Total Amount',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: _AppColors.textDark,
                ),
              ),
              Text(
                '₹15,750',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                  color: _AppColors.primary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ── Need Help ──────────────────────────────────────────────────────────────

  Widget _buildNeedHelp() {
    return GestureDetector(
      onTap: () {},
      child: _Card(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(Icons.headset_mic_outlined, color: _AppColors.textGrey, size: 18),
            SizedBox(width: 8),
            Text(
              'Need Help?',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: _AppColors.textGrey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Step Row ─────────────────────────────────────────────────────────────────

class _StepRow extends StatelessWidget {
  final _TrackStep step;
  final bool isLast;
  const _StepRow({required this.step, required this.isLast});

  Color get _dotColor {
    switch (step.status) {
      case StepStatus.completed: return _AppColors.primary;
      case StepStatus.active:    return _AppColors.primary;
      case StepStatus.pending:   return _AppColors.textLight;
    }
  }

  @override
  Widget build(BuildContext context) {
    final isActive = step.status == StepStatus.active;
    final isCompleted = step.status == StepStatus.completed;
    final isPending = step.status == StepStatus.pending;

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // ── Timeline column
          SizedBox(
            width: 28,
            child: Column(
              children: [
                Container(
                  width: 14,
                  height: 14,
                  decoration: BoxDecoration(
                    color: isPending ? Colors.transparent : _dotColor,
                    shape: BoxShape.circle,
                    border: isPending
                        ? Border.all(color: _AppColors.textLight, width: 2)
                        : null,
                  ),
                  child: isCompleted
                      ? const Icon(Icons.check, color: Colors.white, size: 9)
                      : isActive
                          ? const SizedBox()
                          : null,
                ),
                if (!isLast)
                  Expanded(
                    child: Container(
                      width: 2,
                      color: isPending ? _AppColors.divider : _AppColors.primary.withOpacity(0.3),
                      margin: const EdgeInsets.symmetric(vertical: 2),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          // ── Text column
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(bottom: isLast ? 0 : 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        step.title,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: isActive ? FontWeight.w700 : FontWeight.w500,
                          color: isPending ? _AppColors.textLight : _AppColors.textDark,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        step.subtitle,
                        style: TextStyle(
                          fontSize: 12,
                          color: isActive ? _AppColors.primary : _AppColors.textGrey,
                          fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                  // Trailing icon
                  if (isCompleted)
                    const Icon(Icons.check, color: _AppColors.green, size: 18)
                  else if (isActive)
                    SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: _AppColors.primary,
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Reusable Card ────────────────────────────────────────────────────────────

class _Card extends StatelessWidget {
  final Widget child;
  const _Card({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
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
      child: child,
    );
  }
}

// ─── Map Grid Painter ─────────────────────────────────────────────────────────

class _MapGridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final grid = Paint()..color = const Color(0xFFA5D6A7)..strokeWidth = 1;
    for (double y = 0; y < size.height; y += 28) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), grid);
    }
    for (double x = 0; x < size.width; x += 36) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), grid);
    }
    final road = Paint()..color = Colors.white.withOpacity(0.6)..strokeWidth = 7;
    canvas.drawLine(Offset(0, size.height * 0.5), Offset(size.width, size.height * 0.5), road);
    canvas.drawLine(Offset(size.width * 0.4, 0), Offset(size.width * 0.4, size.height), road);
  }

  @override
  bool shouldRepaint(covariant CustomPainter _) => false;
}