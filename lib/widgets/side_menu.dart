import 'package:flutter/material.dart';

import '../models/profile_model.dart';

import '../services/profile_service.dart';

import '../theme/ciantis_theme.dart';

import 'glass_container.dart';
import 'luxury_avatar.dart';
import 'side_menu_item_tile.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({super.key});

  @override
  Widget build(BuildContext context) {

    final ProfileModel profile =
        ProfileService.instance
            .getProfile();

    return Drawer(
      backgroundColor: Colors.transparent,

      child: GlassContainer(
        borderRadius:
            CiantisTheme.radiusDrawer,

        padding: const EdgeInsets.all(
          24,
        ),

        child: SafeArea(
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,

            children: [

              // PROFILE
              Row(
                children: [

                  LuxuryAvatar(
                    imagePath:
                        profile.avatarPath,
                  ),

                  const SizedBox(width: 16),

                  Column(
                    crossAxisAlignment:
                        CrossAxisAlignment
                            .start,

                    children: [

                      Text(
                        profile.name,
                        style:
                            const TextStyle(
                          color:
                              CiantisTheme
                                  .white,
                          fontSize:
                              CiantisTheme
                                  .titleSize,
                          fontWeight:
                              FontWeight
                                  .w300,
                        ),
                      ),

                      const SizedBox(
                        height: 4,
                      ),

                      Text(
                        profile.subtitle,
                        style:
                            const TextStyle(
                          color:
                              CiantisTheme
                                  .whiteSoft,
                          letterSpacing:
                              2,
                          fontSize:
                              12,
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 40),

              Expanded(
                child: ListView(
                  children: [

                    SideMenuItemTile(
                      icon:
                          Icons.home_outlined,
                      title: 'Dashboard',
                      badgeCount: '2',
                      onTap: () {},
                    ),

                    SideMenuItemTile(
                      icon: Icons
                          .notifications_none,
                      title:
                          'Notifications',
                      badgeCount: '5',
                      onTap: () {},
                    ),

                    SideMenuItemTile(
                      icon: Icons
                          .favorite_border,
                      title: 'Goals',
                      onTap: () {},
                    ),

                    SideMenuItemTile(
                      icon: Icons
                          .settings_outlined,
                      title: 'Settings',
                      onTap: () {},
                    ),

                    SideMenuItemTile(
                      icon:
                          Icons.person_outline,
                      title: 'Profile',
                      onTap: () {},
                    ),
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
