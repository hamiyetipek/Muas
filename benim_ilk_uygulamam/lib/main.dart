import 'package:flutter/material.dart';
import 'screens/ShoopingList.dart';  // Sayfanın yolu

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Alışveriş Listesi',
      home: ShoppingListPage(),   // Burada sayfanı çağırdın
    );
  }
}
