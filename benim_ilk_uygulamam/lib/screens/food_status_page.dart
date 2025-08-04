import 'package:flutter/material.dart';
import '../layouts/ortak.dart'; // OrtakLayout dosyanı kullanıyor

class FoodStatusPage extends StatelessWidget {
  final List<FoodItem> foodItems = [
    FoodItem("Süt", "Son kullanma tarihi geçti!", Colors.red, Icons.block),
    FoodItem("Yoğurt", "Son 2 gün", Colors.orange, Icons.warning),
    FoodItem("Yoğurt", "Son 3 gün", Colors.orange, Icons.warning),
    FoodItem("Ayran", "Son 6 gün", Colors.yellow, Icons.warning_amber),
    FoodItem("Yağ", "Son 7 gün", Colors.lightGreen, Icons.check_circle),
    FoodItem("Kefir", "Son 10 gün", Colors.green, Icons.check_circle),
    FoodItem("Peynir", "Son 12 gün", Colors.green, Icons.check_circle),
    FoodItem("Zeytin", "Son 15 gün", Colors.green, Icons.check_circle),
  ];

  @override
  Widget build(BuildContext context) {
    return OrtakLayout(
      selectedIndex: 0, // Alt bardaki aktif ikon (Anasayfa)
      child: SafeArea(
        child: ListView.builder(
          padding: EdgeInsets.only(bottom: 24),
          itemCount: foodItems.length,
          itemBuilder: (context, index) {
            final item = foodItems[index];
            return Container(
              margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.blue[50],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Icon(item.icon, color: item.color, size: 30),
                  SizedBox(width: 16),
                  Expanded(
                    child: Text(
                      item.name,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Flexible(
                    child: Text(
                      item.status,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: item.color,
                      ),
                      textAlign: TextAlign.right,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class FoodItem {
  final String name;
  final String status;
  final Color color;
  final IconData icon;

  FoodItem(this.name, this.status, this.color, this.icon);
}
