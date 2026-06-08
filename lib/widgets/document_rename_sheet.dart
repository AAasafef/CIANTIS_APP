import 'package:flutter/material.dart';

class DocumentRenameSheet extends StatefulWidget {
  final String currentTitle;

  final ValueChanged<String> onRename;

  const DocumentRenameSheet({
    super.key,
    required this.currentTitle,
    required this.onRename,
  });

  @override
  State<DocumentRenameSheet> createState() =>
      _DocumentRenameSheetState();
}

class _DocumentRenameSheetState
    extends State<DocumentRenameSheet> {
  late final TextEditingController controller;

  @override
  void initState() {
    super.initState();

    controller = TextEditingController(
      text: widget.currentTitle,
    );
  }

  @override
  void dispose() {
    controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(
        24,
      ),
      decoration: const BoxDecoration(
        color: Color(0xFFF8F3EC),
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(
            34,
          ),
        ),
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [
            const Text(
              'Rename Document',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w300,
                color: Color(0xFF2D241D),
              ),
            ),

            const SizedBox(height: 14),

            Text(
              'Update the display name for this document.',
              style: TextStyle(
                fontSize: 14,
                height: 1.6,
                color: Colors.black.withOpacity(
                  .58,
                ),
              ),
            ),

            const SizedBox(height: 26),

            Container(
              height: 58,
              padding: const EdgeInsets.symmetric(
                horizontal: 18,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(
                  24,
                ),
              ),
              child: TextField(
                controller: controller,
                style: const TextStyle(
                  color: Color(0xFF2D241D),
                  fontSize: 15,
                ),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Document name',
                  hintStyle: TextStyle(
                    color: Colors.black.withOpacity(
                      .40,
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 28),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  final value =
                      controller.text.trim();

                  if (value.isEmpty) {
                    return;
                  }

                  Navigator.pop(context);

                  widget.onRename(value);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      const Color(0xFF2D241D),
                  padding: const EdgeInsets.symmetric(
                    vertical: 18,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(
                      24,
                    ),
                  ),
                ),
                child: const Text(
                  'Save Name',
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