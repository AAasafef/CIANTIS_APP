import 'package:flutter/material.dart';

import '../screens/documents/document_folders_screen.dart';

class DocumentSecurityBanner extends StatelessWidget {
  const DocumentSecurityBanner({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) =>
                const DocumentFoldersScreen(),
          ),
        );
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(
          20,
        ),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [
              Color(0xFF2D241D),
              Color(0xFF4B3A2D),
            ],
          ),
          borderRadius:
              BorderRadius.circular(
            28,
          ),
        ),
        child: Row(
          children: [
            Container(
              height: 58,
              width: 58,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(
                  .12,
                ),
                borderRadius:
                    BorderRadius.circular(
                  18,
                ),
              ),
              child: const Icon(
                Icons.lock_outline_rounded,
                color: Colors.white,
              ),
            ),
            const SizedBox(
              width: 18,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Secure Documents',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight:
                          FontWeight.w500,
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    'Favorites, secure files, hidden files, and folders.',
                    style: TextStyle(
                      color: Colors.white
                          .withOpacity(.78),
                      fontSize: 13,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios_rounded,
              size: 16,
              color: Colors.white.withOpacity(
                .60,
              ),
            ),
          ],
        ),
      ),
    );
  }
}