import 'package:flutter/material.dart';

class SpaceTutorialScreen extends StatefulWidget {
  const SpaceTutorialScreen({
    super.key,
  });

  @override
  State<SpaceTutorialScreen> createState() =>
      _SpaceTutorialScreenState();
}

class _SpaceTutorialScreenState
    extends State<SpaceTutorialScreen> {
  final PageController controller =
      PageController();

  int currentPage = 0;

  final List<Map<String, String>> pages = [
    {
      'title': 'Build Your Life OS',
      'description':
          'Spaces separate every area of life into focused environments so nothing feels cluttered or overwhelming.',
      'image':
          'assets/images/tutorial/tutorial_1.jpg',
    },
    {
      'title': 'Everything Has A Home',
      'description':
          'Family, business, school, finances, journals, goals, documents, health, and more can each live inside their own space.',
      'image':
          'assets/images/tutorial/tutorial_2.jpg',
    },
    {
      'title': 'Grow With You',
      'description':
          'Add, remove, reorder, and customize spaces whenever your life changes.',
      'image':
          'assets/images/tutorial/tutorial_3.jpg',
    },
    {
      'title': 'Create Your World',
      'description':
          'Choose the spaces you want active now. You can always add more later.',
      'image':
          'assets/images/tutorial/tutorial_4.jpg',
    },
  ];

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void nextPage() {
    if (currentPage ==
        pages.length - 1) {
      Navigator.pop(context);
      return;
    }

    controller.nextPage(
      duration: const Duration(
        milliseconds: 420,
      ),
      curve: Curves.easeOutCubic,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          const Color(0xFF111111),
      body: Stack(
        children: [
          PageView.builder(
            controller: controller,
            itemCount: pages.length,
            onPageChanged: (index) {
              setState(() {
                currentPage = index;
              });
            },
            itemBuilder: (
              context,
              index,
            ) {
              final page =
                  pages[index];

              return Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset(
                    page['image']!,
                    fit: BoxFit.cover,
                    errorBuilder: (
                      context,
                      error,
                      stackTrace,
                    ) {
                      return Container(
                        color:
                            const Color(
                          0xFF111111,
                        ),
                      );
                    },
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
                            .12,
                          ),
                          Colors.black
                              .withOpacity(
                            .48,
                          ),
                          Colors.black
                              .withOpacity(
                            .92,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SafeArea(
                    child: Padding(
                      padding:
                          const EdgeInsets
                              .fromLTRB(
                        28,
                        22,
                        28,
                        28,
                      ),
                      child: Column(
                        crossAxisAlignment:
                            CrossAxisAlignment
                                .start,
                        children: [
                          Container(
                            padding:
                                const EdgeInsets.symmetric(
                              horizontal:
                                  14,
                              vertical:
                                  8,
                            ),
                            decoration:
                                BoxDecoration(
                              color: Colors
                                  .white
                                  .withOpacity(
                                .08,
                              ),
                              borderRadius:
                                  BorderRadius.circular(
                                20,
                              ),
                            ),
                            child: Text(
                              'STEP ${index + 1}',
                              style:
                                  TextStyle(
                                color: Colors
                                    .white
                                    .withOpacity(
                                  .78,
                                ),
                                fontSize:
                                    11,
                                letterSpacing:
                                    2,
                              ),
                            ),
                          ),
                          const Spacer(),
                          Text(
                            page['title']!,
                            style:
                                const TextStyle(
                              color:
                                  Colors
                                      .white,
                              fontSize:
                                  44,
                              height:
                                  1,
                              fontWeight:
                                  FontWeight
                                      .w300,
                              letterSpacing:
                                  -1.2,
                            ),
                          ),
                          const SizedBox(
                            height:
                                18,
                          ),
                          Text(
                            page[
                                'description']!,
                            style:
                                TextStyle(
                              color: Colors
                                  .white
                                  .withOpacity(
                                .72,
                              ),
                              fontSize:
                                  15,
                              height:
                                  1.7,
                            ),
                          ),
                          const SizedBox(
                            height:
                                36,
                          ),
                          Row(
                            children:
                                List.generate(
                              pages.length,
                              (
                                dot,
                              ) {
                                return AnimatedContainer(
                                  duration:
                                      const Duration(
                                    milliseconds:
                                        220,
                                  ),
                                  margin:
                                      const EdgeInsets.only(
                                    right:
                                        8,
                                  ),
                                  height:
                                      7,
                                  width: currentPage ==
                                          dot
                                      ? 28
                                      : 7,
                                  decoration:
                                      BoxDecoration(
                                    color: currentPage ==
                                            dot
                                        ? const Color(
                                            0xFFE8D2A8,
                                          )
                                        : Colors
                                            .white
                                            .withOpacity(
                                            .20,
                                          ),
                                    borderRadius:
                                        BorderRadius.circular(
                                      20,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                          const SizedBox(
                            height:
                                36,
                          ),
                          GestureDetector(
                            onTap:
                                nextPage,
                            child:
                                Container(
                              height:
                                  56,
                              width: double
                                  .infinity,
                              decoration:
                                  BoxDecoration(
                                color:
                                    Colors.white,
                                borderRadius:
                                    BorderRadius.circular(
                                  22,
                                ),
                              ),
                              alignment:
                                  Alignment.center,
                              child:
                                  Text(
                                currentPage ==
                                        pages.length -
                                            1
                                    ? 'BEGIN'
                                    : 'NEXT',
                                style:
                                    const TextStyle(
                                  color:
                                      Color(
                                    0xFF2D241D,
                                  ),
                                  fontSize:
                                      15,
                                  fontWeight:
                                      FontWeight
                                          .w700,
                                  letterSpacing:
                                      1,
                                ),
                              ),
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
          Positioned(
            top: 58,
            right: 24,
            child: GestureDetector(
              onTap: () {
                Navigator.pop(
                  context,
                );
              },
              child: Text(
                'Skip',
                style: TextStyle(
                  color: Colors
                      .white
                      .withOpacity(
                    .65,
                  ),
                  fontSize: 14,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}