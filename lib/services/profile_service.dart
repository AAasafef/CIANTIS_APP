import '../models/profile_model.dart';

class ProfileService {
  static final ProfileService instance =
      ProfileService._internal();

  ProfileService._internal();

  ProfileModel _profile =
      const ProfileModel(
    name: 'Shaverian',
    subtitle: 'I\'M BUILDING',
    avatarPath: '',
  );

  ProfileModel getProfile() {
    return _profile;
  }

  void updateProfile(
    ProfileModel profile,
  ) {
    _profile = profile;
  }

  void updateName(
    String name,
  ) {
    _profile = _profile.copyWith(
      name: name,
    );
  }

  void updateSubtitle(
    String subtitle,
  ) {
    _profile = _profile.copyWith(
      subtitle: subtitle,
    );
  }

  void updateAvatar(
    String avatarPath,
  ) {
    _profile = _profile.copyWith(
      avatarPath: avatarPath,
    );
  }
}
