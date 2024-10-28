import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {
  static Future<SharedPreferences> _getInstance() async {
    return await SharedPreferences.getInstance();
  }

  // Save String
  static Future<void> setString(String key, String value) async {
    final prefs = await _getInstance();
    await prefs.setString(key, value);
  }

  // Get String
  static Future<String?> getString(String key) async {
    final prefs = await _getInstance();
    return prefs.getString(key);
  }

  // Save int
  static Future<void> setInt(String key, int value) async {
    final prefs = await _getInstance();
    await prefs.setInt(key, value);
  }

  // Get int
  static Future<int?> getInt(String key) async {
    final prefs = await _getInstance();
    return prefs.getInt(key);
  }

  // Save double
  static Future<void> setDouble(String key, double value) async {
    final prefs = await _getInstance();
    await prefs.setDouble(key, value);
  }

  // Get double
  static Future<double?> getDouble(String key) async {
    final prefs = await _getInstance();
    return prefs.getDouble(key);
  }

  // Save bool
  static Future<void> setBool(String key, bool value) async {
    final prefs = await _getInstance();
    await prefs.setBool(key, value);
  }

  // Get bool
  static Future<bool?> getBool(String key) async {
    final prefs = await _getInstance();
    return prefs.getBool(key);
  }

  // Save List<String>
  static Future<void> setStringList(String key, List<String> value) async {
    final prefs = await _getInstance();
    await prefs.setStringList(key, value);
  }

  // Get List<String>
  static Future<List<String>?> getStringList(String key) async {
    final prefs = await _getInstance();
    return prefs.getStringList(key);
  }

  // Remove a key
  static Future<void> remove(String key) async {
    final prefs = await _getInstance();
    await prefs.remove(key);
  }

  // Clear all data
  static Future<void> clear() async {
    final prefs = await _getInstance();
    await prefs.clear();
  }
}
