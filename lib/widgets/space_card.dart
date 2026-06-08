import 'package:flutter/material.dart';

import '../models/space_model.dart';

class SpaceCard extends StatelessWidget {
  final SpaceModel space;

  final VoidCallback onTap;

  const SpaceCard({
    super.key,
    required this.space,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
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
              space.imagePath,
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
                    .withOpacity(.58),
              ],
            ),
          ),
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment
                    .start,
            children: [
              Row(
                children: [
                  Container(
                    height: 56,
                    width: 56,
                    decoration: BoxDecoration(
                      color: Colors.white
                          .withOpacity(
                        .16,
                      ),
                      borderRadius:
                          BorderRadius.circular(
                        18,
                      ),
                    ),
                    child: Icon(
                      space.icon,
                      color:
                          Colors.white,
                    ),
                  ),

                  const Spacer(),

                  if (space.locked)
                    Container(
                      height: 42,
                      width: 42,
                      decoration:
                          BoxDecoration(
                        color: Colors
                            .white
                            .withOpacity(
                          .16,
                        ),
                        borderRadius:
                            BorderRadius.circular(
                          14,
                        ),
                      ),
                      child: const Icon(
                        Icons.lock_outline,
                        color:
                            Colors.white,
                        size: 20,
                      ),
                    ),
                ],
              ),

              const Spacer(),

              Text(
                space.title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight:
                      FontWeight.w400,
                ),
              ),

              const SizedBox(
                height: 8,
              ),

              Text(
                space.description,
                maxLines: 2,
                overflow:
                    TextOverflow.ellipsis,
                style: TextStyle(
                  color: Colors.white
                      .withOpacity(.82),
                  fontSize: 13,
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}