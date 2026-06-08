import 'package:flutter/material.dart';

import '../../models/space_model.dart';

import '../../widgets/space_header_bar.dart';

class SpaceHomeScreen
    extends StatefulWidget {

  final SpaceModel space;

  const SpaceHomeScreen({
    super.key,
    required this.space,
  });

  @override
  State<SpaceHomeScreen>
      createState() =>
          _SpaceHomeScreenState();
}

class _SpaceHomeScreenState
    extends State<
        SpaceHomeScreen> {

  bool menuOpen = false;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor:
          const Color(
        0xFFF4EFE8,
      ),

      body: Stack(
        children: [

          SafeArea(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 20,
              ),

              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment
                        .start,

                children: [

                  SpaceHeaderBar(
                    title:
                        '${widget.space.name} Space',

                    onMenuTap: () {

                      setState(() {
                        menuOpen =
                            !menuOpen;
                      });
                    },

                    onSettingsTap: () {},
                  ),

                  const SizedBox(
                    height: 26,
                  ),

                  ClipRRect(
                    borderRadius:
                        BorderRadius.circular(
                      30,
                    ),

                    child: SizedBox(
                      height: 240,
                      width:
                          double.infinity,

                      child: Stack(
                        fit: StackFit.expand,

                        children: [

                          Image.asset(
                            widget.space
                                .imagePath,

                            fit:
                                BoxFit.cover,
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
                                    .55,
                                  ),
                                ],
                              ),
                            ),
                          ),

                          Padding(
                            padding:
                                const EdgeInsets.all(
                              24,
                            ),

                            child: Column(
                              crossAxisAlignment:
                                  CrossAxisAlignment
                                      .start,

                              children: [

                                const Spacer(),

                                Text(
                                  widget.space
                                      .name,

                                  style:
                                      const TextStyle(
                                    color: Colors
                                        .white,

                                    fontSize:
                                        38,

                                    fontWeight:
                                        FontWeight
                                            .w300,

                                    letterSpacing:
                                        -1,
                                  ),
                                ),

                                const SizedBox(
                                  height: 12,
                                ),

                                Text(
                                  widget.space
                                      .description,

                                  style:
                                      TextStyle(
                                    color: Colors
                                        .white
                                        .withOpacity(
                                      .75,
                                    ),

                                    fontSize:
                                        14,

                                    height:
                                        1.6,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(
                    height: 28,
                  ),

                  Text(
                    'Overview',

                    style:
                        TextStyle(
                      color:
                          Colors.black
                              .withOpacity(
                        .82,
                      ),

                      fontSize: 26,

                      fontWeight:
                          FontWeight
                              .w300,
                    ),
                  ),

                  const SizedBox(
                    height: 18,
                  ),

                  Expanded(
                    child: GridView.count(
                      crossAxisCount:
                          2,

                      crossAxisSpacing:
                          18,

                      mainAxisSpacing:
                          18,

                      childAspectRatio:
                          .95,

                      children: [

                        _overviewCard(
                          title:
                              'Tasks',

                          subtitle:
                              '4 pending',

                          icon:
                              Icons
                                  .check_circle_outline,
                        ),

                        _overviewCard(
                          title:
                              'Schedule',

                          subtitle:
                              '2 upcoming',

                          icon:
                              Icons
                                  .calendar_month_outlined,
                        ),

                        _overviewCard(
                          title:
                              'Notes',

                          subtitle:
                              '12 saved',

                          icon:
                              Icons
                                  .description_outlined,
                        ),

                        _overviewCard(
                          title:
                              'Focus',

                          subtitle:
                              '82% aligned',

                          icon:
                              Icons
                                  .auto_awesome_outlined,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          if (menuOpen)
            GestureDetector(
              onTap: () {

                setState(() {
                  menuOpen = false;
                });
              },

              child: Container(
                color:
                    Colors.black
                        .withOpacity(
                  .18,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _overviewCard({
    required String title,
    required String subtitle,
    required IconData icon,
  }) {

    return Container(
      padding:
          const EdgeInsets.all(
        20,
      ),

      decoration: BoxDecoration(
        color: Colors.white,

        borderRadius:
            BorderRadius.circular(
          28,
        ),

        boxShadow: [

          BoxShadow(
            color:
                Colors.black
                    .withOpacity(
              .04,
            ),

            blurRadius: 18,

            offset:
                const Offset(
              0,
              10,
            ),
          ),
        ],
      ),

      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment
                .start,

        children: [

          Container(
            height: 50,
            width: 50,

            decoration:
                BoxDecoration(
              borderRadius:
                  BorderRadius.circular(
                18,
              ),

              color:
                  const Color(
                0xFFF4EFE8,
              ),
            ),

            child: Icon(
              icon,

              color:
                  const Color(
                0xFF6E5846,
              ),
            ),
          ),

          const Spacer(),

          Text(
            title,

            style: const TextStyle(
              fontSize: 20,

              fontWeight:
                  FontWeight.w400,

              color:
                  Color(
                0xFF2D241D,
              ),
            ),
          ),

          const SizedBox(
            height: 6,
          ),

          Text(
            subtitle,

            style: TextStyle(
              color:
                  Colors.black
                      .withOpacity(
                .58,
              ),

              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }
}