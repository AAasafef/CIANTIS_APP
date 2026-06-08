class LocalStorageService {
  static final LocalStorageService instance =
      LocalStorageService._internal();

  LocalStorageService._internal();

  final Map<String, dynamic> _memory = {};

  Future<void> saveString(
    String key,
    String value,
  ) async {
    _memory[key] = value;
  }

  Future<String?> getString(
    String key,
  ) async {
    return _memory[key] as String?;
  }

  Future<void> saveBool(
    String key,
    bool value,
  ) async {
    _memory[key] = value;
  }

  Future<bool?> getBool(
    String key,
  ) async {
    return _memory[key] as bool?;
  }

  Future<void> saveInt(
    String key,
    int value,
  ) async {
    _memory[key] = value;
  }

  Future<int?> getInt(
    String key,
  ) async {
    return _memory[key] as int?;
  }

  Future<void> delete(
    String key,
  ) async {
    _memory.remove(key);
  }

  Future<void> clearAll() async {
    _memory.clear();
  }
}
