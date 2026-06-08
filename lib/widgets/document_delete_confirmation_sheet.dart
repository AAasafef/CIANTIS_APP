import 'package:flutter/material.dart';

class DocumentDeleteConfirmationSheet
    extends StatelessWidget {
  final VoidCallback onDelete;

  const DocumentDeleteConfirmationSheet({
    super.key,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: const BoxDecoration(
        color: Color(0xFFF8F3EC),
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(34),
        ),
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [
            const Text(
              'Delete Document?',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w300,
                color: Color(0xFF2D241D),
              ),
            ),

            const SizedBox(height: 14),

            Text(
              'This will remove the document from Ciantis. This action cannot be undone.',
              style: TextStyle(
                fontSize: 14,
                height: 1.6,
                color: Colors.black.withOpacity(.58),
              ),
            ),

            const SizedBox(height: 28),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  onDelete();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      const Color(0xFF2D241D),
                  padding: const EdgeInsets.symmetric(
                    vertical: 18,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(24),
                  ),
                ),
                child: const Text(
                  'Delete Document',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 14),

            SizedBox(
              width: double.infinity,
              child: TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  'Cancel',
                  style: TextStyle(
                    color: Color(0xFF2D241D),
                    fontSize: 15,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}