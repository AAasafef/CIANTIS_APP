import 'package:flutter/material.dart';

class SectionTitle
    extends StatelessWidget {

  final String title;

  final String? actionText;

  final VoidCallback? onActionTap;

  const SectionTitle({
    super.key,
    required this.title,
    this.actionText,
    this.onActionTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [

        Expanded(
          child: Text(
            title,

            style: const TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight:
                  FontWeight.w300,
            ),
          ),
        ),

        if (actionText != null)
          GestureDetector(
            onTap: onActionTap,

            child: Text(
              actionText!,

              style: TextStyle(
                color:
                    Colors.white
                        .withOpacity(
                  .55,
                ),

                fontSize: 13,
              ),
            ),
          ),
      ],
    );
  }
}
