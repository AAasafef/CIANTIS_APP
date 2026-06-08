import 'package:flutter/material.dart';

class DocumentFolderCard extends StatelessWidget {
  final String title;
  final int count;
  final IconData icon;
  final VoidCallback onTap;

  const DocumentFolderCard({
    super.key,
    required this.title,
    required this.count,
    required this.icon,
    required this.onTap,
  });

  bool get _isSecureFolder {
    return title.toLowerCase() == 'secure';
  }

  bool get _isHiddenFolder {
    return title.toLowerCase() == 'hidden';
  }

  bool get _isFavoriteFolder {
    return title.toLowerCase() == 'favorites';
  }

  bool get _isRecentFolder {
    return title.toLowerCase() == 'recent';
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(
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
              color: Colors.black.withOpacity(
                .04,
              ),
              blurRadius: 18,
              offset: const Offset(
                0,
                10,
              ),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [
            Container(
              height: 54,
              width: 54,
              decoration: BoxDecoration(
                color: const Color(
                  0xFFF4EFE8,
                ),
                borderRadius:
                    BorderRadius.circular(
                  18,
                ),
              ),
              child: Icon(
                icon,
                color: _isSecureFolder
                    ? const Color(
                        0xFF2D241D,
                      )
                    : _isFavoriteFolder
                        ? const Color(
                            0xFFB08D6D,
                          )
                        : const Color(
                            0xFF6E5846,
                          ),
              ),
            ),

            const Spacer(),

            Row(
              children: [
                Expanded(
                  child: Text(
                    title,
                    maxLines: 1,
                    overflow:
                        TextOverflow
                            .ellipsis,
                    style:
                        const TextStyle(
                      color: Color(
                        0xFF2D241D,
                      ),
                      fontSize: 18,
                      fontWeight:
                          FontWeight.w500,
                    ),
                  ),
                ),

                if (_isSecureFolder)
                  const Icon(
                    Icons.lock_outline,
                    size: 16,
                    color: Color(
                      0xFF2D241D,
                    ),
                  ),

                if (_isHiddenFolder)
                  const Icon(
                    Icons.visibility_off_outlined,
                    size: 16,
                    color: Color(
                      0xFF6E5846,
                    ),
                  ),

                if (_isFavoriteFolder)
                  const Icon(
                    Icons.star_rounded,
                    size: 16,
                    color: Color(
                      0xFFB08D6D,
                    ),
                  ),

                if (_isRecentFolder)
                  const Icon(
                    Icons.history,
                    size: 16,
                    color: Color(
                      0xFF6E5846,
                    ),
                  ),
              ],
            ),

            const SizedBox(
              height: 7,
            ),

            Text(
              '$count files',
              style: TextStyle(
                color: Colors.black
                    .withOpacity(
                  .55,
                ),
                fontSize: 13,
              ),
            ),
          ],
        ),
      ),
    );
  }
}