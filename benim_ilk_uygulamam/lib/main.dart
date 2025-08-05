import 'package:benim_ilk_uygulamam/screens/QrOkutucu.dart';
import 'package:flutter/material.dart';
import 'screens/Notification.dart'; // Dosya adındaki büyük harfe dikkat et!
import 'screens/israfsayfasi.dart'; // Dosya adındaki büyük harfe dikkat et!
import 'screens/ProfilSayfasi.dart'; // Dosya adındaki büyük harfe dikkat et!
import "package:benim_ilk_uygulamam/screens/food_status_page.dart";

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: QrOkutucuSayfasi(), // Burada NotificationPage'i çağırıyoruz
      debugShowCheckedModeBanner: false,

    );
  }
}
