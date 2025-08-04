import 'package:flutter/material.dart';

class OrtakLayout extends StatelessWidget {
  final Widget child;
  final Function(int)? onFooterIconTap; // Footer ikon tıklama callback
  final int selectedIndex; // Footer seçili ikon indeksi

  const OrtakLayout({
    required this.child,
    this.onFooterIconTap,
    this.selectedIndex = 0,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // AppBar - %20 yükseklik için PreferredSize kullandık
      appBar: PreferredSize(
        preferredSize:
            Size.fromHeight(MediaQuery.of(context).size.height * 0.15),
        child: AppBar(
          backgroundColor: Colors.blue,
          leading: IconButton(
            icon: Icon(Icons.menu),
            onPressed: () {
              // Menü ikonuna tıklama işlemi
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text('Menü tıklandı')));
            },
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
                // Bildirim ikonuna tıklama
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text('Bildirim tıklandı')));
              },
            ),
          ],
        ),
      ),

      body: child,

      // Footer - %25 yükseklik için Container kullandık
      bottomNavigationBar: Container(
        height: MediaQuery.of(context).size.height * 0.15,
        color: Colors.blue,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            footerIcon(Icons.home, 0, 'Anasayfa'),
            footerIcon(Icons.book, 1, 'Kitap'),
            footerIcon(Icons.add, 2, 'Ekle'),
            footerIcon(Icons.person, 3, 'Profil'),
          ],
        ),
      ),
    );
  }

  Widget footerIcon(IconData icon, int index, String label) {
    final isSelected = selectedIndex == index;

    return GestureDetector(
      onTap: () {
        if (onFooterIconTap != null) {
          onFooterIconTap!(index);
        }
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon,
              color: isSelected ? Colors.white : Colors.white70, size: 32),
          SizedBox(height: 4),
          Text(label,
              style:
                  TextStyle(color: isSelected ? Colors.white : Colors.white70)),
        ],
      ),
    );
  }
}
