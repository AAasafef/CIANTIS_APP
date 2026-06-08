import 'package:flutter/material.dart';

import '../data/app_registry.dart';

class GridMenu extends StatelessWidget {
  const GridMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final gridApps = ciantisApps.where((app) {
      const hiddenSpaces = [
        'Business',
        'Documents',
        'Vault',
        'Spaces',
        'Education',
        'Wellness',
        'Projects',
        'Finances',
      ];

      return !hiddenSpaces.contains(app.title);
    }).toList();

    final recentlyUsedApps = gridApps.take(6).toList();

    return DraggableScrollableSheet(
      initialChildSize: .72,
      minChildSize: .18,
      maxChildSize: .92,
      builder: (context, scrollController) {
        return Container(
          decoration: const BoxDecoration(
            color: Color(0xFFF4EFE8),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
          ),
          child: ListView(
            controller: scrollController,
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.fromLTRB(24, 14, 24, 34),
            children: [
              Center(
                child: Container(
                  height: 5,
                  width: 52,
                  decoration: BoxDecoration(
                    color: const Color(0xFFB8A99D),
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Menu',
                          style: TextStyle(
                            fontSize: 46,
                            height: .95,
                            fontWeight: FontWeight.w300,
                            letterSpacing: -1.5,
                            color: Color(0xFF241D18),
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'QUICK COMMAND CENTER',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w300,
                            letterSpacing: 3,
                            color: Color(0xFF8B7D72),
                          ),
                        ),
                      ],
                    ),
                  ),
                  _MenuTopIconButton(
                    icon: Icons.close_rounded,
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 15,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFFBF8F4).withOpacity(.92),
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(
                    color: const Color(0xFFE2D8CD),
                    width: .7,
                  ),
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.search_rounded,
                      color: Color(0xFF8B6F55),
                      size: 21,
                    ),
                    const SizedBox(width: 12),
                    Text(
                      'Search anything...',
                      style: TextStyle(
                        color: const Color(0xFF6F6258).withOpacity(.72),
                        fontSize: 13,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 22),
              const _SectionTitle(title: 'Recently Used'),
              const SizedBox(height: 12),
              SizedBox(
                height: 76,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  itemCount: recentlyUsedApps.length,
                  separatorBuilder: (context, index) {
                    return const SizedBox(width: 14);
                  },
                  itemBuilder: (context, index) {
                    final app = recentlyUsedApps[index];

                    return _RecentAppCircle(
                      title: app.title,
                      icon: app.icon,
                      onTap: () {
                        Navigator.pop(context);

                        if (app.title == 'Home') {
                          Navigator.popUntil(
                            context,
                            (route) => route.isFirst,
                          );
                          return;
                        }

                        if (app.screen != null) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => app.screen!,
                            ),
                          );
                        }
                      },
                    );
                  },
                ),
              ),
              const SizedBox(height: 22),
              const _SectionTitle(title: 'Tools'),
              const SizedBox(height: 12),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: gridApps.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 5,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 14,
                  childAspectRatio: .68,
                ),
                itemBuilder: (context, index) {
                  final app = gridApps[index];

                  return _MenuTile(
                    title: app.title,
                    icon: app.icon,
                    onTap: () {
                      Navigator.pop(context);

                      if (app.title == 'Home') {
                        Navigator.popUntil(
                          context,
                          (route) => route.isFirst,
                        );
                        return;
                      }

                      if (app.screen != null) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => app.screen!,
                          ),
                        );
                      }
                    },
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}

class _MenuTopIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _MenuTopIconButton({
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 48,
        width: 48,
        decoration: BoxDecoration(
          color: const Color(0xFFFBF8F4).withOpacity(.92),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: const Color(0xFFE2D8CD),
            width: .7,
          ),
        ),
        child: Icon(
          icon,
          color: const Color(0xFF241D18),
          size: 22,
        ),
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;

  const _SectionTitle({
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      title.toUpperCase(),
      style: const TextStyle(
        color: Color(0xFF8B7D72),
        fontSize: 10,
        fontWeight: FontWeight.w300,
        letterSpacing: 2.7,
      ),
    );
  }
}

class _RecentAppCircle extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;

  const _RecentAppCircle({
    required this.title,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 58,
      child: GestureDetector(
        onTap: onTap,
        child: Column(
          children: [
            Container(
              height: 52,
              width: 52,
              decoration: BoxDecoration(
                color: const Color(0xFFFBF8F4).withOpacity(.92),
                shape: BoxShape.circle,
                border: Border.all(
                  color: const Color(0xFFE2D8CD),
                  width: .7,
                ),
              ),
              child: Icon(
                icon,
                color: const Color(0xFF8B6F55),
                size: 21,
              ),
            ),
            const SizedBox(height: 7),
            Text(
              title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Color(0xFF6F6258),
                fontSize: 9,
                fontWeight: FontWeight.w300,
                height: 1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MenuTile extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;

  const _MenuTile({
    required this.title,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: onTap,
          child: Container(
            height: 58,
            width: double.infinity,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: const Color(0xFFFBF8F4).withOpacity(.88),
              borderRadius: BorderRadius.circular(18),
              border: Border.all(
                color: const Color(0xFFE2D8CD),
                width: .7,
              ),
            ),
            child: Icon(
              icon,
              color: const Color(0xFF8B6F55),
              size: 30,
            ),
          ),
        ),
        const SizedBox(height: 7),
        Text(
          title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Color(0xFF6F6258),
            fontSize: 9,
            fontWeight: FontWeight.w300,
            height: 1,
          ),
        ),
      ],
    );
  }
}