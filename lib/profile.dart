import 'dart:math' as math;
import 'package:flutter/material.dart';

// ============================================================
//  🤠  CowboyPoint – Profile Screen  (Western / Cowboy Theme)
// ============================================================

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  // ── Cowboy colour palette ──────────────────────────────────
  static const Color _brown = Color(0xFF7B4A1E); // saddle brown
  static const Color _brownDark = Color(0xFF4E2D0E); // dark leather
  static const Color _tan = Color(0xFFD4A76A); // tan / hay
  static const Color _tanLight = Color(0xFFF5E6CC); // cream parchment
  static const Color _bg = Color(0xFF2C1A0E); // dark wood
  static const Color _bgCard = Color(0xFF3D2510); // medium wood
  static const Color _textLight = Color(0xFFF5E6CC); // parchment text
  static const Color _textMuted = Color(0xFFAA8860); // faded ink
  static const Color _gold = Color(0xFFD4A017); // gold / star
  static const Color _rust = Color(0xFFB74B2A); // rust red
  static const Color _xpGain = Color(0xFF8FBF5E); // green-gold gain
  static const Color _xpLoss = Color(0xFFB74B2A); // rust loss

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bg,
      body: SafeArea(
        child: Column(
          children: [
            _buildAppBar(),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    const SizedBox(height: 14),
                    _buildProfileCard(),
                    const SizedBox(height: 12),
                    _buildMotivationCard(),
                    const SizedBox(height: 12),
                    _buildStreakCard(),
                    const SizedBox(height: 12),
                    _buildAchievementsSection(),
                    const SizedBox(height: 12),
                    _buildTransactionSection(),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
            _buildBottomNav(),
          ],
        ),
      ),
    );
  }

  // ══════════════════════════════════════════════════════════
  //  APP BAR  — "WildPoint" branding + sheriff-star badge bell
  // ══════════════════════════════════════════════════════════
  Widget _buildAppBar() {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFF1E0E05),
        border: Border(
          bottom: BorderSide(color: Color(0xFF7B4A1E), width: 1.5),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          // Sheriff star logo
          _SheriffStarLogo(),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                'WildBrave',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                  color: _gold,
                  letterSpacing: 1.5,
                ),
              ),
              Text(
                'Bounty Hunter Profile',
                style: TextStyle(
                  fontSize: 10,
                  color: _textMuted,
                  letterSpacing: 1.2,
                ),
              ),
            ],
          ),
          const Spacer(),
          // Notification inside wanted-poster style badge
          _WantedBadgeBell(),
        ],
      ),
    );
  }

  // ══════════════════════════════════════════════════════════
  //  PROFILE CARD — cowboy profile photo + Reputation bar
  // ══════════════════════════════════════════════════════════
  Widget _buildProfileCard() {
    const int currentXP = 340;
    const int maxXP = 500;

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: _bgCard,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _brown, width: 1.5),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.5),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
        // Parchment texture overlay via gradient
        gradient: const LinearGradient(
          colors: [Color(0xFF3D2510), Color(0xFF2C1A0E)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Avatar: cowboy profile photo ─────────────────
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                width: 92,
                height: 92,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: _gold, width: 3),
                  boxShadow: [
                    BoxShadow(
                      color: _gold.withOpacity(0.3),
                      blurRadius: 10,
                      spreadRadius: 1,
                    ),
                  ],
                ),
                child: ClipOval(
                  child: Image.asset(
                    'assets/images/MrYee.png',
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Container(
                      color: _brown,
                      child: const Icon(Icons.person, size: 60, color: _gold),
                    ),
                  ),
                ),
              ),
              // Camera button: golden bullet-shell shape
              Positioned(
                bottom: -6,
                right: -6,
                child: Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [_gold, Color(0xFFB8860B)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: _gold.withOpacity(0.5),
                        blurRadius: 6,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.camera_alt_rounded,
                    size: 16,
                    color: _brownDark,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(width: 16),
          // ── Name + rank + Reputation bar ─────────────────
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Text(
                      'Patrick Lamp',
                      style: TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.bold,
                        color: _textLight,
                        letterSpacing: 0.5,
                      ),
                    ),
                    const SizedBox(width: 8),
                    _RankBadge('Rank 4'),
                  ],
                ),
                const SizedBox(height: 4),
                const Text(
                  '🤠  Fastest gun in the West',
                  style: TextStyle(fontSize: 11, color: _textMuted),
                ),
                const SizedBox(height: 10),
                // Reputation points
                RichText(
                  text: const TextSpan(
                    children: [
                      TextSpan(
                        text: '$currentXP REP',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: _gold,
                        ),
                      ),
                      TextSpan(
                        text: '  / $maxXP REP',
                        style: TextStyle(fontSize: 12, color: _textMuted),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 7),
                // Bar – leather-stitched style
                Stack(
                  children: [
                    Container(
                      height: 10,
                      decoration: BoxDecoration(
                        color: _brownDark,
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    FractionallySizedBox(
                      widthFactor: currentXP / maxXP,
                      child: Container(
                        height: 10,
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [_gold, Color(0xFFB8860B)],
                          ),
                          borderRadius: BorderRadius.circular(5),
                          boxShadow: [
                            BoxShadow(
                              color: _gold.withOpacity(0.4),
                              blurRadius: 6,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                const Text(
                  'อีก 160 REP เพื่อเลื่อนเป็น Rank 5',
                  style: TextStyle(fontSize: 11, color: _textMuted),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ══════════════════════════════════════════════════════════
  //  MOTIVATION CARD  — Wanted-poster style
  // ══════════════════════════════════════════════════════════
  Widget _buildMotivationCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _tanLight,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: _brown, width: 2),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.4),
            blurRadius: 8,
            offset: const Offset(2, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          // Sheriff star mascot
          Container(
            width: 64,
            height: 64,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Icon(Icons.star, color: _gold, size: 64),
                const Icon(
                  Icons.local_police_rounded,
                  color: _brownDark,
                  size: 30,
                ),
              ],
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '⭐ WANTED: Legend',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w900,
                    color: _brownDark,
                    letterSpacing: 1.0,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'คุณกำลังสร้างชื่อเสียง\nในดินแดน Wild West!',
                  style: TextStyle(fontSize: 12, color: _brown, height: 1.4),
                ),
              ],
            ),
          ),
          // Horseshoe for luck
          Transform.rotate(
            angle: math.pi / 8,
            child: const Icon(
              Icons.architecture_rounded,
              color: _brown,
              size: 30,
            ),
          ),
        ],
      ),
    );
  }

  // ══════════════════════════════════════════════════════════
  //  STREAK CARD  — campfire + notch/tally marks
  // ══════════════════════════════════════════════════════════
  Widget _buildStreakCard() {
    final List<Map<String, dynamic>> days = [
      {'label': 'จ.', 'done': true},
      {'label': 'อ.', 'done': true},
      {'label': 'พ.', 'done': true},
      {'label': 'พฤ.', 'done': true},
      {'label': 'ศ.', 'done': true},
      {'label': 'ส.', 'done': true},
      {'label': 'อา.', 'done': false},
    ];

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _bgCard,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _brown.withOpacity(0.5), width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  // Campfire diamond icon
                  _DiamondIconCowboy(
                    color: Colors.orange.shade900.withOpacity(0.25),
                    child: const Icon(
                      Icons.local_fire_department,
                      color: Colors.orangeAccent,
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    'Ride streak',
                    style: TextStyle(
                      fontSize: 12,
                      color: _textMuted,
                      letterSpacing: 0.8,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              const Text(
                '8 Days',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w900,
                  color: _textLight,
                ),
              ),
              const Text(
                'Keep ridin\', cowboy! 🤠',
                style: TextStyle(fontSize: 10, color: _textMuted),
              ),
            ],
          ),
          const Spacer(),
          // Tally/notch style day markers
          Column(
            children: [
              Row(
                children: days
                    .map(
                      (d) => Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 2),
                        child: _TallyDot(done: d['done'] as bool),
                      ),
                    )
                    .toList(),
              ),
              const SizedBox(height: 5),
              Row(
                children: days
                    .map(
                      (d) => SizedBox(
                        width: 28,
                        child: Center(
                          child: Text(
                            d['label'] as String,
                            style: const TextStyle(
                              fontSize: 9,
                              color: _textMuted,
                            ),
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ══════════════════════════════════════════════════════════
  //  ACHIEVEMENTS  — Sheriff-star shaped badges
  // ══════════════════════════════════════════════════════════
  Widget _buildAchievementsSection() {
    final List<Map<String, dynamic>> badges = [
      {
        'icon': Icons.agriculture_rounded,
        'label': 'Ranch Starter',
        'color': const Color(0xFFCD7F32),
        'unlocked': true,
      },
      {
        'icon': Icons.shopping_bag_outlined,
        'label': 'Trail Trader',
        'color': const Color(0xFFCD7F32),
        'unlocked': true,
      },
      {
        'icon': Icons.explore_outlined,
        'label': 'Pathfinder',
        'color': const Color(0xFF9E9E9E),
        'unlocked': true,
      },
      {
        'icon': Icons.local_police_rounded,
        'label': 'Sheriff',
        'color': _gold,
        'unlocked': true,
      },
      {
        'icon': Icons.shield_outlined,
        'label': 'Legend',
        'color': const Color(0xFF555555),
        'unlocked': false,
      },
    ];

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              '🏆 Achievements',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
                color: _textLight,
              ),
            ),
            TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
                minimumSize: Size.zero,
              ),
              child: const Text(
                'ดูทั้งหมด >',
                style: TextStyle(color: _gold, fontSize: 12),
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        SizedBox(
          height: 112,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: badges.length,
            separatorBuilder: (_, __) => const SizedBox(width: 14),
            itemBuilder: (context, i) {
              final b = badges[i];
              final unlocked = b['unlocked'] as bool;
              return Column(
                children: [
                  _SheriffBadgeWidget(
                    color: b['color'] as Color,
                    unlocked: unlocked,
                    child: Icon(
                      b['icon'] as IconData,
                      color: unlocked
                          ? b['color'] as Color
                          : const Color(0xFF555555),
                      size: 26,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    b['label'] as String,
                    style: TextStyle(
                      fontSize: 10,
                      color: unlocked ? _textLight : _textMuted,
                      fontWeight: unlocked
                          ? FontWeight.w700
                          : FontWeight.normal,
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }

  // ══════════════════════════════════════════════════════════
  //  TRANSACTION HISTORY  — "Bounty Ledger"
  // ══════════════════════════════════════════════════════════
  Widget _buildTransactionSection() {
    final List<Map<String, dynamic>> transactions = [
      {
        'icon': Icons.qr_code_scanner_rounded,
        'iconBg': const Color(0xFF1E3A1E),
        'iconColor': _xpGain,
        'title': 'สแกน QR code ที่ร้านเฮียหงค์',
        'date': '02/09/2568',
        'time': '14:32',
        'place': 'Cha-ji Saloon',
        'xp': '+10 REP',
        'xpColor': _xpGain,
      },
      {
        'icon': Icons.qr_code_scanner_rounded,
        'iconBg': const Color(0xFF1E3A1E),
        'iconColor': _xpGain,
        'title': 'สแกน QR code ที่ร้านไก่ย่างวิชัยสุรินทร์',
        'date': '01/09/2568',
        'time': '10:18',
        'place': 'Frontier Post',
        'xp': '+5 REP',
        'xpColor': _xpGain,
      },
      {
        'icon': Icons.redeem_rounded,
        'iconBg': const Color(0xFF3A1E0E),
        'iconColor': _rust,
        'title': 'แลกค้อนตอกตะปูตราวู้ดดี้',
        'date': '03/08/2568',
        'time': '17:45',
        'place': 'WildPoint Store',
        'xp': '-40 REP',
        'xpColor': _xpLoss,
      },
      {
        'icon': Icons.auto_awesome_rounded,
        'iconBg': const Color(0xFF2A2010),
        'iconColor': _gold,
        'title': 'โบนัสกิจกรรม แต้ม x2',
        'date': '28/07/2568',
        'time': '09:20',
        'place': 'Rodeo Night',
        'xp': '+40 REP',
        'xpColor': _xpGain,
      },
    ];

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              '📜 Bounty Ledger',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
                color: _textLight,
              ),
            ),
            TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
                minimumSize: Size.zero,
              ),
              child: const Text(
                'ดูทั้งหมด >',
                style: TextStyle(color: _gold, fontSize: 12),
              ),
            ),
          ],
        ),
        Container(
          decoration: BoxDecoration(
            color: _bgCard,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: _brown.withOpacity(0.4), width: 1),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.4),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: ListView.separated(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: transactions.length,
            separatorBuilder: (_, __) => Divider(
              height: 1,
              color: _brown.withOpacity(0.25),
              indent: 70,
              endIndent: 16,
            ),
            itemBuilder: (context, index) {
              final t = transactions[index];
              return Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 12,
                ),
                child: Row(
                  children: [
                    // Slanted/tilted icon box
                    _WesternIconBox(
                      bg: t['iconBg'] as Color,
                      iconColor: t['iconColor'] as Color,
                      icon: t['icon'] as IconData,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            t['title'] as String,
                            style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w700,
                              color: _textLight,
                            ),
                          ),
                          const SizedBox(height: 3),
                          Text(
                            '${t['date']}  ·  ${t['time']}  ·  ${t['place']}',
                            style: const TextStyle(
                              fontSize: 10,
                              color: _textMuted,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          t['xp'] as String,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: t['xpColor'] as Color,
                          ),
                        ),
                        const Icon(
                          Icons.chevron_right,
                          color: _textMuted,
                          size: 18,
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  // ══════════════════════════════════════════════════════════
  //  BOTTOM NAVIGATION BAR  — dark saloon floor style
  // ══════════════════════════════════════════════════════════
  Widget _buildBottomNav() {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF1E0E05),
        border: const Border(
          top: BorderSide(color: Color(0xFF7B4A1E), width: 1.5),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.6),
            blurRadius: 12,
            offset: const Offset(0, -3),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _WesternNavItem(
                icon: Icons.home_rounded,
                label: 'Home',
                selected: false,
              ),
              _WesternNavItem(
                icon: Icons.storefront_rounded,
                label: 'Trading',
                selected: false,
              ),
              _WesternNavItem(
                icon: Icons.qr_code_scanner_rounded,
                label: 'Scan',
                selected: false,
              ),
              _WesternNavItem(
                icon: Icons.person_rounded,
                label: 'Profile',
                selected: true,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ╔══════════════════════════════════════════════════════════╗
//  SUB-WIDGETS
// ╚══════════════════════════════════════════════════════════╝

// ── Sheriff Star Logo ─────────────────────────────────────
class _SheriffStarLogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 42,
      height: 42,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Icon(Icons.star, color: const Color(0xFFD4A017), size: 42),
          const Icon(
            Icons.local_police_rounded,
            color: Color(0xFF1E0E05),
            size: 20,
          ),
        ],
      ),
    );
  }
}

// ── Wanted-Poster Bell Badge ──────────────────────────────
class _WantedBadgeBell extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: const Color(0xFF3D2510),
            borderRadius: BorderRadius.circular(6),
            border: Border.all(color: const Color(0xFF7B4A1E), width: 1.5),
          ),
          child: const Icon(
            Icons.notifications_rounded,
            color: Color(0xFFD4A76A),
            size: 22,
          ),
        ),
        Positioned(
          top: -4,
          right: -4,
          child: Container(
            width: 13,
            height: 13,
            decoration: BoxDecoration(
              color: const Color(0xFFB74B2A),
              shape: BoxShape.circle,
              border: Border.all(color: const Color(0xFF1E0E05), width: 1.5),
            ),
          ),
        ),
      ],
    );
  }
}

// ── Rank Badge (ribbon shape) ─────────────────────────────
class _RankBadge extends StatelessWidget {
  final String label;
  const _RankBadge(this.label);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFD4A017), Color(0xFF9A7210)],
        ),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
          bottomRight: Radius.circular(12),
          bottomLeft: Radius.circular(3),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.star_rounded, size: 11, color: Color(0xFF1E0E05)),
          const SizedBox(width: 3),
          Text(
            label,
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1E0E05),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Tally-notch day dot ───────────────────────────────────
class _TallyDot extends StatelessWidget {
  final bool done;
  const _TallyDot({required this.done});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 22,
      height: 26,
      decoration: BoxDecoration(
        gradient: done
            ? const LinearGradient(
                colors: [Color(0xFFD4A017), Color(0xFF9A7210)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              )
            : null,
        color: done ? null : const Color(0xFF3D2510),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(4),
          topRight: Radius.circular(11),
          bottomLeft: Radius.circular(11),
          bottomRight: Radius.circular(4),
        ),
        border: Border.all(
          color: done ? const Color(0xFFD4A017) : const Color(0xFF5A3A1E),
          width: 1,
        ),
        boxShadow: done
            ? [
                BoxShadow(
                  color: const Color(0xFFD4A017).withOpacity(0.35),
                  blurRadius: 4,
                ),
              ]
            : null,
      ),
      child: done
          ? const Icon(Icons.check_rounded, color: Color(0xFF1E0E05), size: 14)
          : null,
    );
  }
}

// ── Diamond icon container for streak ────────────────────
class _DiamondIconCowboy extends StatelessWidget {
  final Color color;
  final Widget child;
  const _DiamondIconCowboy({required this.color, required this.child});

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: math.pi / 4,
      child: Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Transform.rotate(angle: -math.pi / 4, child: child),
      ),
    );
  }
}

// ── Sheriff badge (hexagon-ish star) achievement ─────────
class _SheriffBadgeWidget extends StatelessWidget {
  final Color color;
  final bool unlocked;
  final Widget child;
  const _SheriffBadgeWidget({
    required this.color,
    required this.unlocked,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 68,
      height: 68,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Icon(
            Icons.star,
            size: 68,
            color: unlocked ? color.withOpacity(0.18) : const Color(0xFF2A1A0A),
          ),
          Container(
            width: 46,
            height: 46,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: unlocked ? color : const Color(0xFF4A3A2A),
                width: 2,
              ),
              color: unlocked ? color.withOpacity(0.1) : Colors.transparent,
            ),
            child: Center(child: child),
          ),
          if (!unlocked)
            const Icon(Icons.lock, color: Color(0xFF4A3A2A), size: 16),
        ],
      ),
    );
  }
}

// ── Slanted transaction icon box ─────────────────────────
class _WesternIconBox extends StatelessWidget {
  final Color bg;
  final Color iconColor;
  final IconData icon;
  const _WesternIconBox({
    required this.bg,
    required this.iconColor,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Transform(
      transform: Matrix4.skewX(-0.15),
      child: Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: iconColor.withOpacity(0.3), width: 1),
        ),
        child: Transform(
          transform: Matrix4.skewX(0.15),
          child: Icon(icon, color: iconColor, size: 22),
        ),
      ),
    );
  }
}

// ── Pill bottom nav item ──────────────────────────────────
class _WesternNavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool selected;
  const _WesternNavItem({
    required this.icon,
    required this.label,
    required this.selected,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.symmetric(
          horizontal: selected ? 14 : 8,
          vertical: 6,
        ),
        decoration: BoxDecoration(
          color: selected
              ? const Color(0xFFD4A017).withOpacity(0.18)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(30),
          border: selected
              ? Border.all(
                  color: const Color(0xFFD4A017).withOpacity(0.4),
                  width: 1,
                )
              : null,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: selected
                  ? const Color(0xFFD4A017)
                  : const Color(0xFF7B4A1E),
              size: 24,
            ),
            if (selected) ...[
              const SizedBox(width: 5),
              Text(
                label,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFD4A017),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
