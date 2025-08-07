import 'package:flutter/material.dart';
import 'package:benim_ilk_uygulamam/layouts/sidebar.dart';
import 'package:benim_ilk_uygulamam/layouts/ortak.dart';

class HakkimizdaSayfasi extends StatefulWidget {
  const HakkimizdaSayfasi({super.key});

  @override
  State<HakkimizdaSayfasi> createState() => _HakkimizdaSayfasiState();
}

class _HakkimizdaSayfasiState extends State<HakkimizdaSayfasi> {
  int expandedIndex = -1; // No panel open by default

  final List<_PanelData> panels = const [
    _PanelData(
      title: "Biz Kimiz?",
      content:
          "Biz, israfı önlemek ve evdeki malzemeleri en verimli şekilde değerlendirmek için çalışan bir ekipiz.",
    ),
    _PanelData(
      title: "Nasıl ürün ekleyebilirim?",
      content:
          "Alt menüdeki '+' ikonuna tıklayarak ürün ekleme sayfasına ulaşabilir, elinizdeki malzemeleri kaydedebilirsiniz.",
    ),
    _PanelData(
      title: "Tarifleri kim ekliyor?",
      content:
          "Tarifler hem uygulama ekibi hem de kullanıcılar tarafından eklenmektedir. Topluluk katkısına önem veriyoruz.",
    ),
    _PanelData(
      title: "İletişim",
      content:
          "Her türlü görüş, öneri ve hata bildirimi için: destek@ornekmail.com adresine yazabilirsiniz.",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return OrtakLayout(
      selectedIndex: -1,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            color: Colors.blue,
            padding: const EdgeInsets.all(16),
            child: const Center(
              child: Text(
                "Hakkımızda",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              itemCount: panels.length,
              itemBuilder: (context, index) {
                final isExpanded = expandedIndex == index;
                return CustomExpansionTile(
                  title: panels[index].title,
                  content: panels[index].content,
                  isExpanded: isExpanded,
                  onTap: () {
                    setState(() {
                      expandedIndex = isExpanded ? -1 : index;
                    });
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class CustomExpansionTile extends StatelessWidget {
  final String title;
  final String content;
  final bool isExpanded;
  final VoidCallback onTap;

  const CustomExpansionTile({
    required this.title,
    required this.content,
    required this.isExpanded,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      decoration: BoxDecoration(
        gradient: isExpanded
            ? const LinearGradient(
                colors: [Colors.indigo, Colors.blueAccent],
              )
            : null,
        color: isExpanded ? null : Colors.blue[100],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Theme(
        data: Theme.of(context).copyWith(
          dividerColor: Colors.transparent,
          unselectedWidgetColor: Colors.black87,
          textTheme: const TextTheme(
            titleMedium: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        child: ExpansionTile(
          key: PageStorageKey(title),
          initiallyExpanded: isExpanded,
          onExpansionChanged: (expanded) => onTap(),
          title: Text(
            title,
            style: TextStyle(
              color: isExpanded ? Colors.white : Colors.black87,
              fontWeight: FontWeight.bold,
            ),
          ),
          iconColor: isExpanded ? Colors.white : Colors.black,
          collapsedIconColor: Colors.black,
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(
                content,
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PanelData {
  final String title;
  final String content;
  const _PanelData({required this.title, required this.content});
}
