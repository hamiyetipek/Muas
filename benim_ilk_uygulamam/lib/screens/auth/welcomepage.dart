import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:benim_ilk_uygulamam/screens/auth/LoginPage.dart';
import 'RegisterPage.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // Dinamik boyutlar
    double imageHeight = screenHeight * 0.25;
    double titleFontSize = screenWidth < 600 ? 24 : 30;
    double subtitleFontSize = screenWidth < 600 ? 14 : 18;
    double buttonFontSize = screenWidth < 600 ? 16 : 18;
    double buttonPaddingH = screenWidth < 600 ? 60 : 80;
    double iconSize = screenWidth < 600 ? 24 : 30;

    return Scaffold(
      backgroundColor: Colors.deepPurple.shade50,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.06),
            child: Column(
              children: [
                SizedBox(height: screenHeight * 0.05),
                Image.asset(
                  'assets/resim.png',
                  height: imageHeight,
                  fit: BoxFit.contain,
                ),
                SizedBox(height: screenHeight * 0.04),
                Text(
                  "Hoş Geldiniz",
                  style: TextStyle(
                    fontSize: titleFontSize,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepPurple,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: screenHeight * 0.015),
                Text(
                  "Günlük israf yönetiminizi kolayca yapın.",
                  style: TextStyle(
                    fontSize: subtitleFontSize,
                    color: Colors.grey[700],
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: screenHeight * 0.04),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: EdgeInsets.symmetric(
                      vertical: screenHeight * 0.02,
                      horizontal: buttonPaddingH,
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const LoginPage()),
                    );
                  },
                  child: Text(
                    "Giriş Yap",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: buttonFontSize,
                    ),
                  ),
                ),
                SizedBox(height: screenHeight * 0.02),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple.shade400,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: EdgeInsets.symmetric(
                      vertical: screenHeight * 0.02,
                      horizontal: buttonPaddingH,
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const RegisterPage()),
                    );
                  },
                  child: Text(
                    "Kayıt Ol",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: buttonFontSize,
                    ),
                  ),
                ),
                SizedBox(height: screenHeight * 0.04),
                Text(
                  "Bizi sosyal medyada takip edin",
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: subtitleFontSize,
                  ),
                ),
                SizedBox(height: screenHeight * 0.015),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: const FaIcon(FontAwesomeIcons.facebook),
                      color: Colors.blueAccent,
                      iconSize: iconSize,
                      onPressed: () {
                        // Facebook linki eklenebilir
                      },
                    ),
                    SizedBox(width: screenWidth * 0.05),
                    IconButton(
                      icon: const FaIcon(FontAwesomeIcons.instagram),
                      color: Colors.pinkAccent,
                      iconSize: iconSize,
                      onPressed: () {
                        // Instagram linki eklenebilir
                      },
                    ),
                  ],
                ),
                SizedBox(height: screenHeight * 0.05),
              ],
            ),
          ),
        ),
      ),
    );
  }
}