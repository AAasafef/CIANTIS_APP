import 'package:flutter/material.dart';

import '../documents/documents_screen.dart';

class SpacesHomeScreen
    extends StatelessWidget {
  SpacesHomeScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          const Color(0xFFF4EFE8),

      body: SafeArea(
        child: Padding(
          padding:
              const EdgeInsets.all(
            20,
          ),
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment
                    .start,
            children: [
              const SizedBox(
                height: 10,
              ),

              const Text(
                'Ciantis',
                style: TextStyle(
                  fontSize: 42,
                  fontWeight:
                      FontWeight.w300,
                  letterSpacing: -1,
                  color: Color(
                    0xFF2D241D,
                  ),
                ),
              ),

              const SizedBox(
                height: 8,
              ),

              Text(
                'Your luxury life operating system.',
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.black
                      .withOpacity(
                    .55,
                  ),
                ),
              ),

              const SizedBox(
                height: 34,
              ),

              Expanded(
                child: GridView.count(
                  crossAxisCount: 2,
                  mainAxisSpacing: 18,
                  crossAxisSpacing: 18,
                  childAspectRatio: .92,
                  children: [
                    _spaceCard(
                      context,
                      title:
                          'Documents',
                      icon:
                          Icons.folder_copy_outlined,
                      image:
                          'assets/images/spaces/documents.jpg',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                                const DocumentsScreen(),
                          ),
                        );
                      },
                    ),

                    _spaceCard(
                      context,
                      title:
                          'Reserve',
                      icon:
                          Icons.lock_outline,
                      image:
                          'assets/images/spaces/reserve.jpg',
                      onTap: () {},
                    ),

                    _spaceCard(
                      context,
                      title:
                          'Health',
                      icon:
                          Icons.favorite_outline,
                      image:
                          'assets/images/spaces/health.jpg',
                      onTap: () {},
                    ),

                    _spaceCard(
                      context,
                      title:
                          'Business',
                      icon:
                          Icons.work_outline,
                      image:
                          'assets/images/spaces/business.jpg',
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

  Widget _spaceCard(
    BuildContext context, {
    required String title,
    required IconData icon,
    required String image,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius:
              BorderRadius.circular(
            32,
          ),
          image: DecorationImage(
            image: AssetImage(
              image,
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          padding:
              const EdgeInsets.all(
            20,
          ),
          decoration: BoxDecoration(
            borderRadius:
                BorderRadius.circular(
              32,
            ),
            gradient: LinearGradient(
              begin:
                  Alignment.topCenter,
              end:
                  Alignment.bottomCenter,
              colors: [
                Colors.transparent,
                Colors.black
                    .withOpacity(.55),
              ],
            ),
          ),
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment
                    .start,
            children: [
              Container(
                height: 54,
                width: 54,
                decoration: BoxDecoration(
                  color: Colors.white
                      .withOpacity(.16),
                  borderRadius:
                      BorderRadius.circular(
                    18,
                  ),
                ),
                child: Icon(
                  icon,
                  color:
                      Colors.white,
                ),
              ),

              const Spacer(),

              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight:
                      FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}