import 'package:flutter/material.dart';

import 'space_status_chip.dart';

class SpacesGreetingCard
    extends StatelessWidget {
  const SpacesGreetingCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(
        24,
      ),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color(0xFFB08D6D),
            Color(0xFFD8C2AE),
          ],
        ),
        borderRadius:
            BorderRadius.circular(
          34,
        ),
      ),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                height: 60,
                width: 60,
                decoration: BoxDecoration(
                  color: Colors.white
                      .withOpacity(.16),
                  borderRadius:
                      BorderRadius.circular(
                    20,
                  ),
                ),
                child: const Icon(
                  Icons.auto_awesome,
                  color: Colors.white,
                  size: 30,
                ),
              ),

              const Spacer(),

              Container(
                padding:
                    const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: Colors.white
                      .withOpacity(.16),
                  borderRadius:
                      BorderRadius.circular(
                    18,
                  ),
                ),
                child: const Text(
                  'Luxury OS',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight:
                        FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(
            height: 28,
          ),

          const Text(
            'Welcome Back',
            style: TextStyle(
              color: Colors.white,
              fontSize: 34,
              fontWeight:
                  FontWeight.w300,
            ),
          ),

          const SizedBox(
            height: 10,
          ),

          Text(
            'Organize every part of your life beautifully in one connected system.',
            style: TextStyle(
              color: Colors.white
                  .withOpacity(.88),
              fontSize: 15,
              height: 1.6,
            ),
          ),

          const SizedBox(
            height: 24,
          ),

          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: const [
              SpaceStatusChip(
                title:
                    '10 Spaces',
                icon:
                    Icons.grid_view_rounded,
              ),

              SpaceStatusChip(
                title:
                    'Protected',
                icon:
                    Icons.lock_outline,
              ),

              SpaceStatusChip(
                title:
                    'AI Ready',
                icon:
                    Icons.auto_awesome_outlined,
              ),
            ],
          ),
        ],
      ),
    );
  }
}