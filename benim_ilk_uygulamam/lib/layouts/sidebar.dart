import 'package:flutter/material.dart';
import 'package:benim_ilk_uygulamam/screens/ProfilSayfasi.dart';
import 'package:benim_ilk_uygulamam/screens/Notification.dart';
import 'package:benim_ilk_uygulamam/screens/HakkimizdaSayfasi.dart';
import 'package:benim_ilk_uygulamam/screens/Ayarlar.dart';

class MySidebar extends StatelessWidget {
  final VoidCallback? onThemeChanged;
  const MySidebar({Key? key, this.onThemeChanged}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(color: Colors.blue),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(Icons.person, size: 40, color: Colors.blue),
            ),
            accountName: Text("USER"),
            accountEmail: null,
          ),
          ListTile(
            leading: Icon(Icons.notifications),
            title: Text('Bildirimler'),
            onTap: () {
              Navigator.pop(context); // önce drawer kapansın
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => NotificationPage()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.info),
            title: Text('Hakkımızda'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HakkimizdaSayfasi()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.book),
            title: Text('Tarif Defteri'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(Icons.list),
            title: Text('Alışveriş Listesi'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.person),
            title: Text('Profil'),
            onTap: () {
              Navigator.pop(context); // önce drawer kapansın
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfilSayfasi()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Ayarlar'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Ayarlar(
                    onThemeChanged: onThemeChanged, // Pass it here
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
