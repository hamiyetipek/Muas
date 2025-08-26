import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../layouts/ortak.dart';
import 'package:benim_ilk_uygulamam/screens/Ayarlar.dart';
import 'package:benim_ilk_uygulamam/screens/RecipeBook.dart'; 
import 'package:benim_ilk_uygulamam/screens/auth/LoginPage.dart';


class ProfilSayfasi extends StatefulWidget {
  const ProfilSayfasi({Key? key}) : super(key: key);

  @override
  State<ProfilSayfasi> createState() => _ProfilSayfasiState();
}

class _ProfilSayfasiState extends State<ProfilSayfasi> {
  String kullaniciAdi = "";
  String eposta = "";

  bool isEditingAdi = false;
  bool isEditingEmail = false;

  final TextEditingController _adController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  final int userId = 1; // Test için kullanıcı ID
  final String baseUrl = 'https://localhost:7214/api/Users';

  @override
  void initState() {
    super.initState();
    _fetchUser();
  }

  Future<void> _fetchUser() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/$userId'));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          kullaniciAdi = data['ad'];
          eposta = data['email'];
          _adController.text = kullaniciAdi;
          _emailController.text = eposta;
        });
      } else {
        debugPrint('Kullanıcı çekilemedi: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('Hata: $e');
    }
  }

  // Alan bazlı güncelleme: sadece gönderilen alan backend'e yollanır
  Future<void> _updateUser({String? ad, String? email}) async {
    try {
      final body = <String, String>{};
      if (ad != null && ad.isNotEmpty) body['ad'] = ad;
      if (email != null && email.isNotEmpty) body['email'] = email;

      if (body.isEmpty) return; // boş istek gönderme

      final response = await http.put(
        Uri.parse('$baseUrl/$userId'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(body),
      );

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('Profil güncellendi!')));
        _fetchUser();
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Hata: ${response.body}')));
      }
    } catch (e) {
      debugPrint('Hata: $e');
    }
  }

  Future<void> _changePasswordDialog() async {
    final oldPasswordController = TextEditingController();
    final newPasswordController = TextEditingController();

    await showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Şifre Değiştir'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: oldPasswordController,
              decoration: const InputDecoration(labelText: 'Eski Şifre'),
              obscureText: true,
            ),
            TextField(
              controller: newPasswordController,
              decoration: const InputDecoration(labelText: 'Yeni Şifre'),
              obscureText: true,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('İptal'),
          ),
          ElevatedButton(
            onPressed: () async {
              try {
                final response = await http.post(
                  Uri.parse('$baseUrl/$userId/change-password'),
                  headers: {'Content-Type': 'application/json'},
                  body: jsonEncode({
                    'oldPassword': oldPasswordController.text,
                    'newPassword': newPasswordController.text,
                  }),
                );
                if (response.statusCode == 200) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('Şifre başarıyla değiştirildi!')));
                  Navigator.pop(context);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Hata: ${response.body}')));
                }
              } catch (e) {
                debugPrint('Hata: $e');
              }
            },
            child: const Text('Kaydet'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return OrtakLayout(
      selectedIndex: 4,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
              child: Text(
                'PROFİLİM',
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue),
              ),
            ),
            const SizedBox(height: 24),
            const Text('Kullanıcı Adı',
                style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            _buildEditableField(
              isEditing: isEditingAdi,
              controller: _adController,
              onEditToggle: () {
                setState(() {
                  if (isEditingAdi)
                    _updateUser(ad: _adController.text); // sadece kullanıcı adı
                  isEditingAdi = !isEditingAdi;
                });
              },
            ),
            const SizedBox(height: 16),
            const Text('E-posta',
                style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            _buildEditableField(
              isEditing: isEditingEmail,
              controller: _emailController,
              onEditToggle: () {
                setState(() {
                  if (isEditingEmail)
                    _updateUser(email: _emailController.text); // sadece email
                  isEditingEmail = !isEditingEmail;
                });
              },
            ),
            const SizedBox(height: 32),
            _profileItem(Icons.lock, 'Şifre Değiştir', _changePasswordDialog),
            _profileItem(Icons.settings, 'Ayarlar', () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const Ayarlar()),
              );
            }),
            _profileItem(Icons.receipt_long, 'Kayıtlı Tarifler', () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => RecipeBookPage()), 
              );
            }),
            _profileItem(Icons.logout, 'Çıkış', () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const LoginPage()),
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildEditableField({
    required bool isEditing,
    required TextEditingController controller,
    required VoidCallback onEditToggle,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.lightBlue[100],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey),
      ),
      child: Row(
        children: [
          Expanded(
            child: isEditing
                ? TextField(
                    controller: controller,
                    decoration: const InputDecoration(border: InputBorder.none),
                  )
                : Text(controller.text, style: const TextStyle(fontSize: 16)),
          ),
          IconButton(
            icon: Icon(isEditing ? Icons.check : Icons.edit,
                color: Colors.deepPurple),
            onPressed: onEditToggle,
          ),
        ],
      ),
    );
  }

  Widget _profileItem(IconData icon, String title, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, size: 28),
      title: Text(title,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
      onTap: onTap,
    );
  }
}
