import 'package:flutter/material.dart';
import 'sidebar.dart';
import 'package:benim_ilk_uygulamam/screens/israfsayfasi.dart';
import 'package:benim_ilk_uygulamam/screens/food_status_page.dart';
import 'package:benim_ilk_uygulamam/screens/Notification.dart';
import 'package:benim_ilk_uygulamam/screens/ProfilSayfasi.dart';
import 'package:benim_ilk_uygulamam/screens/QrOkutucu.dart'; // QR kod sayfan varsa bunu ekle
import 'package:benim_ilk_uygulamam/screens/urun_ekleme.dart'; // Ürün ekleme sayfası

class OrtakLayout extends StatefulWidget {
  final Widget child;
  final int selectedIndex;

  const OrtakLayout({
    required this.child,
    this.selectedIndex = 0,
    Key? key,
  }) : super(key: key);

  @override
  State<OrtakLayout> createState() => _OrtakLayoutState();
}

class _OrtakLayoutState extends State<OrtakLayout> {
  int hoveredIndex = -1; // Hover edilen ikon indeksi

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
      body: widget.child,
      bottomNavigationBar: Container(
        height: MediaQuery.of(context).size.height * 0.15,
        color: Colors.blue,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            footerIcon(context, Icons.home, 0, 'Anasayfa'),
            footerIcon(context, Icons.book, 1, 'Ürünler'),

            // Karekod ikonunu ortada yuvarlak içinde
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: MouseRegion(
                onEnter: (_) => setState(() => hoveredIndex = 2),
                onExit: (_) => setState(() => hoveredIndex = -1),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (_) => QrOkutucuSayfasi()), // QR kod sayfası
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: (widget.selectedIndex == 2 || hoveredIndex == 2)
                          ? Colors.white
                          : Colors.white70,
                      shape: BoxShape.circle,
                      boxShadow: [
                        if (widget.selectedIndex == 2 || hoveredIndex == 2)
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 8,
                            offset: Offset(0, 4),
                          )
                      ],
                    ),
                    padding: EdgeInsets.all(12),
                    child: Icon(
                      Icons.qr_code_scanner,
                      size: (widget.selectedIndex == 2 || hoveredIndex == 2)
                          ? 40
                          : 32,
                      color: (widget.selectedIndex == 2 || hoveredIndex == 2)
                          ? Colors.blue
                          : Colors.blue[300],
                    ),
                  ),
                ),
              ),
            ),

            footerIcon(context, Icons.add, 3, 'Ekle'),
            footerIcon(context, Icons.person, 4, 'Profil'),
          ],
        ),
      ),
    );
  }

  Widget footerIcon(
      BuildContext context, IconData icon, int index, String label) {
    final isSelected = widget.selectedIndex == index;
    final isHovered = hoveredIndex == index;

    Color iconColor = Colors.white70;
    double iconSize = 32;

    if (isSelected) {
      iconColor = Colors.white;
      iconSize = 36;
    } else if (isHovered) {
      iconColor = Colors.white;
      iconSize = 34;
    }

    return MouseRegion(
      onEnter: (_) => setState(() => hoveredIndex = index),
      onExit: (_) => setState(() => hoveredIndex = -1),
      child: GestureDetector(
        onTap: () {
          switch (index) {
            case 0:
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (_) => IsrafBilgiSayfasi()));
              break;
            case 1:
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (_) => FoodStatusPage()));
              break;
            case 3:
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => UrunEklemeSayfasi()),
              );
              break;
            case 4:
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (_) => ProfilSayfasi()));
              break;
          }
        },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: iconColor, size: iconSize),
            SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(color: iconColor),
            ),
          ],
        ),
      ),
    );
  }
}
