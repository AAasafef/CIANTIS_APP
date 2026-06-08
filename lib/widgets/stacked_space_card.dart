import 'package:flutter/material.dart';

import '../models/space_model.dart';

import 'space_preview_overlay.dart';

class StackedSpaceCard
    extends StatelessWidget {

  final SpaceModel space;

  final bool expanded;

  final VoidCallback onTap;

  final VoidCallback onEnter;

  const StackedSpaceCard({
    super.key,
    required this.space,
    required this.expanded,
    required this.onTap,
    required this.onEnter,
  });

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: onTap,

      child: AnimatedContainer(
        duration:
            const Duration(
          milliseconds: 260,
        ),

        curve:
            Curves.easeInOut,

        height:
            expanded
                ? 255
                : 170,

        decoration: BoxDecoration(
          borderRadius:
              BorderRadius.circular(
            34,
          ),

          boxShadow: [

            BoxShadow(
              color:
                  Colors.black
                      .withOpacity(
                .18,
              ),

              blurRadius: 24,

              offset:
                  const Offset(
                0,
                14,
              ),
            ),
          ],
        ),

        child: ClipRRect(
          borderRadius:
              BorderRadius.circular(
            34,
          ),

          child: Stack(
            fit: StackFit.expand,

            children: [

              Image.asset(
                space.imagePath,

                fit: BoxFit.cover,
              ),

              Container(
                decoration:
                    BoxDecoration(
                  gradient:
                      LinearGradient(
                    begin:
                        Alignment
                            .topCenter,

                    end:
                        Alignment
                            .bottomCenter,

                    colors: [

                      Colors.black
                          .withOpacity(
                        .05,
                      ),

                      Colors.black
                          .withOpacity(
                        .38,
                      ),

                      Colors.black
                          .withOpacity(
                        .72,
                      ),
                    ],
                  ),
                ),
              ),

              Padding(
                padding:
                    const EdgeInsets.all(
                  22,
                ),

                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment
                          .start,

                  children: [

                    const Spacer(),

                    Text(
                      '${space.name} Space',

                      style:
                          const TextStyle(
                        color:
                            Colors.white,

                        fontSize: 28,

                        fontWeight:
                            FontWeight
                                .w300,

                        letterSpacing:
                            -.3,
                      ),
                    ),

                    if (expanded) ...[

                      const SizedBox(
                        height: 10,
                      ),

                      Text(
                        space.description,

                        maxLines: 2,

                        overflow:
                            TextOverflow
                                .ellipsis,

                        style:
                            TextStyle(
                          color:
                              Colors.white
                                  .withOpacity(
                            .72,
                          ),

                          fontSize:
                              13,

                          height:
                              1.5,
                        ),
                      ),

                      const SizedBox(
                        height: 16,
                      ),

                      const SpacePreviewOverlay(
                        updates: 3,
                        overdue: 1,
                        stress: .42,
                      ),

                      const SizedBox(
                        height: 18,
                      ),

                      GestureDetector(
                        onTap: onEnter,

                        child: Text(
                          'Enter Space',

                          style:
                              TextStyle(
                            color:
                                const Color(
                              0xFFE8D2A8,
                            ),

                            fontSize:
                                14,

                            fontWeight:
                                FontWeight
                                    .w400,

                            letterSpacing:
                                1.4,

                            shadows: [

                              Shadow(
                                color:
                                    const Color(
                                  0xFFE8D2A8,
                                ).withOpacity(
                                  .55,
                                ),

                                blurRadius:
                                    12,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
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