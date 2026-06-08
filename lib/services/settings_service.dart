import '../models/settings_model.dart';

class SettingsService {
  static final SettingsService instance =
      SettingsService._internal();

  SettingsService._internal();

  SettingsModel _settings =
      const SettingsModel(
    notificationsEnabled: true,
    darkMode: true,
    biometricsEnabled: true,
    soundsEnabled: true,
  );

  SettingsModel getSettings() {
    return _settings;
  }

  void updateSettings(
    SettingsModel settings,
  ) {
    _settings = settings;
  }

  void toggleNotifications(
    bool value,
  ) {
    _settings = _settings.copyWith(
      notificationsEnabled: value,
    );
  }

  void toggleDarkMode(
    bool value,
  ) {
    _settings = _settings.copyWith(
      darkMode: value,
    );
  }

  void toggleBiometrics(
    bool value,
  ) {
    _settings = _settings.copyWith(
      biometricsEnabled: value,
    );
  }

  void toggleSounds(
    bool value,
  ) {
    _settings = _settings.copyWith(
      soundsEnabled: value,
    );
  }
}
