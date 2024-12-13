import 'package:shared_preferences/shared_preferences.dart';

class PrefService {
  static final PrefService _instance = PrefService._internal();

  factory PrefService() {
    return _instance;
  }

  PrefService._internal();

  Future<SharedPreferences> _getPreferences() async {
    return await SharedPreferences.getInstance();
  }

  Future<void> saveSession(String accessToken, String refreshToken,
      String userId, String email) async {
    final prefs = await _getPreferences();
    await prefs.setString('access_token', accessToken);
    await prefs.setString('refresh_token', refreshToken);
    await prefs.setString('user_id', userId);
    await prefs.setString('email', email);
    await prefs.setBool('is_logged_in', true);
  }

  Future<bool> isLoggedIn() async {
    final prefs = await _getPreferences();
    return prefs.getBool('is_logged_in') ?? false;
  }

  Future<Map<String, String?>> getUserData() async {
    final prefs = await _getPreferences();
    String? accessToken = prefs.getString('access_token');
    String? refreshToken = prefs.getString('refresh_token');
    String? userId = prefs.getString('user_id');
    String? email = prefs.getString('email');
    return {
      'access_token': accessToken,
      'refresh_token': refreshToken,
      'user_id': userId,
      'email': email,
    };
  }

  Future<void> clearSession() async {
    final prefs = await _getPreferences();
    await prefs.remove('access_token');
    await prefs.remove('refresh_token');
    await prefs.remove('user_id');
    await prefs.remove('email');
    await prefs.setBool('is_logged_in', false);
  }
}
