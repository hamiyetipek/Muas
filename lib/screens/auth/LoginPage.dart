import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:benim_ilk_uygulamam/screens/auth/RegisterPage.dart';
import 'package:benim_ilk_uygulamam/screens/Anasayfa.dart';
import 'package:benim_ilk_uygulamam/Services/auth_service.dart';
import 'package:benim_ilk_uygulamam/providers/user_provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  String email = '';
  String password = '';
  bool isHovering = false;
  bool isLoading = false;

  void _login() async {
    if (_formKey.currentState!.validate()) {
      setState(() => isLoading = true);

      final api = ApiService();
      final result = await api.login(email, password);

      setState(() => isLoading = false);

      if (result != null && result.containsKey('userId')) {
        final userId = result['userId'];
        final name = result['name'];

        // Kullanıcı bilgilerini Provider'a kaydet
        Provider.of<UserProvider>(context, listen: false)
            .setUser(userId, name);

        // Sayfa geçişi
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const AnasayfaWrapper()),
        );
      } else {
        final error = result?['error'] ?? "Giriş başarısız";
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(error)),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final bool isMobile = screenWidth < 600;

    return Scaffold(
      backgroundColor: Colors.deepPurple.shade50,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.06),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: screenHeight * 0.05),
                Image.asset(
                  'assets/login.png',
                  height: screenHeight * 0.25,
                  fit: BoxFit.contain,
                ),
                SizedBox(height: screenHeight * 0.04),
                Text(
                  "Giriş Yap",
                  style: TextStyle(
                    fontSize: isMobile ? 24 : 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepPurple,
                  ),
                ),
                SizedBox(height: screenHeight * 0.015),
                Text(
                  "Hesabınıza erişmek için bilgilerinizi girin.",
                  style: TextStyle(
                    fontSize: isMobile ? 14 : 16,
                    color: Colors.grey[700],
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: screenHeight * 0.04),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: "Email",
                          filled: true,
                          fillColor: Colors.white,
                          prefixIcon: const Icon(Icons.email),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        onChanged: (val) => email = val,
                        validator: (val) =>
                            val!.isEmpty ? "Email boş olamaz" : null,
                      ),
                      SizedBox(height: screenHeight * 0.02),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: "Şifre",
                          filled: true,
                          fillColor: Colors.white,
                          prefixIcon: const Icon(Icons.lock),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        obscureText: true,
                        onChanged: (val) => password = val,
                        validator: (val) =>
                            val!.isEmpty ? "Şifre boş olamaz" : null,
                      ),
                      SizedBox(height: screenHeight * 0.03),
                      ElevatedButton(
                        onPressed: isLoading ? null : _login,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.deepPurple,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          padding: EdgeInsets.symmetric(
                            vertical: screenHeight * 0.02,
                            horizontal: isMobile ? 60 : 80,
                          ),
                        ),
                        child: isLoading
                            ? const CircularProgressIndicator(
                                color: Colors.white,
                              )
                            : Text(
                                "Giriş Yap",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: isMobile ? 16 : 18,
                                ),
                              ),
                      ),
                      SizedBox(height: screenHeight * 0.02),
                      MouseRegion(
                        cursor: SystemMouseCursors.click,
                        onEnter: (_) => setState(() => isHovering = true),
                        onExit: (_) => setState(() => isHovering = false),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const RegisterPage(),
                              ),
                            );
                          },
                          child: Text(
                            "Üye değil misiniz? Tıklayınız",
                            style: TextStyle(
                              color: isHovering
                                  ? Colors.deepPurple.shade700
                                  : Colors.deepPurple,
                              fontWeight: FontWeight.bold,
                              fontSize: isMobile ? 14 : 16,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
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