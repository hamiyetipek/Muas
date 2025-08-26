import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl = "http://127.0.0.1:5203/api/auth";

  // Register
  Future<String?> register(String ad, String email, String password) async {
    final url = Uri.parse("$baseUrl/register");
    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "ad": ad,
          "email": email,
          "password": password,
        }),
      );

      print("Register response: ${response.statusCode} - ${response.body}");

      if (response.statusCode == 200) {
        return "Kayıt başarılı";
      } else {
        return "Hata: ${response.body}";
      }
    } catch (e) {
      print("Register exception: $e");
      return "Register sırasında hata oluştu";
    }
  }

  // Login
  Future<String?> login(String email, String password) async {
    final url = Uri.parse("$baseUrl/login");
    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "email": email,
          "password": password,
        }),
      );

      print("Login response: ${response.statusCode} - ${response.body}");

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['token']; // JWT token
      } else {
        return "Hata: ${response.body}";
      }
    } catch (e) {
      print("Login exception: $e");
      return "Login sırasında hata oluştu";
    }
  }
}
