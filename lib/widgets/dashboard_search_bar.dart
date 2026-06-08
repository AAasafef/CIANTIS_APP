import 'package:flutter/material.dart';

class DashboardSearchBar
    extends StatelessWidget {

  const DashboardSearchBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 58,

      decoration: BoxDecoration(
        borderRadius:
            BorderRadius.circular(
          22,
        ),

        color:
            Colors.white
                .withOpacity(
          .06,
        ),

        border: Border.all(
          color:
              Colors.white
                  .withOpacity(
            .05,
          ),
        ),
      ),

      child: TextField(
        style: const TextStyle(
          color: Colors.white,
        ),

        decoration: InputDecoration(
          border: InputBorder.none,

          hintText:
              'Search your Life OS',

          hintStyle: TextStyle(
            color:
                Colors.white
                    .withOpacity(
              .45,
            ),
          ),

          prefixIcon: Icon(
            Icons.search,
            color:
                Colors.white
                    .withOpacity(
              .55,
            ),
          ),
        ),
      ),
    );
  }
}
