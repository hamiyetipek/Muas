import 'package:flutter/material.dart';
import 'screens/Notification.dart'; // Dosya adındaki büyük harfe dikkat et!
import "package:benim_ilk_uygulamam/screens/food_status_page.dart";

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: NotificationPage(), // Burada NotificationPage'i çağırıyoruz
    );
  }
}
