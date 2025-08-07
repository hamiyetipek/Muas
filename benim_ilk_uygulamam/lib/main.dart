import 'package:benim_ilk_uygulamam/screens/QrOkutucu.dart';
import 'package:flutter/material.dart';
import 'screens/Notification.dart'; // Dosya adındaki büyük harfe dikkat et!
import 'screens/israfsayfasi.dart'; // Dosya adındaki büyük harfe dikkat et!
import 'screens/ProfilSayfasi.dart'; // Dosya adındaki büyük harfe dikkat et!
import "package:benim_ilk_uygulamam/screens/food_status_page.dart";
import 'screens/urun_ekleme.dart'; // Dosya adındaki büyük harfe dikkat et!

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isDarkMode = false;

  @override
  void initState() {
    super.initState();
    _loadTheme();
  }

  void _reloadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _isDarkMode = prefs.getBool('isDarkMode') ?? false;
    });
  }

  _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _isDarkMode = prefs.getBool('isDarkMode') ?? false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
<<<<<<< HEAD
      debugShowCheckedModeBanner: false,
      title: 'Flutter Alışveriş Listesi',
      home: ShoppingListPage(),   // Burada sayfanı çağırdın
=======
      title: 'Flutter Demo',
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: _isDarkMode ? ThemeMode.dark : ThemeMode.light,
      home: AnasayfaWrapper(
        onThemeChanged: _reloadTheme,
      ),
      debugShowCheckedModeBanner: false,

    );
  }
}
