import 'package:flutter/material.dart';

import '../services/onboarding_service.dart';

import 'profile_avatar.dart';
import 'side_menu_tile.dart';

class LuxurySideMenu
    extends StatelessWidget {

  final int selectedIndex;

  final Function(int)
      onItemSelected;

  const LuxurySideMenu({
    super.key,
    required this.selectedIndex,
    required this.onItemSelected,
  });

  @override
  Widget build(BuildContext context) {

    final onboarding =
        OnboardingService.instance;

    final tabs =
        onboarding.selectedTabs;

    final List<IconData> icons = [

      Icons.dashboard_outlined,
      Icons.calendar_month,
      Icons.home_outlined,
      Icons.flag_outlined,
      Icons.repeat,
      Icons.favorite_border,
      Icons.restaurant_menu,
      Icons.attach_money,
      Icons.menu_book_outlined,
      Icons.folder_open_outlined,
    ];

    return Container(
      width: 300,

      decoration: BoxDecoration(
        color:
            const Color(0xFF111111),

        border: Border(
          right: BorderSide(
            color:
                Colors.white
                    .withOpacity(
              .06,
            ),
          ),
        ),
      ),

      child: SafeArea(
        child: Padding(
          padding:
              const EdgeInsets.all(
            20,
          ),

          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,

            children: [

              // PROFILE
              const Row(
                children: [

                  ProfileAvatar(),

                  SizedBox(width: 14),

                  Expanded(
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment
                              .start,

                      children: [

                        Text(
                          'Ciantis',
                          style: TextStyle(
                            color:
                                Colors.white,
                            fontSize: 18,
                            fontWeight:
                                FontWeight
                                    .w300,
                          ),
                        ),

                        SizedBox(height: 4),

                        Text(
                          'Luxury Life OS',
                          style: TextStyle(
                            color:
                                Colors.white54,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 34),

              // TABS
              Expanded(
                child: ListView.builder(
                  itemCount:
                      tabs.length,

                  itemBuilder:
                      (context, index) {

                    return SideMenuTile(
                      title:
                          tabs[index],

                      icon:
                          icons[index %
                              icons.length],

                      active:
                          selectedIndex ==
                              index,

                      onTap: () {
                        onItemSelected(
                          index,
                        );
                      },
                    );
                  },
                ),
              ),

              // SETTINGS
              SideMenuTile(
                title: 'Settings',

                icon: Icons.settings,

                active:
                    selectedIndex ==
                        999,

                onTap: () {
                  onItemSelected(
                    999,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
