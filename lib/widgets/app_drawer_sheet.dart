import 'package:flutter/material.dart';

import '../screens/documents/documents_screen.dart';
import '../services/onboarding_service.dart';

class AppDrawerSheet
    extends StatelessWidget {

  const AppDrawerSheet({
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    final tabs =
        OnboardingService
            .instance
            .selectedTabs;

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
      height:
          MediaQuery.of(context)
                  .size
                  .height *
              .78,

      decoration: BoxDecoration(
        color:
            const Color(0xFF121212),

        borderRadius:
            const BorderRadius.vertical(
          top: Radius.circular(34),
        ),

        border: Border.all(
          color:
              Colors.white
                  .withOpacity(
            .06,
          ),
        ),
      ),

      child: Padding(
        padding:
            const EdgeInsets.all(
          24,
        ),

        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,

          children: [

            Center(
              child: Container(
                width: 60,
                height: 5,

                decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.circular(
                    20,
                  ),

                  color:
                      Colors.white24,
                ),
              ),
            ),

            const SizedBox(height: 28),

            const Text(
              'All Apps',
              style: TextStyle(
                color: Colors.white,
                fontSize: 30,
                fontWeight:
                    FontWeight.w300,
              ),
            ),

            const SizedBox(height: 8),

            Text(
              'Your personalized Life OS modules',
              style: TextStyle(
                color:
                    Colors.white
                        .withOpacity(
                  .60,
                ),

                fontSize: 14,
              ),
            ),

            const SizedBox(height: 28),

            Expanded(
              child: GridView.builder(
                itemCount:
                    tabs.length + 1,

                gridDelegate:
                    const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,

                  mainAxisSpacing:
                      18,

                  crossAxisSpacing:
                      18,

                  childAspectRatio:
                      .85,
                ),

                itemBuilder:
                    (context, index) {

                  if (index == 0) {
                    return _appTile(
                      icon:
                          Icons.folder_copy_outlined,

                      title:
                          'Documents',

                      onTap: () {

                        Navigator.pop(context);

                        Navigator.push(
                          context,

                          MaterialPageRoute(
                            builder:
                                (_) =>
                                    const DocumentsScreen(),
                          ),
                        );
                      },
                    );
                  }

                  final tabIndex =
                      index - 1;

                  return _appTile(
                    icon:
                        icons[
                            tabIndex %
                                icons.length],

                    title:
                        tabs[tabIndex],

                    onTap: () {},
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _appTile({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {

    return GestureDetector(
      onTap: onTap,

      child: Container(
        decoration: BoxDecoration(
          borderRadius:
              BorderRadius.circular(
            28,
          ),

          color:
              Colors.white
                  .withOpacity(
            .06,
          ),

          border: Border.all(
            color:
                Colors.white
                    .withOpacity(
              .05,
            ),
          ),
        ),

        child: Column(
          mainAxisAlignment:
              MainAxisAlignment.center,

          children: [

            Container(
              height: 60,
              width: 60,

              decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.circular(
                  20,
                ),

                color:
                    Colors.white
                        .withOpacity(
                  .08,
                ),
              ),

              child: Icon(
                icon,
                color: Colors.white,
                size: 28,
              ),
            ),

            const SizedBox(height: 16),

            Padding(
              padding:
                  const EdgeInsets.symmetric(
                horizontal: 8,
              ),

              child: Text(
                title,
                textAlign:
                    TextAlign.center,

                style:
                    const TextStyle(
                  color: Colors.white,
                  fontSize: 13,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}