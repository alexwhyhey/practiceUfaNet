import 'dart:io' show Platform;

String getHost() {
  //return "http://192.168.1.71:8000";
  return "http://localhost:8000";
  //return "http://172.20.10.9:8000";
  //return Platform.isIOS ? "http://172.20.10.9:8000" : "http://localhost:8000";
}

final String host = getHost(); // Инициализация при создании
final String apiPath = "api/";
final String authPath = "${apiPath}token/";
final String tokenRefreshPath = "${authPath}refresh/";
final String logoPath = "media/partners/logos/2025/05/ufanet.png";
