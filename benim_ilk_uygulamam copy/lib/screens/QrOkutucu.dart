import 'package:flutter/material.dart';
import '../layouts/ortak.dart'; // OrtakLayout dosyanı kullanıyor

class QrOkutucuSayfasi extends StatefulWidget {
  @override
  State<QrOkutucuSayfasi> createState() => _QrOkutucuSayfasiState();
}

class _QrOkutucuSayfasiState extends State<QrOkutucuSayfasi> {
  String urunBilgisi = '';
  TextEditingController sktController = TextEditingController();

  void qrKodOku() {
    // Simülasyon – Gerçek tarama değil
    setState(() {
      urunBilgisi = "Ürün: Süt\nMarka: XYZ\nGramaj: 1L";
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("QR kod okutuldu")),
    );
  }

  void urunEkle() {
    if (urunBilgisi.isNotEmpty && sktController.text.isNotEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Ürün başarıyla eklendi")),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Lütfen tüm alanları doldurun")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return OrtakLayout(
      selectedIndex: 2,
      child: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            SizedBox(height: 20),
            Text(
              "QR OKUTUCU",
              style: TextStyle(
                  fontSize: 24, fontWeight: FontWeight.bold, color: Colors.blue),
            ),
            SizedBox(height: 10),
            InkWell(
              onTap: qrKodOku,
              borderRadius: BorderRadius.circular(8),
              child: MouseRegion(
                cursor: SystemMouseCursors.click,
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  decoration: BoxDecoration(
                    color: Colors.blue[50],
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.blue.shade100,
                        blurRadius: 4,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Text(
                    "QR OKUTMAK İÇİN\nBURAYA TIKLAYINIZ",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.blue[800],
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Icon(Icons.qr_code_scanner, size: 120, color: Colors.black87),
            SizedBox(height: 30),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "ÜRÜN BİLGİLERİ:",
                style: TextStyle(
                    fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87),
              ),
            ),
            SizedBox(height: 10),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.blue[50],
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                urunBilgisi.isEmpty ? "Henüz QR okutulmadı." : urunBilgisi,
                style: TextStyle(fontSize: 16),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: sktController,
              decoration: InputDecoration(
                labelText: "SKT EKLEYİN",
                hintText: "GG/AA/YYYY",
                filled: true,
                fillColor: Color(0xFFFFE4E1), // daha soft pembe
                suffixIcon: Icon(Icons.check_circle, color: Colors.blue),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            SizedBox(height: 30),
            ElevatedButton.icon(
              onPressed: urunEkle,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purple[100],
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
              ),
              icon: Icon(Icons.add),
              label: Text("ÜRÜNÜ EKLE"),
            ),
            SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
