import 'package:flutter/material.dart';

class DocumentFilterSheet extends StatelessWidget {
  final String selectedFileType;

  final ValueChanged<String> onSelected;

  const DocumentFilterSheet({
    super.key,
    required this.selectedFileType,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    final List<String> options = [
      'All Types',
      'PDF',
      'DOC',
      'IMAGE',
      'FILE',
    ];

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
              'Filter File Type',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w300,
                color: Color(0xFF2D241D),
              ),
            ),

            const SizedBox(height: 24),

            ...options.map(
              (option) {
                final bool active =
                    selectedFileType == option;

                return GestureDetector(
                  onTap: () {
                    onSelected(option);
                    Navigator.pop(context);
                  },
                  child: Container(
                    margin: const EdgeInsets.only(
                      bottom: 14,
                    ),
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                          BorderRadius.circular(24),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            option,
                            style: const TextStyle(
                              fontSize: 17,
                              color: Color(0xFF2D241D),
                            ),
                          ),
                        ),
                        if (active)
                          const Icon(
                            Icons.check_circle,
                            color: Color(0xFF6E5846),
                          ),
                      ],
                    ),
                  ),
                );
              },
            ),

            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }
}