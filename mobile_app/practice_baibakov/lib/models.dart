import 'package:practice_baibakov/auth/auth.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'settings.dart' as settings;
import 'dart:convert';

class ApiService {
  static final _client = http.Client();

  // Основной метод для выполнения запросов с автоматическим обновлением токена
  static Future<http.Response> _makeRequest(
    Future<http.Response> Function() requestFn,
  ) async {
    // Первая попытка запроса
    final response = await requestFn();

    // Если запрос успешен - возвращаем ответ
    if (response.statusCode == 200) {
      return response;
    }

    // Если ошибка 401 - пробуем обновить токен
    if (response.statusCode == 401) {
      final refreshSuccess = await _refreshToken();
      if (!refreshSuccess) {
        throw Exception('Authentication failed: Unable to refresh token');
      }

      // Повторяем запрос с новым токеном
      final retryResponse = await requestFn();
      if (retryResponse.statusCode == 200) {
        return retryResponse;
      }
      throw Exception('Request failed after token refresh');
    }

    throw Exception('Request failed with status ${response.statusCode}');
  }

  // Метод для обновления токена
  static Future<bool> _refreshToken() async {
    try {
      final refreshToken = await SecureTokenStorage.getRefreshToken();
      if (refreshToken == null) return false;

      final response = await _client.post(
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

  // Метод для получения категорий
  static Future<List<Category>> fetchCategories() async {
    final response = await _makeRequest(() async {
      final token = await SecureTokenStorage.getToken();
      return _client.get(
        Uri.parse('${settings.host}/api/categories/'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );
    });

    return compute(parseCategories, response.body);
  }

  // Метод для получения предложений
  static Future<List<Offer>> fetchOffers() async {
    final response = await _makeRequest(() async {
      final token = await SecureTokenStorage.getToken();
      return _client.get(
        Uri.parse('${settings.host}/api/offers/'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );
    });

    return compute(parseOffers, response.body);
  }
}

List<Category> parseCategories(String responseBody) {
  final parsed =
      (jsonDecode(responseBody) as List).cast<Map<String, dynamic>>();

  return parsed.map<Category>((json) => Category.fromJson(json)).toList();
}

// A function that converts a response body into a List<Photo>.
List<Offer> parseOffers(String responseBody) {
  final parsed =
      (jsonDecode(responseBody) as List).cast<Map<String, dynamic>>();

  return parsed.map<Offer>((json) => Offer.fromJson(json)).toList();
}

class Offer {
  final int id;

  final Partner partner;
  final City city;

  final String buttonName;
  final String url;
  final String whatOfferAbout;
  final String whereToUse;
  final String backImage;
  final String howToGet;
  final DateTime startDate;
  final DateTime endDate;

  const Offer({
    required this.id,
    required this.partner,
    required this.city,
    required this.buttonName,
    required this.url,
    required this.whatOfferAbout,
    required this.whereToUse,
    required this.backImage,
    required this.howToGet,
    required this.startDate,
    required this.endDate,
  });

  factory Offer.fromJson(Map<String, dynamic> json) {
    return Offer(
      id: json['id'] as int,
      partner: Partner.fromJson(json['partner']),
      city: City.fromJson(json['city']),
      buttonName: json['button_name'] as String,
      url: json['url'] as String,
      whatOfferAbout: json['what_offer_about'] as String,
      whereToUse: json['where_to_use'] as String,
      backImage: json['back_image'] as String,
      howToGet: json['how_to_get'] as String,
      startDate: json['start_date'] as DateTime,
      endDate: json['end_date'] as DateTime,
    );
  }
}

class Partner {
  final int id;
  final String title;
  final String logo;
  final String about;

  const Partner({
    required this.id,
    required this.title,
    required this.logo,
    required this.about,
  });

  factory Partner.fromJson(Map<String, dynamic> json) {
    return Partner(
      id: json['id'] as int,
      title: json['title'] as String,
      logo: json['logo'] as String,
      about: json['about'] as String,
    );
  }
}

class City {
  final int id;
  final String name;
  final String country;
  final String region;

  const City({
    required this.id,
    required this.name,
    required this.country,
    required this.region,
  });

  factory City.fromJson(Map<String, dynamic> json) {
    return City(
      id: json['id'] as int,
      name: json['title'] as String,
      country: json['logo'] as String,
      region: json['about'] as String,
    );
  }
}

class Category {
  final int id;
  final String title;
  final String logo;

  const Category({
    required this.id,
    required this.title,
    required this.logo,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'] as int,
      title: json['title'] as String,
      logo: json['logo'] as String,
    );
  }
}
