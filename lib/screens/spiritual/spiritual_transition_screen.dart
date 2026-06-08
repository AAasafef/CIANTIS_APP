import 'package:flutter/material.dart';

import '../../models/space_model.dart';
import 'spiritual_space_screen.dart';

enum SpiritualTransitionMode {
  enter,
  exit,
}

class SpiritualTransitionScreen extends StatefulWidget {
  final SpaceModel space;
  final SpiritualTransitionMode mode;

  const SpiritualTransitionScreen({
    super.key,
    required this.space,
    required this.mode,
  });

  @override
  State<SpiritualTransitionScreen> createState() =>
      _SpiritualTransitionScreenState();
}

class _SpiritualTransitionScreenState extends State<SpiritualTransitionScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController controller;

  bool get entering => widget.mode == SpiritualTransitionMode.enter;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2600),
    )..forward();

    Future.delayed(const Duration(milliseconds: 2850), () {
      if (!mounted) return;

      if (entering) {
        Navigator.pushReplacement(
          context,
          PageRouteBuilder(
            transitionDuration: const Duration(milliseconds: 700),
            pageBuilder: (_, animation, __) {
              return FadeTransition(
                opacity: animation,
                child: SpiritualSpaceScreen(space: widget.space),
              );
            },
          ),
        );
      } else {
        Navigator.pop(context);
      }
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  double _ease(double value) {
    return Curves.easeInOutCubic.transform(value.clamp(0.0, 1.0));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: AnimatedBuilder(
        animation: controller,
        builder: (context, child) {
          final raw = controller.value;
          final t = _ease(raw);

          final lightAmount = entering ? t : 1.0 - t;

          final sunTopStart = MediaQuery.of(context).size.height * .355;
          final sunTopEnd = MediaQuery.of(context).size.height * .305;

          final sunTop = entering
              ? sunTopStart - ((sunTopStart - sunTopEnd) * t)
              : sunTopEnd + ((sunTopStart - sunTopEnd) * t);

          final skyWarmth = entering
              ? (.12 + (.30 * t))
              : (.42 - (.30 * t));

          final darkness = entering
              ? (.64 - (.42 * t))
              : (.22 + (.42 * t));

          final glowOpacity = entering
              ? (.08 + (.36 * t))
              : (.44 - (.36 * t));

          return Stack(
            fit: StackFit.expand,
            children: [
              Positioned.fill(
                child: Image.asset(
                  widget.space.imagePath,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Color(0xFF1C1712),
                            Color(0xFF3A2B20),
                            Color(0xFF070605),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),

              Positioned.fill(
                child: Container(
                  color: Colors.black.withOpacity(darkness),
                ),
              ),

              Positioned(
                left: -50,
                right: -50,
                top: sunTop - 130,
                child: IgnorePointer(
                  child: Container(
                    height: 310,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: RadialGradient(
                        colors: [
                          const Color(0xFFFFE8B8).withOpacity(glowOpacity),
                          const Color(0xFFFFC46D).withOpacity(glowOpacity * .56),
                          const Color(0xFFC98545).withOpacity(glowOpacity * .18),
                          Colors.transparent,
                        ],
                        stops: const [
                          .0,
                          .32,
                          .60,
                          1.0,
                        ],
                      ),
                    ),
                  ),
                ),
              ),

              Positioned(
                left: 0,
                right: 0,
                top: sunTop,
                child: IgnorePointer(
                  child: Container(
                    height: 4,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFFFFD58D).withOpacity(
                            entering ? (.08 + (.26 * t)) : (.34 - (.26 * t)),
                          ),
                          blurRadius: 72,
                          spreadRadius: 34,
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        const Color(0xFFFFD8A3).withOpacity(skyWarmth * .22),
                        const Color(0xFFB98557).withOpacity(skyWarmth * .16),
                        Colors.black.withOpacity(.18),
                        Colors.black.withOpacity(.78),
                      ],
                      stops: const [
                        .0,
                        .32,
                        .68,
                        1.0,
                      ],
                    ),
                  ),
                ),
              ),

              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: RadialGradient(
                      center: const Alignment(0, -.38),
                      radius: 1.05,
                      colors: [
                        const Color(0xFFFFE8BD).withOpacity(
                          entering
                              ? (.02 + (.18 * t))
                              : (.20 - (.18 * t)),
                        ),
                        Colors.transparent,
                        Colors.black.withOpacity(.30),
                      ],
                      stops: const [
                        .0,
                        .52,
                        1.0,
                      ],
                    ),
                  ),
                ),
              ),

              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(28, 28, 28, 42),
                  child: Column(
                    children: [
                      const Spacer(),
                      AnimatedOpacity(
                        duration: const Duration(milliseconds: 300),
                        opacity: raw < .08 || raw > .92 ? .0 : 1.0,
                        child: Column(
                          children: [
                            Text(
                              entering
                                  ? 'Entering His Presence'
                                  : 'Leaving In Peace',
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: Color(0xFFF8E8CD),
                                fontSize: 32,
                                fontWeight: FontWeight.w300,
                                letterSpacing: -.7,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              entering
                                  ? 'Let there be light.'
                                  : 'Carry the peace with you.',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white.withOpacity(.68),
                                fontSize: 13,
                                fontWeight: FontWeight.w300,
                                letterSpacing: 1.5,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
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
