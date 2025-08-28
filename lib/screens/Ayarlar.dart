import 'package:flutter/material.dart';
import 'package:benim_ilk_uygulamam/layouts/ortak.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Wrapper class that uses OrtakLayout
class Ayarlar extends StatelessWidget {
  final VoidCallback? onThemeChanged;
  const Ayarlar({Key? key, this.onThemeChanged}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OrtakLayout(
      selectedIndex: -1,
      child: AyarlarSayfasi(onThemeChanged: onThemeChanged),
    );
  }
}

class AyarlarSayfasi extends StatefulWidget {
  final VoidCallback? onThemeChanged;
  const AyarlarSayfasi({Key? key, this.onThemeChanged}) : super(key: key);

  @override
  State<AyarlarSayfasi> createState() => _AyarlarSayfasiState();
}

class _AyarlarSayfasiState extends State<AyarlarSayfasi> {
  bool _isDarkMode = false;
  bool _notificationsEnabled = true;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  // Load saved settings from SharedPreferences
  _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _isDarkMode = prefs.getBool('isDarkMode') ?? false;
      _notificationsEnabled = prefs.getBool('notificationsEnabled') ?? true;
      _isLoading = false;
    });
  }

  // Save theme setting
  _toggleTheme(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _isDarkMode = value;
    });
    await prefs.setBool('isDarkMode', value);

    // Notify main app to rebuild
    if (widget.onThemeChanged != null) {
      widget.onThemeChanged!();
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(_isDarkMode ? 'Karanlık tema aktif' : 'Açık tema aktif'),
        backgroundColor: _isDarkMode ? Colors.grey[800] : Colors.blue,
      ),
    );
  }

  // Save notification setting
  _toggleNotifications(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _notificationsEnabled = value;
    });
    await prefs.setBool('notificationsEnabled', value);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
            _notificationsEnabled ? 'Bildirimler açık' : 'Bildirimler kapalı'),
        backgroundColor: Colors.green,
      ),
    );
  }

  // Logout function
  _showLogoutDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Çıkış Yap'),
          content: const Text('Çıkış yapmak istediğinizden emin misiniz?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close dialog
              },
              child: const Text('İptal'),
            ),
            ElevatedButton(
              onPressed: () async {
                Navigator.of(context).pop(); // Close dialog
                await _logout();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
              ),
              child: const Text('Çıkış Yap'),
            ),
          ],
        );
      },
    );
  }

  _logout() async {
    // Clear saved data
    final prefs = await SharedPreferences.getInstance();
    await prefs
        .clear(); // Or remove specific keys: prefs.remove('userLoggedIn');

    // Navigate to sign in page
    // Replace 'SignInPage' with your actual sign in page class name
    Navigator.of(context).pushNamedAndRemoveUntil(
      '/signin', // Replace with your sign in route
      (route) => false, // This removes all previous routes
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    return Container(
      color: const Color(0xFFF8F9FA),
      child: Column(
        children: [
          // Page title
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            color: Colors.white,
            child: const Text(
              'Ayarlar',
              style: TextStyle(
                color: Color(0xFF2D3748),
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          // Settings content
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  // Theme Setting Card
                  _buildSettingCard(
                    icon: Icons.palette,
                    title: 'Tema',
                    subtitle: _isDarkMode ? 'Karanlık tema' : 'Açık tema',
                    child: Switch(
                      value: _isDarkMode,
                      onChanged: _toggleTheme,
                      activeColor: Colors.blue,
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Notifications Setting Card
                  _buildSettingCard(
                    icon: Icons.notifications,
                    title: 'Bildirimler',
                    subtitle: _notificationsEnabled
                        ? 'Bildirimler açık'
                        : 'Bildirimler kapalı',
                    child: Switch(
                      value: _notificationsEnabled,
                      onChanged: _toggleNotifications,
                      activeColor: Colors.green,
                    ),
                  ),

                  const SizedBox(height: 16),

                  // About Card (Optional - you can remove this)
                  _buildInfoCard(
                    icon: Icons.info,
                    title: 'Uygulama Hakkında',
                    subtitle: 'Versiyon 1.0.0',
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text('Uygulama Hakkında'),
                          content: const Text(
                              'Bu uygulama Flutter ile geliştirilmiştir.'),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text('Tamam'),
                            ),
                          ],
                        ),
                      );
                    },
                  ),

                  const SizedBox(height: 32),

                  // Logout Button
                  Container(
                    width: double.infinity,
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    child: ElevatedButton.icon(
                      onPressed: _showLogoutDialog,
                      icon: const Icon(Icons.logout, color: Colors.white),
                      label: const Text(
                        'Çıkış Yap',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Helper method to build setting cards with switches
  Widget _buildSettingCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required Widget child,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: Colors.blue.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                icon,
                color: Colors.blue,
                size: 24,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF2D3748),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Color(0xFF718096),
                    ),
                  ),
                ],
              ),
            ),
            child,
          ],
        ),
      ),
    );
  }

  // Helper method to build info cards (clickable)
  Widget _buildInfoCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  icon,
                  color: Colors.grey[600],
                  size: 24,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF2D3748),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Color(0xFF718096),
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(
                Icons.arrow_forward_ios,
                color: Color(0xFF718096),
                size: 16,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
