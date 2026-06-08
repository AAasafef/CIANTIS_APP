import 'package:flutter/material.dart';

import '../../models/space_model.dart';
import 'spiritual_transition_screen.dart';

class SpiritualSpaceScreen extends StatelessWidget {
  final SpaceModel space;

  const SpiritualSpaceScreen({
    super.key,
    required this.space,
  });

  void _exit(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => SpiritualTransitionScreen(
          space: space,
          mode: SpiritualTransitionMode.exit,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F1EA),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 18, 20, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: () => _exit(context),
                    child: Container(
                      height: 44,
                      width: 44,
                      decoration: BoxDecoration(
                        color: const Color(0xFF241D18),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(
                        Icons.arrow_back_rounded,
                        color: Color(0xFFF8F4EE),
                      ),
                    ),
                  ),
                  const Spacer(),
                  const Icon(
                    Icons.auto_awesome_rounded,
                    color: Color(0xFF8E6F55),
                  ),
                ],
              ),
              const SizedBox(height: 28),
              const Text(
                'Good Morning',
                style: TextStyle(
                  color: Color(0xFF8E6F55),
                  fontSize: 14,
                  fontWeight: FontWeight.w300,
                ),
              ),
              const SizedBox(height: 6),
              const Text(
                'Child of God †',
                style: TextStyle(
                  color: Color(0xFF241D18),
                  fontSize: 34,
                  fontWeight: FontWeight.w300,
                  letterSpacing: -.8,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'This is your place of peace, prayer, prophecy, and divine connection.',
                style: TextStyle(
                  color: Color(0xFF6F6258),
                  fontSize: 14,
                  height: 1.5,
                  fontWeight: FontWeight.w300,
                ),
              ),
              const SizedBox(height: 24),
              Container(
                height: 140,
                width: double.infinity,
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18),
                  image: DecorationImage(
                    image: AssetImage(space.imagePath),
                    fit: BoxFit.cover,
                    colorFilter: ColorFilter.mode(
                      Colors.black.withOpacity(.42),
                      BlendMode.darken,
                    ),
                  ),
                ),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Verse of the Day',
                      style: TextStyle(
                        color: Color(0xFFF8F4EE),
                        fontSize: 16,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    Spacer(),
                    Text(
                      '“The Lord is my light and my salvation.”',
                      style: TextStyle(
                        color: Color(0xFFF8F4EE),
                        fontSize: 18,
                        height: 1.35,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Psalm 27:1',
                      style: TextStyle(
                        color: Color(0xFFE8D2A8),
                        fontSize: 12,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              Expanded(
                child: GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 1.45,
                  children: const [
                    _SpiritualTile('Bible Hub', Icons.menu_book_outlined),
                    _SpiritualTile('Prayer Center', Icons.volunteer_activism_outlined),
                    _SpiritualTile('Journal', Icons.edit_note_outlined),
                    _SpiritualTile('Prophetic', Icons.auto_awesome_outlined),
                    _SpiritualTile('Dreams', Icons.nights_stay_outlined),
                    _SpiritualTile('Worship', Icons.music_note_outlined),
                    _SpiritualTile('Deliverance', Icons.shield_outlined),
                    _SpiritualTile('Testimony', Icons.favorite_border),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SpiritualTile extends StatelessWidget {
  final String title;
  final IconData icon;

  const _SpiritualTile(this.title, this.icon);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFFBF8F4),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFFE1D6CA),
          width: .7,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: const Color(0xFF8E6F55),
            size: 24,
          ),
          const SizedBox(height: 10),
          Text(
            title,
            style: const TextStyle(
              color: Color(0xFF241D18),
              fontSize: 13,
              fontWeight: FontWeight.w300,
            ),
          ),
        ],
      ),
    );
  }
}