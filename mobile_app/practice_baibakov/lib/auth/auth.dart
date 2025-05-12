import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import '../settings.dart' as settings;
import 'dart:convert';

class SecureTokenStorage {
  static const _storage = FlutterSecureStorage();

  // Ключи для хранения
  static const _tokenKey = 'jwt_token';
  static const _refreshTokenKey = 'jwt_refresh_token';

  // Сохранение токена доступа
  static Future<void> saveToken(String token) async {
    await _storage.write(key: _tokenKey, value: token);
  }

  // Сохранение refresh-токена
  static Future<void> saveRefreshToken(String refreshToken) async {
    await _storage.write(key: _refreshTokenKey, value: refreshToken);
  }

  // Получение токена доступа
  static Future<String?> getToken() async {
    return await _storage.read(key: _tokenKey);
  }

  // Получение refresh-токена
  static Future<String?> getRefreshToken() async {
    return await _storage.read(key: _refreshTokenKey);
  }

  // Удаление всех токенов (для выхода из системы)
  static Future<void> clearAllTokens() async {
    await _storage.delete(key: _tokenKey);
    await _storage.delete(key: _refreshTokenKey);
  }

  // Проверка наличия токенов
  static Future<bool> hasTokens() async {
    final token = await getToken();
    final refreshToken = await getRefreshToken();
    return token != null && refreshToken != null;
  }
}

class AuthResponse {
  final String token;
  final String refreshToken;

  AuthResponse({required this.token, required this.refreshToken});

  factory AuthResponse.fromJson(Map<String, dynamic> json) {
    return AuthResponse(
      token: json['access'],
      refreshToken: json['refresh'],
    );
  }
}

class AuthService {
  final String baseUrl = '${settings.host}/${settings.authPath}';

  Future<AuthResponse> login(String login, String password) async {
    try {
      final response = await http.post(
        Uri.parse(baseUrl),
        body: jsonEncode({'username': login, 'password': password}),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final authResponse = AuthResponse.fromJson(jsonDecode(response.body));

        // Сохраняем полученные токены
        await SecureTokenStorage.saveToken(authResponse.token);
        await SecureTokenStorage.saveRefreshToken(authResponse.refreshToken);

        return authResponse;
      } else {
        throw Exception('Ошибка авторизации: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Ошибка сети: $e');
    }
  }

  Future<bool> refreshToken() async {
    try {
      final refreshToken = await SecureTokenStorage.getRefreshToken();
      if (refreshToken == null) return false;

      final response = await http.post(
        Uri.parse('${settings.host}/${settings.tokenRefreshPath}'),
        body: jsonEncode({'refresh': refreshToken}),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final newToken = jsonDecode(response.body)['access'];
        await SecureTokenStorage.saveToken(newToken);
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }
}
