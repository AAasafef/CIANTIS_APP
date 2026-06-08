import 'package:flutter/material.dart';

import '../../models/profile_model.dart';

import '../../services/profile_service.dart';

import '../../widgets/ciantis_screen_shell.dart';
import '../../widgets/luxury_avatar.dart';
import '../../widgets/luxury_button.dart';
import '../../widgets/luxury_page_padding.dart';
import '../../widgets/luxury_scroll_view.dart';
import '../../widgets/luxury_section_spacing.dart';
import '../../widgets/luxury_text_field.dart';
import '../../widgets/page_header.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() =>
      _ProfileScreenState();
}

class _ProfileScreenState
    extends State<ProfileScreen> {

  late TextEditingController
      nameController;

  late TextEditingController
      subtitleController;

  late ProfileModel profile;

  @override
  void initState() {
    super.initState();

    profile =
        ProfileService.instance
            .getProfile();

    nameController =
        TextEditingController(
      text: profile.name,
    );

    subtitleController =
        TextEditingController(
      text: profile.subtitle,
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    subtitleController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CiantisScreenShell(
      child: LuxuryPagePadding(
        child: LuxuryScrollView(
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [

              // HEADER
              const PageHeader(
                title: 'Profile',
                subtitle:
                    'Customize your identity and luxury experience.',
              ),

              const LuxurySectionSpacing(),

              // AVATAR
              Center(
                child: LuxuryAvatar(
                  radius: 55,
                  imagePath:
                      profile.avatarPath,
                ),
              ),

              const LuxurySectionSpacing(),

              // NAME
              LuxuryTextField(
                hintText: 'Name',
                icon: Icons.person_outline,
              ),

              const LuxurySectionSpacing(),

              // SUBTITLE
              LuxuryTextField(
                hintText: 'Subtitle',
                icon: Icons.edit_outlined,
              ),

              const LuxurySectionSpacing(
                height: 36,
              ),

              // SAVE BUTTON
              LuxuryButton(
                text: 'Save Profile',
                icon: Icons.save_outlined,
                onPressed: () {

                  ProfileService.instance
                      .updateProfile(
                    profile.copyWith(
                      name:
                          nameController
                              .text,

                      subtitle:
                          subtitleController
                              .text,
                    ),
                  );

                  setState(() {
                    profile =
                        ProfileService
                            .instance
                            .getProfile();
                  });
                },
              ),

              const LuxurySectionSpacing(
                height: 120,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
