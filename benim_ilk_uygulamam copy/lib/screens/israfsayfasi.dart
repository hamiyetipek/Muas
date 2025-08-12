import 'package:flutter/material.dart';
import '../layouts/ortak.dart';

class IsrafBilgiSayfasi extends StatelessWidget {
  IsrafBilgiSayfasi({super.key});

  final List<Map<String, String>> haberler = [
    {
      "baslik": "Türkiye, ekmek israfında Avrupa’da ilk sıralarda!",
      "ozet": "Ekmek israfı ülkemizde büyük bir sorun haline geldi ve Avrupa'da ilk sıralarda yer alıyoruz.",
      "image": "🥖",
    },
    {
      "baslik": "Her 3 gıdadan 1’i tabağa ulaşmadan çöpe gidiyor!",
      "ozet": "Gıda israfının önüne geçmek için farkındalık artırılmalı ve bilinçli tüketim sağlanmalı.",
      "image": "🍽️",
    },
    {
      "baslik": "Evlerde en çok sebze ve meyve israf ediliyor!",
      "ozet": "Sebze ve meyve israfı, evlerde yapılan gıda israfının önemli bir kısmını oluşturuyor.",
      "image": "🍎",
    },
    {
      "baslik": "Akıllı uygulamalar israfı %30 azaltabiliyor!",
      "ozet": "Teknoloji sayesinde israfı azaltan akıllı uygulamalar yaygınlaşıyor.",
      "image": "📱",
    },
    {
      "baslik": "Son kullanma tarihi = Çöpe atma tarihi değil!",
      "ozet": "Son kullanma tarihleri doğru yorumlanarak gıda israfı önlenebilir.",
      "image": "📅",
    },
    {
      "baslik": "Her gün çöpe giden ekmek 1.5 milyar TL",
      "ozet": "Ekonomiye büyük zarar veren ekmek israfının önüne geçilmeli.",
      "image": "💸",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return OrtakLayout(
      selectedIndex: 0,
      child: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: LayoutBuilder(
          builder: (context, constraints) {
            int crossAxisCount = 1;
            double width = constraints.maxWidth;
            if (width > 1000) crossAxisCount = 3;
            else if (width > 600) crossAxisCount = 2;

            return ScrollConfiguration(
              behavior: ScrollConfiguration.of(context)
                  .copyWith(scrollbars: false), // Scrollbar gizle
              child: GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(), // kendi scroll kapalı
                itemCount: haberler.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 3 / 2,
                ),
                itemBuilder: (context, index) {
                  final haber = haberler[index];
                  return Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Padding(
                      padding:
                          const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.blue.shade100,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                padding: EdgeInsets.all(10),
                                child: Text(
                                  haber["image"] ?? "📰",
                                  style: TextStyle(fontSize: 26),
                                ),
                              ),
                              SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  haber["baslik"] ?? "",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue.shade900,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 12),
                          Expanded(
                            child: Text(
                              haber["ozet"] ?? "",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey.shade700,
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: TextButton(
                              onPressed: () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                        "'${haber["baslik"]}' için detay sayfası hazırlanıyor."),
                                  ),
                                );
                              },
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    "Daha Fazla Öğren",
                                    style: TextStyle(
                                      color: Colors.brown,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  SizedBox(width: 4),
                                  Icon(
                                    Icons.arrow_forward,
                                    color: Colors.brown,
                                    size: 18,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
