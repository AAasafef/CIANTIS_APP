import 'package:flutter/material.dart';

class HorizontalCardScroll extends StatelessWidget {
  final List<Widget> children;

  const HorizontalCardScroll({
    super.key,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 170,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,

        physics:
            const BouncingScrollPhysics(),

        itemBuilder: (context, index) {
          return children[index];
        },

        separatorBuilder:
            (context, index) =>
                const SizedBox(width: 16),

        itemCount: children.length,
      ),
    );
  }
}
