import 'package:flutter/material.dart';
import '../layouts/ortak.dart'; // OrtakLayout dosyanı kullanıyor

class ProfilSayfasi extends StatefulWidget {
  const ProfilSayfasi({Key? key}) : super(key: key);

  @override
  State<ProfilSayfasi> createState() => _ProfilSayfasiState();
}
class _ProfilSayfasiState extends State<ProfilSayfasi> {
  String kullaniciAdi = "Sebile";
  String eposta = "sebile@example.com";

  bool isEditingAdi = false;
  bool isEditingEmail = false;

  final TextEditingController _adController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _adController.text = kullaniciAdi;
    _emailController.text = eposta;
  }

  @override
  Widget build(BuildContext context) {
    return OrtakLayout(
      selectedIndex: 3,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
              child: Text(
                'PROFİLİM',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.blue),
              ),
            ),
            const SizedBox(height: 24),

            const Text('Kullanıcı Adı', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            _buildEditableField(
              isEditing: isEditingAdi,
              controller: _adController,
              onEditToggle: () {
                setState(() {
                  if (isEditingAdi) {
                    kullaniciAdi = _adController.text;
                  }
                  isEditingAdi = !isEditingAdi;
                });
              },
            ),

            const SizedBox(height: 16),

            const Text('E-posta', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            _buildEditableField(
              isEditing: isEditingEmail,
              controller: _emailController,
              onEditToggle: () {
                setState(() {
                  if (isEditingEmail) {
                    eposta = _emailController.text;
                  }
                  isEditingEmail = !isEditingEmail;
                });
              },
            ),

            const SizedBox(height: 32),

            _profileItem(Icons.lock, 'Şifre Değiştir', () {}),
            _profileItem(Icons.settings, 'Ayarlar', () {}),
            _profileItem(Icons.receipt_long, 'Kayıtlı Tarifler', () {}),
            _profileItem(Icons.logout, 'Çıkış', () {}),
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
            icon: Icon(isEditing ? Icons.check : Icons.edit, color: Colors.deepPurple),
            onPressed: onEditToggle,
          ),
        ],
      ),
    );
  }

  Widget _profileItem(IconData icon, String title, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, size: 28),
      title: Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
      onTap: onTap,
    );
  }
}
