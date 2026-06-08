import 'package:flutter/material.dart';

import '../../models/space_model.dart';

import '../../widgets/space_action_card.dart';

import '../../widgets/space_empty_state.dart';

import '../../widgets/space_placeholder_tool_card.dart';

import '../../widgets/space_privacy_banner.dart';

import '../../widgets/space_section_title.dart';

class SpaceDetailScreen
    extends StatelessWidget {
  final SpaceModel space;

  const SpaceDetailScreen({
    super.key,
    required this.space,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          const Color(0xFFF4EFE8),

      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 280,
            pinned: true,
            backgroundColor:
                const Color(
              0xFFF4EFE8,
            ),

            flexibleSpace:
                FlexibleSpaceBar(
              background: Stack(
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
                          Colors
                              .transparent,
                          Colors.black
                              .withOpacity(
                            .65,
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
                      mainAxisAlignment:
                          MainAxisAlignment
                              .end,
                      children: [
                        Container(
                          height: 72,
                          width: 72,
                          decoration:
                              BoxDecoration(
                            color: Colors
                                .white
                                .withOpacity(
                              .18,
                            ),
                            borderRadius:
                                BorderRadius.circular(
                              24,
                            ),
                          ),
                          child: Icon(
                            space.icon,
                            color:
                                Colors.white,
                            size: 34,
                          ),
                        ),

                        const SizedBox(
                          height: 20,
                        ),

                        Text(
                          space.title,
                          style:
                              const TextStyle(
                            color:
                                Colors
                                    .white,
                            fontSize:
                                36,
                            fontWeight:
                                FontWeight
                                    .w300,
                          ),
                        ),

                        const SizedBox(
                          height: 10,
                        ),

                        Text(
                          space.description,
                          style:
                              TextStyle(
                            color: Colors
                                .white
                                .withOpacity(
                              .82,
                            ),
                            fontSize:
                                15,
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

          SliverPadding(
            padding:
                const EdgeInsets.all(
              20,
            ),
            sliver: SliverList(
              delegate:
                  SliverChildListDelegate(
                [
                  SpacePrivacyBanner(
                    locked:
                        space.locked,
                  ),

                  const SizedBox(
                    height: 30,
                  ),

                  const SpaceSectionTitle(
                    title:
                        'Quick Actions',
                  ),

                  const SizedBox(
                    height: 18,
                  ),

                  SizedBox(
                    height: 150,
                    child: ListView(
                      scrollDirection:
                          Axis.horizontal,
                      children: const [
                        SpacePlaceholderToolCard(
                          title:
                              'Add Files',
                          icon:
                              Icons
                                  .upload_file_outlined,
                        ),

                        SizedBox(
                          width: 16,
                        ),

                        SpacePlaceholderToolCard(
                          title:
                              'Search',
                          icon:
                              Icons.search,
                        ),

                        SizedBox(
                          width: 16,
                        ),

                        SpacePlaceholderToolCard(
                          title:
                              'Privacy',
                          icon:
                              Icons
                                  .lock_outline,
                        ),

                        SizedBox(
                          width: 16,
                        ),

                        SpacePlaceholderToolCard(
                          title:
                              'Settings',
                          icon:
                              Icons
                                  .settings_outlined,
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(
                    height: 30,
                  ),

                  const SpaceSectionTitle(
                    title:
                        'Space Features',
                  ),

                  const SizedBox(
                    height: 18,
                  ),

                  SpaceActionCard(
                    title:
                        'Dashboard',
                    subtitle:
                        'Main overview and quick actions.',
                    icon:
                        Icons.dashboard_outlined,
                    onTap: () {},
                  ),

                  const SizedBox(
                    height: 18,
                  ),

                  SpaceActionCard(
                    title:
                        'Files & Uploads',
                    subtitle:
                        'Connected documents and uploads.',
                    icon:
                        Icons.upload_file_outlined,
                    onTap: () {},
                  ),

                  const SizedBox(
                    height: 18,
                  ),

                  SpaceActionCard(
                    title:
                        'Search',
                    subtitle:
                        'Search this space quickly.',
                    icon:
                        Icons.search,
                    onTap: () {},
                  ),

                  const SizedBox(
                    height: 18,
                  ),

                  SpaceActionCard(
                    title:
                        'Space Settings',
                    subtitle:
                        'Future customization and privacy tools.',
                    icon:
                        Icons.settings_outlined,
                    onTap: () {},
                  ),

                  const SizedBox(
                    height: 30,
                  ),

                  const SpaceSectionTitle(
                    title:
                        'Coming Soon',
                  ),

                  const SizedBox(
                    height: 18,
                  ),

                  const SpaceEmptyState(
                    title:
                        'More Features Coming',
                    subtitle:
                        'Advanced tools, uploads, AI systems, dashboards, and organization features will appear here as this space evolves.',
                    icon:
                        Icons.auto_awesome_outlined,
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