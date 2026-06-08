class SettingsModel {
  final bool notificationsEnabled;

  final bool darkMode;

  final bool biometricsEnabled;

  final bool soundsEnabled;

  const SettingsModel({
    required this.notificationsEnabled,
    required this.darkMode,
    required this.biometricsEnabled,
    required this.soundsEnabled,
  });

  SettingsModel copyWith({
    bool? notificationsEnabled,
    bool? darkMode,
    bool? biometricsEnabled,
    bool? soundsEnabled,
  }) {
    return SettingsModel(
      notificationsEnabled:
          notificationsEnabled ??
              this.notificationsEnabled,

      darkMode:
          darkMode ?? this.darkMode,

      biometricsEnabled:
          biometricsEnabled ??
              this.biometricsEnabled,

      soundsEnabled:
          soundsEnabled ??
              this.soundsEnabled,
    );
  }
}
