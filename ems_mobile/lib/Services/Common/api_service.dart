import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class ApiService {
  final http.Client _api = http.Client();

  final Map<String, String> _headers = {"Content-Type": "application/json"};
  static const storage = FlutterSecureStorage();

  updateHeader() async {
    final token = await storage.read(key: "token");
    if (token != null) {
      _headers["Authorization"] = "Bearer $token";
    }
  }

  Future<http.Response> get(String url) async {
    await updateHeader();
    try {
      return await _api.get(Uri.parse(url), headers: _headers);
    } catch (e) {
      return http.Response(
          jsonEncode({
            "responseCode": 503,
            "timeStamp": null,
            "responseDescription": "Error while fetching api."
          }),
          503);
    }
  }

  Future<http.Response> post(String url, Map<String, dynamic>? body) async {
    await updateHeader();
    try {
      return await _api.post(Uri.parse(url),
          body: jsonEncode(body), headers: _headers);
    } catch (e) {
      return http.Response(
          jsonEncode({
            "responseCode": 503,
            "timeStamp": null,
            "responseDescription": "Error while fetching api."
          }),
          503);
    }
  }

  Future<http.Response> put(String url, Map<String, dynamic> body) async {
    await updateHeader();
    try {
      return await _api.put(Uri.parse(url),
          body: jsonEncode(body), headers: _headers);
    } catch (e) {
      return http.Response(
          jsonEncode({
            "responseCode": 503,
            "timeStamp": null,
            "responseDescription": "Error while fetching api."
          }),
          503);
    }
  }

  Future<http.Response> delete(String url) async {
    await updateHeader();
    try {
      return await _api.delete(Uri.parse(url), headers: _headers);
    } catch (e) {
      return http.Response(
          jsonEncode({
            "responseCode": 503,
            "timeStamp": null,
            "responseDescription": "Error while fetching api."
          }),
          503);
    }
  }
}
