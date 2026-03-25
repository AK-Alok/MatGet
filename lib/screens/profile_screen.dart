import 'package:flutter/material.dart';

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
  static const starYellow = Color(0xFFFBBF24);
  static const red = Color(0xFFEF4444);
}

// ─── Model ────────────────────────────────────────────────────────────────────

class _MenuItem {
  final IconData icon;
  final String title;
  final String subtitle;
  final int? badge;
  final bool isDestructive;

  const _MenuItem({
    required this.icon,
    required this.title,
    required this.subtitle,
    this.badge,
    this.isDestructive = false,
  });
}

// ─── Page ─────────────────────────────────────────────────────────────────────

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  static const List<_MenuItem> _menuItems = [
    _MenuItem(
      icon: Icons.history_outlined,
      title: 'Order History',
      subtitle: 'View past deliveries',
    ),
    _MenuItem(
      icon: Icons.location_on_outlined,
      title: 'Delivery Addresses',
      subtitle: 'Manage saved locations',
      badge: 3,
    ),
    _MenuItem(
      icon: Icons.credit_card_outlined,
      title: 'Payment Methods',
      subtitle: 'Cards and billing',
    ),
    _MenuItem(
      icon: Icons.notifications_outlined,
      title: 'Notifications',
      subtitle: 'Alerts and updates',
    ),
    _MenuItem(
      icon: Icons.settings_outlined,
      title: 'App Settings',
      subtitle: 'Preferences and privacy',
    ),
    _MenuItem(
      icon: Icons.headset_mic_outlined,
      title: 'Help & Support',
      subtitle: 'Contact customer service',
    ),
    _MenuItem(
      icon: Icons.logout,
      title: 'Sign Out',
      subtitle: 'Log out of your account',
      isDestructive: true,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _AppColors.scaffoldBg,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: _AppColors.textDark),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Profile',
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
          _buildProfileCard(),
          const SizedBox(height: 16),
          _buildStatsRow(),
          const SizedBox(height: 16),
          _buildMenuList(context),
          const SizedBox(height: 24),
          _buildVersionTag(),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  // ── Profile Card ───────────────────────────────────────────────────────────

  Widget _buildProfileCard() {
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
          // Avatar + info
          Row(
            children: [
              Stack(
                children: [
                  Container(
                    width: 68,
                    height: 68,
                    decoration: BoxDecoration(
                      color: const Color(0xFFD1D5DB),
                      shape: BoxShape.circle,
                      border: Border.all(color: _AppColors.divider, width: 2),
                    ),
                    child: const Icon(Icons.person, color: Colors.white, size: 40),
                  ),
                  // Camera edit button
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      width: 22,
                      height: 22,
                      decoration: const BoxDecoration(
                        color: _AppColors.primary,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.camera_alt, color: Colors.white, size: 12),
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Marcus Johnson',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: _AppColors.textDark,
                      ),
                    ),
                    const SizedBox(height: 3),
                    const Text(
                      'Construction Manager',
                      style: TextStyle(fontSize: 13, color: _AppColors.textGrey),
                    ),
                    const SizedBox(height: 5),
                    Row(
                      children: const [
                        Icon(Icons.star, color: _AppColors.starYellow, size: 15),
                        SizedBox(width: 4),
                        Text(
                          '4.8 Customer Rating',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: _AppColors.textDark,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),
          const Divider(height: 1, color: _AppColors.divider),
          const SizedBox(height: 14),

          // Phone
          _ContactRow(
            icon: Icons.phone_outlined,
            label: 'Phone',
            value: '+1 (555) 123-4567',
          ),
          const SizedBox(height: 12),
          // Email
          _ContactRow(
            icon: Icons.email_outlined,
            label: 'Email',
            value: 'marcus.j@construction.com',
          ),
        ],
      ),
    );
  }

  // ── Stats Row ──────────────────────────────────────────────────────────────

  Widget _buildStatsRow() {
    return Container(
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
      child: IntrinsicHeight(
        child: Row(
          children: [
            _StatCell(value: '47', label: 'Total Orders', isHighlighted: false),
            _VerticalDivider(),
            _StatCell(value: '\$12.5k', label: 'Total Spent', isHighlighted: true),
            _VerticalDivider(),
            _StatCell(value: '3', label: 'Addresses', isHighlighted: false),
          ],
        ),
      ),
    );
  }

  // ── Menu List ──────────────────────────────────────────────────────────────

  Widget _buildMenuList(BuildContext context) {
    return Container(
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
        children: List.generate(_menuItems.length, (i) {
          final item = _menuItems[i];
          final isLast = i == _menuItems.length - 1;
          return Column(
            children: [
              _MenuTile(
                item: item,
                onTap: () => _onMenuTap(context, item),
              ),
              if (!isLast)
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Divider(height: 1, color: _AppColors.divider),
                ),
            ],
          );
        }),
      ),
    );
  }

  void _onMenuTap(BuildContext context, _MenuItem item) {
    if (item.isDestructive) {
      _showSignOutDialog(context);
    }
    // Navigate to respective pages as needed
  }

  void _showSignOutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        title: const Text(
          'Sign Out?',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
        ),
        content: const Text(
          'Are you sure you want to sign out?',
          style: TextStyle(fontSize: 14, color: _AppColors.textGrey),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel', style: TextStyle(color: _AppColors.textGrey)),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Sign Out', style: TextStyle(color: _AppColors.red)),
          ),
        ],
      ),
    );
  }

  // ── Version Tag ────────────────────────────────────────────────────────────

  Widget _buildVersionTag() {
    return const Center(
      child: Text(
        'BuildMate Delivery v2.1.4',
        style: TextStyle(fontSize: 12, color: _AppColors.textLight),
      ),
    );
  }
}

// ─── Sub Widgets ──────────────────────────────────────────────────────────────

class _ContactRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _ContactRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 38,
          height: 38,
          decoration: BoxDecoration(
            color: _AppColors.primaryLight,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: _AppColors.primary, size: 18),
        ),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: const TextStyle(
                fontSize: 11,
                color: _AppColors.textLight,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              value,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: _AppColors.textDark,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _StatCell extends StatelessWidget {
  final String value;
  final String label;
  final bool isHighlighted;

  const _StatCell({
    required this.value,
    required this.label,
    required this.isHighlighted,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              value,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w800,
                color: isHighlighted ? _AppColors.primary : _AppColors.textDark,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: const TextStyle(fontSize: 11, color: _AppColors.textGrey),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class _VerticalDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1,
      color: _AppColors.divider,
    );
  }
}

class _MenuTile extends StatelessWidget {
  final _MenuItem item;
  final VoidCallback onTap;

  const _MenuTile({required this.item, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final color = item.isDestructive ? _AppColors.red : _AppColors.primary;
    final bgColor = item.isDestructive
        ? const Color(0xFFFFE4E4)
        : _AppColors.primaryLight;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 13),
        child: Row(
          children: [
            // Icon container
            Container(
              width: 38,
              height: 38,
              decoration: BoxDecoration(
                color: bgColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(item.icon, color: color, size: 19),
            ),
            const SizedBox(width: 14),
            // Text
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.title,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: item.isDestructive ? _AppColors.red : _AppColors.textDark,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    item.subtitle,
                    style: const TextStyle(fontSize: 12, color: _AppColors.textGrey),
                  ),
                ],
              ),
            ),
            // Badge or chevron
            if (item.badge != null)
              Container(
                width: 22,
                height: 22,
                margin: const EdgeInsets.only(right: 6),
                decoration: const BoxDecoration(
                  color: _AppColors.primary,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    '${item.badge}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            Icon(
              Icons.chevron_right,
              color: item.isDestructive ? _AppColors.red : _AppColors.textLight,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }
}