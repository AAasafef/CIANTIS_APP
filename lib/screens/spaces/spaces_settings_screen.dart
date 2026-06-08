import 'package:flutter/material.dart';

import '../../services/spaces_service.dart';

class SpacesSettingsScreen
    extends StatefulWidget {
  const SpacesSettingsScreen({
    super.key,
  });

  @override
  State<SpacesSettingsScreen> createState() =>
      _SpacesSettingsScreenState();
}

class _SpacesSettingsScreenState
    extends State<SpacesSettingsScreen> {
  final spacesService = SpacesService.instance;

  @override
  Widget build(BuildContext context) {
    final spaces = spacesService.spaces;

    return Scaffold(
      backgroundColor: const Color(0xFFF4EFE8),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 20,
          ),
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      height: 48,
                      width: 48,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                            BorderRadius.circular(18),
                      ),
                      child: const Icon(
                        Icons.arrow_back,
                        color: Color(0xFF2D241D),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  const Expanded(
                    child: Text(
                      'Spaces Settings',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.w300,
                        letterSpacing: -.8,
                        color: Color(0xFF2D241D),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              Text(
                'Choose which Spaces appear in your Life OS. You can change this anytime.',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black.withOpacity(.58),
                  height: 1.6,
                ),
              ),

              const SizedBox(height: 28),

              Expanded(
                child: ListView.builder(
                  itemCount: spaces.length,
                  itemBuilder: (context, index) {
                    final space = spaces[index];

                    return Container(
                      margin: const EdgeInsets.only(
                        bottom: 16,
                      ),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                            BorderRadius.circular(26),
                        boxShadow: [
                          BoxShadow(
                            color:
                                Colors.black.withOpacity(.04),
                            blurRadius: 18,
                            offset: const Offset(0, 10),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius:
                                BorderRadius.circular(20),
                            child: Image.asset(
                              space.imagePath,
                              height: 68,
                              width: 68,
                              fit: BoxFit.cover,
                              errorBuilder: (
                                context,
                                error,
                                stackTrace,
                              ) {
                                return Container(
                                  height: 68,
                                  width: 68,
                                  color:
                                      const Color(0xFFF4EFE8),
                                  child: Icon(
                                    space.icon,
                                    color: const Color(
                                      0xFF6E5846,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),

                          const SizedBox(width: 16),

                          Expanded(
                            child: Column(
                              crossAxisAlignment:
                                  CrossAxisAlignment.start,
                              children: [
                                Text(
                                  space.name,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight:
                                        FontWeight.w500,
                                    color: Color(0xFF2D241D),
                                  ),
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  space.selected
                                      ? 'Visible in Spaces'
                                      : 'Hidden',
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: Colors.black
                                        .withOpacity(.55),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          Switch(
                            value: space.selected,
                            activeColor:
                                const Color(0xFF6E5846),
                            onChanged: (_) {
                              setState(() {
                                spacesService.toggleSpace(
                                  space.id,
                                );
                              });
                            },
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}