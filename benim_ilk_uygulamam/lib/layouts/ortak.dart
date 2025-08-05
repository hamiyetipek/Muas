import 'package:flutter/material.dart';
import 'sidebar.dart';
import 'package:benim_ilk_uygulamam/screens/israfsayfasi.dart';
import 'package:benim_ilk_uygulamam/screens/food_status_page.dart';
import 'package:benim_ilk_uygulamam/screens/Notification.dart';
import 'package:benim_ilk_uygulamam/screens/ProfilSayfasi.dart';

class OrtakLayout extends StatelessWidget {
  final Widget child;
  final int selectedIndex;

  const OrtakLayout({
    required this.child,
    this.selectedIndex = 0,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const MySidebar(),
      appBar: PreferredSize(
        preferredSize:
            Size.fromHeight(MediaQuery.of(context).size.height * 0.15),
        child: AppBar(
          backgroundColor: Colors.blue,
          leading: Builder(
            builder: (context) => IconButton(
              icon: Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            ),
          ),
          title: Container(
            height: 40,
            decoration: BoxDecoration(
              color: Colors.blue[100],
              borderRadius: BorderRadius.circular(8),
            ),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Ara...',
                prefixIcon: Icon(Icons.search),
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(vertical: 10),
              ),
            ),
          ),
          centerTitle: true,
          actions: [
            IconButton(
              icon: Icon(Icons.notifications),
              onPressed: () {
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text('Bildirim tıklandı')));
              },
            ),
          ],
        ),
      ),
      body: child,
      bottomNavigationBar: Container(
        height: MediaQuery.of(context).size.height * 0.15,
        color: Colors.blue,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            footerIcon(context, Icons.home, 0, 'Anasayfa'),
            footerIcon(context, Icons.book, 1, 'Ürünler'),
            footerIcon(context, Icons.add, 2, 'Ekle'),
            footerIcon(context, Icons.person, 3, 'Profil'),
          ],
        ),
      ),
    );
  }

  Widget footerIcon(
      BuildContext context, IconData icon, int index, String label) {
    final isSelected = selectedIndex == index;

    return GestureDetector(
      onTap: () {
        // Sayfa yönlendirmeleri burada
        switch (index) {
          case 0:
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (_) => IsrafBilgiSayfasi()));
            break;
          case 1:
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (_) => FoodStatusPage()));
            break;
          case 2:
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Bu özellik yakında eklenecek")),
            );
            break;
          case 3:
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (_) => ProfilSayfasi()));
            break;
        }
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon,
              color: isSelected ? Colors.white : Colors.white70, size: 32),
          SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(color: isSelected ? Colors.white : Colors.white70),
          ),
        ],
      ),
    );
  }
}
