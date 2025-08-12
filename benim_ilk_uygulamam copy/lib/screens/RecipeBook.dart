import 'package:flutter/material.dart';
import '../layouts/ortak.dart';

class RecipeBookPage extends StatelessWidget {
  // Örnek tarif başlıkları ve emojileri
  final List<Map<String, String>> tarifler = [
    {'emoji': '🧁', 'isim': 'Kek Tarifi'},
    {'emoji': '🍪', 'isim': 'Kurabiye Tarifi'},
    {'emoji': '🥗', 'isim': 'Kısır Tarifi'},
  ];

  @override
  Widget build(BuildContext context) {
    return OrtakLayout(
      child: SingleChildScrollView(
        // <-- Burada eklendi
        child: Column(
          children: [
            // Sayfa içeriği
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.lightBlue[50],
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "STK’sı yakın ürünler için tarif yaz!",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue[800],
                      ),
                    ),
                    SizedBox(height: 16),
                    Text(
                      "Malzemeler:",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text("• 2 adet domates"),
                    Text("• 1 yemek kaşığı zeytinyağı"),
                    Text("• 1 diş sarımsak"),
                    Text("• Tuz, karabiber"),
                    SizedBox(height: 16),
                    Text(
                      "Hazırlanışı:",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "Domatesleri küçük küçük doğrayın. Tavaya zeytinyağını ekleyin ve sarımsağı soteleyin. Domatesleri ekleyin ve yumuşayana kadar pişirin. Tuz ve karabiber ile tatlandırın.",
                    ),
                    SizedBox(height: 16),
                  ],
                ),
              ),
            ),

            // Tarif Ekle Butonu
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: ElevatedButton.icon(
                onPressed: () {
                  // Tarif ekleme işlemi
                },
                icon: Text("📒✏️",
                    style: TextStyle(fontSize: 18)), // Defter + kalem emoji
                label: Text("Tarif Ekle"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),

            // Önceki tariflerin listesi
            Container(
              width: double.infinity,
              color: Colors.lightBlue[100], // Açık mavi arka plan
              padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Önceki Tarifler",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue[900],
                    ),
                  ),
                  SizedBox(height: 8),

                  // Tarif başlıkları listesi
                  ...tarifler.map((tarif) {
                    return Column(
                      children: [
                        InkWell(
                          onTap: () {
                            // Tarif seçilince yapılacaklar
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: Row(
                              children: [
                                Text(
                                  tarif['emoji']!,
                                  style: TextStyle(fontSize: 22),
                                ),
                                SizedBox(width: 10),
                                Text(
                                  tarif['isim']!,
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.blue[800],
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Divider(color: Colors.blueGrey[200]),
                      ],
                    );
                  }).toList(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
