import 'package:benim_ilk_uygulamam/screens/QrOkutucu.dart';
import 'package:flutter/material.dart';
<<<<<<< HEAD
import 'screens/ShoopingList.dart';  // Sayfanın yolu
=======
import 'screens/Notification.dart'; // Dosya adındaki büyük harfe dikkat et!
import 'screens/israfsayfasi.dart'; // Dosya adındaki büyük harfe dikkat et!
import 'screens/ProfilSayfasi.dart'; // Dosya adındaki büyük harfe dikkat et!
import "package:benim_ilk_uygulamam/screens/food_status_page.dart";
import 'screens/urun_ekleme.dart'; // Dosya adındaki büyük harfe dikkat et!
>>>>>>> db4e26aded2b070ba65667e054ba0a0849c4435e

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
<<<<<<< HEAD
      debugShowCheckedModeBanner: false,
      title: 'Flutter Alışveriş Listesi',
      home: ShoppingListPage(),   // Burada sayfanı çağırdın
=======
      title: 'Flutter Demo',
      home: QrOkutucuSayfasi(), // Burada NotificationPage'i çağırıyoruz
      debugShowCheckedModeBanner: false,

>>>>>>> db4e26aded2b070ba65667e054ba0a0849c4435e
    );
  }
}
