import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:benim_ilk_uygulamam/models/food_items.dart';

class FoodService {
  final String baseUrl = 'http://127.0.0.1:5203/api/Products';

  /// Kullanıcıya ait ürünleri getirir
  Future<List<FoodItem>> fetchFoodItems(int userId) async {
    final url = Uri.parse('$baseUrl/user/$userId');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((item) => FoodItem.fromJson(item)).toList();
    } else {
      throw Exception('Veri alınamadı: ${response.statusCode}');
    }
  }

  /// Ürün silme işlemi
  Future<bool> deleteFoodItem(int itemId, int userId) async {
    final url = Uri.parse('$baseUrl/$itemId/user/$userId');
    final response = await http.delete(url);
    return response.statusCode == 204;
  }

  /// Yeni ürün ekleme
  Future<bool> createFoodItem(FoodItem item) async {
    final url = Uri.parse(baseUrl);
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'productsid': item.id,
        'user_id': item.userId,
        'pname': item.name,
        'pbrand': item.brand,
        'pbarcode': item.barcode,
        'pexpire_date': item.expireDate.toIso8601String(),
        'pquantity': item.quantity,
        'punit': item.unit,
        'status': item.status,
      }),
    );
    return response.statusCode == 201;
  }

  /// Ürün güncelleme
  Future<bool> updateFoodItem(FoodItem item) async {
    final url = Uri.parse('$baseUrl/${item.id}');
    final response = await http.put(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'productsid': item.id,
        'user_id': item.userId,
        'pname': item.name,
        'pbrand': item.brand,
        'pbarcode': item.barcode,
        'pexpire_date': item.expireDate.toIso8601String(),
        'pquantity': item.quantity,
        'punit': item.unit,
        'status': item.status,
      }),
    );
    return response.statusCode == 200;
  }
}