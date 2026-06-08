class ProfileModel {
  final String name;

  final String subtitle;

  final String avatarPath;

  const ProfileModel({
    required this.name,
    required this.subtitle,
    required this.avatarPath,
  });

  ProfileModel copyWith({
    String? name,
    String? subtitle,
    String? avatarPath,
  }) {
    return ProfileModel(
      name: name ?? this.name,
      subtitle: subtitle ?? this.subtitle,
      avatarPath:
          avatarPath ?? this.avatarPath,
    );
  }
}
