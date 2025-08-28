import 'package:flutter/material.dart';
import '../layouts/ortak.dart';
import 'package:benim_ilk_uygulamam/screens/Ayarlar.dart';
import 'package:benim_ilk_uygulamam/screens/RecipeBook.dart';
import 'package:benim_ilk_uygulamam/screens/auth/LoginPage.dart';
import 'package:benim_ilk_uygulamam/Services/user_service.dart';

class ProfilSayfasi extends StatefulWidget {
  const ProfilSayfasi({Key? key}) : super(key: key);

  @override
  State<ProfilSayfasi> createState() => _ProfilSayfasiState();
}

class _ProfilSayfasiState extends State<ProfilSayfasi> {
  final UserService _userService = UserService();

  String kullaniciAdi = "";
  String eposta = "";

  bool isEditingAdi = false;
  bool isEditingEmail = false;

  final TextEditingController _adController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  final int userId = 1; // Test için kullanıcı ID

  @override
  void initState() {
    super.initState();
    _fetchUser();
  }

  Future<void> _fetchUser() async {
    try {
      final data = await _userService.fetchUser(userId);
      if (data != null) {
        setState(() {
          kullaniciAdi = data['ad'];
          eposta = data['email'];
          _adController.text = kullaniciAdi;
          _emailController.text = eposta;
        });
      }
    } catch (e) {
      debugPrint('Hata: $e');
    }
  }

  Future<void> _updateUser({String? ad, String? email}) async {
    try {
      final success =
          await _userService.updateUser(userId, ad: ad, email: email);
      if (success) {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('Profil güncellendi!')));
        _fetchUser();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Güncelleme başarısız!')));
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
                final errorMessage = await _userService.changePassword(
                  userId,
                  oldPasswordController.text,
                  newPasswordController.text,
                );

                if (errorMessage == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text('Şifre başarıyla değiştirildi!')),
                  );
                  Navigator.pop(context);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(errorMessage)),
                  );
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
                  if (isEditingAdi) _updateUser(ad: _adController.text);
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
                  if (isEditingEmail) _updateUser(email: _emailController.text);
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
