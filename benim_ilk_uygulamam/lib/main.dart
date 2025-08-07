import 'package:benim_ilk_uygulamam/screens/QrOkutucu.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'screens/Notification.dart'; // Notification page
import 'screens/israfsayfasi.dart'; // İsraf sayfası
import 'screens/ProfilSayfasi.dart'; // Profil sayfası
import 'screens/HakkimizdaSayfasi.dart';
import "package:benim_ilk_uygulamam/screens/food_status_page.dart";
import 'screens/urun_ekleme.dart'; // Ürün ekleme sayfası
import 'package:benim_ilk_uygulamam/screens/Anasayfa.dart';

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
      title: 'Flutter Demo',
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: _isDarkMode ? ThemeMode.dark : ThemeMode.light,
      home: Anasayfa(
        onThemeChanged: _reloadTheme, // <-- Pass the callback
      ), // Burada NotificationPage'i çağırıyoruz
      debugShowCheckedModeBanner: false,
    );
  }
}
