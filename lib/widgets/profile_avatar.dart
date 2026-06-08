import 'package:flutter/material.dart';

class ProfileAvatar
    extends StatelessWidget {

  final double size;

  final String? imagePath;

  final String initials;

  const ProfileAvatar({
    super.key,
    this.size = 52,
    this.imagePath,
    this.initials = 'SC',
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size,
      width: size,

      decoration: BoxDecoration(
        shape: BoxShape.circle,

        gradient: LinearGradient(
          colors: [

            Colors.white
                .withOpacity(.18),

            Colors.white
                .withOpacity(.06),
          ],
        ),

        border: Border.all(
          color:
              Colors.white
                  .withOpacity(.20),
        ),

        image:
            imagePath != null
                ? DecorationImage(
                    image:
                        AssetImage(
                      imagePath!,
                    ),

                    fit: BoxFit.cover,
                  )
                : null,
      ),

      child:
          imagePath == null
              ? Center(
                  child: Text(
                    initials,

                    style: TextStyle(
                      color: Colors.white,
                      fontSize:
                          size * .26,

                      fontWeight:
                          FontWeight.w500,
                    ),
                  ),
                )
              : null,
    );
  }
}
