import 'dart:convert';
import 'package:http/http.dart' as http;

class UserService {
  final String baseUrl = 'https://localhost:7214/api/Users';

  Future<Map<String, dynamic>?> fetchUser(int userId) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/$userId'));
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Kullanıcı çekilemedi: ${response.statusCode}');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> updateUser(int userId, {String? ad, String? email}) async {
  try {
    // Boş olmayan tüm alanları backend'e yollayacağız
    final body = <String, String>{};
    
    // Kullanıcı adı
    if (ad != null) {
      body['ad'] = ad.isNotEmpty ? ad : '';
    }
    
    // E-posta
    if (email != null) {
      body['email'] = email.isNotEmpty ? email : '';
    }

    // Eğer body hâlâ boşsa güncelleme yapma
    if (body.isEmpty) return false;

    final response = await http.put(
      Uri.parse('$baseUrl/$userId'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(body),
    );

    return response.statusCode == 200;
  } catch (e) {
    rethrow;
  }//burda mail ya da addan birini değiştirmezsek hata vermiyor. Değiştirilmeyen eski halini koruyor.
}


  // Şifre değiştirme
  Future<String?> changePassword(
      int userId, String oldPassword, String newPassword) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/$userId/change-password'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'oldPassword': oldPassword,
          'newPassword': newPassword,
        }),
      );

      if (response.statusCode == 200) {
        return null; // Başarılı
      } else {
        // Backend mesajını döndür
        final data = jsonDecode(response.body);
        return data['message'] ?? 'Şifre değiştirilemedi!';
      }
    } catch (e) {
      return 'Sunucu hatası: ${e.toString()}';
    }
  }
}
