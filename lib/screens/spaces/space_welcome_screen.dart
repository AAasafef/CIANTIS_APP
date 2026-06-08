import 'package:flutter/material.dart';

import '../../models/space_model.dart';

import 'space_home_screen.dart';

class SpaceWelcomeScreen
    extends StatefulWidget {

  final SpaceModel space;

  const SpaceWelcomeScreen({
    super.key,
    required this.space,
  });

  @override
  State<SpaceWelcomeScreen>
      createState() =>
          _SpaceWelcomeScreenState();
}

class _SpaceWelcomeScreenState
    extends State<
        SpaceWelcomeScreen> {

  double opacity = 1;

  @override
  void initState() {
    super.initState();

    Future.delayed(
      const Duration(
        milliseconds: 900,
      ),
      () {
        if (!mounted) return;

        setState(() {
          opacity = .25;
        });
      },
    );
  }

  void enterSpace() {
    Navigator.pushReplacement(
      context,

      PageRouteBuilder(
        transitionDuration:
            const Duration(
          milliseconds: 650,
        ),

        pageBuilder:
            (
          context,
          animation,
          secondaryAnimation,
        ) {
          return FadeTransition(
            opacity:
                animation,

            child:
                SpaceHomeScreen(
              space:
                  widget.space,
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          Colors.black,

      body: Stack(
        fit: StackFit.expand,

        children: [

          AnimatedOpacity(
            duration:
                const Duration(
              milliseconds: 900,
            ),

            opacity:
                opacity,

            child: Image.asset(
              widget.space.imagePath,
              fit: BoxFit.cover,
            ),
          ),

          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin:
                    Alignment.topCenter,

                end:
                    Alignment.bottomCenter,

                colors: [

                  Colors.black
                      .withOpacity(
                    .15,
                  ),

                  Colors.black
                      .withOpacity(
                    .45,
                  ),

                  Colors.black
                      .withOpacity(
                    .78,
                  ),
                ],
              ),
            ),
          ),

          SafeArea(
            child: Padding(
              padding:
                  const EdgeInsets.all(
                28,
              ),

              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment
                        .start,

                children: [

                  GestureDetector(
                    onTap: () {
                      Navigator.pop(
                        context,
                      );
                    },

                    child: Container(
                      height: 48,
                      width: 48,

                      decoration:
                          BoxDecoration(
                        shape:
                            BoxShape.circle,

                        color: Colors.white
                            .withOpacity(
                          .12,
                        ),
                      ),

                      child: const Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                      ),
                    ),
                  ),

                  const Spacer(),

                  Text(
                    'Welcome to',

                    style: TextStyle(
                      color: Colors.white
                          .withOpacity(
                        .72,
                      ),

                      fontSize: 20,
                      fontWeight:
                          FontWeight.w300,
                    ),
                  ),

                  const SizedBox(
                    height: 8,
                  ),

                  Text(
                    '${widget.space.name} Space',

                    style:
                        const TextStyle(
                      color:
                          Colors.white,

                      fontSize: 42,

                      fontWeight:
                          FontWeight.w300,

                      letterSpacing:
                          -1,
                    ),
                  ),

                  const SizedBox(
                    height: 18,
                  ),

                  Text(
                    widget.space.description,

                    style: TextStyle(
                      color: Colors.white
                          .withOpacity(
                        .68,
                      ),

                      fontSize: 15,

                      height: 1.6,
                    ),
                  ),

                  const SizedBox(
                    height: 36,
                  ),

                  GestureDetector(
                    onTap:
                        enterSpace,

                    child: Text(
                      'ENTER',

                      style: TextStyle(
                        color:
                            const Color(
                          0xFFE8D2A8,
                        ),

                        fontSize: 14,

                        letterSpacing:
                            2.4,

                        shadows: [

                          Shadow(
                            color:
                                const Color(
                              0xFFE8D2A8,
                            ).withOpacity(
                              .55,
                            ),

                            blurRadius:
                                14,
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(
                    height: 40,
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