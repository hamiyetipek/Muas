import 'package:flutter/material.dart';

class FoodItem {
  final int id;
  final int userId;
  final String name;
  final String brand;
  final String barcode;
  final DateTime expireDate;
  final double quantity;
  final String unit;
  final DateTime createdAt;
  final String status;
  final Color color;
  final IconData icon;

  FoodItem({
    required this.id,
    required this.userId,
    required this.name,
    required this.brand,
    required this.barcode,
    required this.expireDate,
    required this.quantity,
    required this.unit,
    required this.createdAt,
    required this.status,
    required this.color,
    required this.icon,
  });

  factory FoodItem.fromJson(Map<String, dynamic> json) {
    final expireDate =
        DateTime.tryParse(json['pExpireDate'] ?? '') ?? DateTime.now();
    final now = DateTime.now();
    final daysLeft = expireDate.difference(now).inDays;

    String status;
    Color color;
    IconData icon;

    if (daysLeft < 0) {
      status = 'Son 0 gün';
      color = Colors.red;
      icon = Icons.block;
    } else if (daysLeft <= 2) {
      status = 'Son $daysLeft gün';
      color = Colors.orange;
      icon = Icons.warning;
    } else if (daysLeft <= 6) {
      status = 'Son $daysLeft gün';
      color = Colors.yellow;
      icon = Icons.warning_amber;
    } else {
      status = '$daysLeft gün';
      color = Colors.green;
      icon = Icons.check_circle;
    }

    return FoodItem(
      id: json['productsId'] ?? 0,
      userId: json['userId'] ?? 0,
      name: json['pName'] ?? 'Ürün',
      brand: json['pBrand'] ?? '',
      barcode: json['pBarcode'] ?? '',
      expireDate: expireDate,
      quantity: (json['pQuantity'] is num)
          ? json['pQuantity'].toDouble()
          : double.tryParse(json['pQuantity'].toString()) ?? 0,
      unit: json['pUnit'] ?? '',
      createdAt: DateTime.tryParse(json['pCreatedAt'] ?? '') ?? DateTime.now(),
      status: status,
      color: color,
      icon: icon,
    );
  }
}
