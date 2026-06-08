import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

class WelcomeAnimationStep extends StatefulWidget {
  final VoidCallback onComplete;

  const WelcomeAnimationStep({
    super.key,
    required this.onComplete,
  });

  @override
  State<WelcomeAnimationStep> createState() =>
      _WelcomeAnimationStepState();
}

class _WelcomeAnimationStepState
    extends State<WelcomeAnimationStep>
    with TickerProviderStateMixin {
  late final AnimationController glowController;
  late final AnimationController ringController;
  late final AnimationController textController;

  late final Animation<double> glowAnimation;
  late final Animation<double> ringAnimation;
  late final Animation<double> textFadeAnimation;

  Timer? timer;

  bool fadeOut = false;

  @override
  void initState() {
    super.initState();

    glowController = AnimationController(
      vsync: this,
      duration:
          const Duration(milliseconds: 1400),
    );

    ringController = AnimationController(
      vsync: this,
      duration:
          const Duration(milliseconds: 2400),
    );

    textController = AnimationController(
      vsync: this,
      duration:
          const Duration(milliseconds: 1000),
    );

    glowAnimation = CurvedAnimation(
      parent: glowController,
      curve: Curves.easeOut,
    );

    ringAnimation = CurvedAnimation(
      parent: ringController,
      curve: Curves.easeOut,
    );

    textFadeAnimation = CurvedAnimation(
      parent: textController,
      curve: Curves.easeOut,
    );

    glowController.forward();

    Future.delayed(
      const Duration(milliseconds: 650),
      () {
        if (!mounted) return;
        ringController.forward();
      },
    );

    Future.delayed(
      const Duration(milliseconds: 1600),
      () {
        if (!mounted) return;
        textController.forward();
      },
    );

    timer = Timer(
      const Duration(milliseconds: 2700),
      () {
        if (!mounted) return;

        setState(() {
          fadeOut = true;
        });

        Future.delayed(
          const Duration(milliseconds: 650),
          () {
            if (!mounted) return;
            widget.onComplete();
          },
        );
      },
    );
  }

  @override
  void dispose() {
    glowController.dispose();
    ringController.dispose();
    textController.dispose();
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedOpacity(
        duration:
            const Duration(milliseconds: 650),
        curve: Curves.easeInOut,
        opacity: fadeOut ? 0 : 1,
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(
              'assets/images/onboarding/ciantis_welcome_video_bg.png',
              fit: BoxFit.cover,
            ),

            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withOpacity(.18),
                    Colors.black.withOpacity(.22),
                  ],
                ),
              ),
            ),

            AnimatedBuilder(
              animation: Listenable.merge([
                glowController,
                ringController,
                textController,
              ]),
              builder: (context, child) {
                return Stack(
                  children: [
                    Center(
                      child: Container(
                        width: 120 +
                            (glowAnimation.value *
                                40),
                        height: 120 +
                            (glowAnimation.value *
                                40),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.white
                                  .withOpacity(.28),
                              blurRadius: 50 *
                                  glowAnimation.value,
                              spreadRadius: 12 *
                                  glowAnimation.value,
                            ),
                          ],
                        ),
                      ),
                    ),

                    Center(
                      child: CustomPaint(
                        size:
                            const Size(280, 280),
                        painter: _RingPainter(
                          progress:
                              ringAnimation.value,
                        ),
                      ),
                    ),

                    const Center(
                      child: Text(
                        'C',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 70,
                          fontWeight:
                              FontWeight.w300,
                        ),
                      ),
                    ),

                    Positioned(
                      left: 0,
                      right: 0,
                      bottom: 180,
                      child: FadeTransition(
                        opacity:
                            textFadeAnimation,
                        child: const Column(
                          children: [
                            Text(
                              'Welcome to',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 28,
                                fontWeight:
                                    FontWeight.w300,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              'ciantis',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 64,
                                fontWeight:
                                    FontWeight.w300,
                                letterSpacing: 1,
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
          ],
        ),
      ),
    );
  }
}

class _RingPainter extends CustomPainter {
  final double progress;

  _RingPainter({
    required this.progress,
  });

  @override
  void paint(
    Canvas canvas,
    Size size,
  ) {
    final center = Offset(
      size.width / 2,
      size.height / 2,
    );

    final paint = Paint()
      ..color = Colors.white.withOpacity(.35)
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke;

    canvas.drawCircle(
      center,
      60 + (progress * 60),
      paint,
    );

    canvas.drawCircle(
      center,
      90 + (progress * 40),
      paint,
    );

    canvas.drawCircle(
      center,
      120 + (progress * 20),
      paint,
    );

    final sparklePaint = Paint()
      ..color = Colors.white.withOpacity(.8);

    for (int i = 0; i < 20; i++) {
      final angle = (i / 20) * pi * 2;
      final radius =
          100 + (progress * 50);

      final dx =
          center.dx + cos(angle) * radius;
      final dy =
          center.dy + sin(angle) * radius;

      canvas.drawCircle(
        Offset(dx, dy),
        2,
        sparklePaint,
      );
    }
  }

  @override
  bool shouldRepaint(
    covariant CustomPainter oldDelegate,
  ) {
    return true;
  }
}