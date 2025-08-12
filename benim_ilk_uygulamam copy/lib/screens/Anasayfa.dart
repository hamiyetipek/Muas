import 'package:flutter/material.dart';
import 'dart:async';
import '../layouts/ortak.dart';
import '../layouts/sidebar.dart';
import 'israfsayfasi.dart';
import 'food_status_page.dart';
import 'Notification.dart';
import 'ProfilSayfasi.dart';
import 'QrOkutucu.dart'; // QR kod sayfan varsa bunu ekle
import 'urun_ekleme.dart'; // Ürün ekleme sayfası
import 'RecipeBook.dart';
import 'ShopingList.dart';

class AnasayfaWrapper extends StatelessWidget {
  final VoidCallback? onThemeChanged;
  const AnasayfaWrapper({Key? key, this.onThemeChanged}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OrtakLayout(
      selectedIndex: 0,
      onThemeChanged: onThemeChanged,
      child: Anasayfa(),
    );
  }
}

class Anasayfa extends StatefulWidget {
  const Anasayfa({Key? key}) : super(key: key);

  @override
  State<Anasayfa> createState() => _AnasayfaState();
}

class _AnasayfaState extends State<Anasayfa> {
  late PageController _pageController;
  late Timer _timer;
  int _currentPage = 0;

  // Slideshow data
  final List<SlideData> _slides = [
    SlideData(
      title: "Merhaba, Hamiyet",
      subtitle: "Haydi ürün israfına son verelim",
      imagePath: "assets/images/slide1.png", //Foto eklenebilir
      backgroundColor: Color(0xFF6366F1),
    ),
    SlideData(
      title: "İsrafı Durdurun",
      subtitle: "Gıda israfını önlemek için birlikte çalışalım",
      imagePath: "assets/images/slide2.png",
      backgroundColor: Color(0xFF8B5CF6),
    ),
    SlideData(
      title: "Akıllı Takip",
      subtitle: "Ürünlerinizi akıllıca takip edin ve israfı önleyin",
      imagePath: "assets/images/slide3.png",
      backgroundColor: Color(0xFF06B6D4),
    ),
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _startAutoSlide();
  }

  void _startAutoSlide() {
    _timer = Timer.periodic(Duration(seconds: 4), (timer) {
      if (_currentPage < _slides.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }

      if (_pageController.hasClients) {
        _pageController.animateToPage(
          _currentPage,
          duration: Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _pageController.dispose();
    super.dispose();
  }

  void _navigateToIsrafSayfasi() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => IsrafBilgiSayfasi(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFF8F9FA),
      child: Column(
        children: [
          Expanded(
            flex: 3,
            child: FractionallySizedBox(
              widthFactor: 1,
              child: Container(
                margin: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 15,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Stack(
                    children: [
                      // PageView for slides
                      PageView.builder(
                        controller: _pageController,
                        onPageChanged: (index) {
                          setState(() {
                            _currentPage = index;
                          });
                        },
                        itemCount: _slides.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: _navigateToIsrafSayfasi,
                            child: Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [
                                    _slides[index].backgroundColor,
                                    _slides[index]
                                        .backgroundColor
                                        .withOpacity(0.8),
                                  ],
                                ),
                              ),
                              child: Stack(
                                children: [
                                  Positioned(
                                    right: -50,
                                    top: -50,
                                    child: Container(
                                      width: 200,
                                      height: 200,
                                      decoration: BoxDecoration(
                                        color: Colors.white.withOpacity(0.1),
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                  ),

                                  // Content
                                  Padding(
                                    padding: const EdgeInsets.all(24),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const SizedBox(height: 20),

                                        // Title
                                        Text(
                                          _slides[index].title,
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 28,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),

                                        const SizedBox(height: 8),

                                        // Subtitle
                                        Text(
                                          _slides[index].subtitle,
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),

                                        const Spacer(),

                                        // Image placeholder (since we don't have the actual images)
                                        Center(
                                          child: Container(
                                            width: 200,
                                            height: 150,
                                            decoration: BoxDecoration(
                                              color:
                                                  Colors.white.withOpacity(0.2),
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                            ),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Icon(
                                                  _getSlideIcon(index),
                                                  size: 60,
                                                  color: Colors.white
                                                      .withOpacity(0.8),
                                                ),
                                                const SizedBox(height: 8),
                                                Text(
                                                  'Görsel ${index + 1}',
                                                  style: TextStyle(
                                                    color: Colors.white
                                                        .withOpacity(0.8),
                                                    fontSize: 14,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),

                                        const SizedBox(height: 20),
                                      ],
                                    ),
                                  ),

                                  // Character illustration placeholder (top right)
                                  Positioned(
                                    top: 20,
                                    right: 20,
                                    child: Container(
                                      width: 60,
                                      height: 60,
                                      decoration: BoxDecoration(
                                        color: Colors.white.withOpacity(0.2),
                                        shape: BoxShape.circle,
                                      ),
                                      child: Icon(
                                        Icons.person,
                                        color: Colors.white.withOpacity(0.8),
                                        size: 30,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),

                      // Page indicators
                      Positioned(
                        bottom: 20,
                        left: 0,
                        right: 0,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(
                            _slides.length,
                            (index) => AnimatedContainer(
                              duration: const Duration(milliseconds: 300),
                              margin: const EdgeInsets.symmetric(horizontal: 4),
                              width: _currentPage == index ? 24 : 8,
                              height: 8,
                              decoration: BoxDecoration(
                                color: _currentPage == index
                                    ? Colors.white
                                    : Colors.white.withOpacity(0.4),
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Hızlı İşlemler',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2D3748),
                    ),
                  ),
                  const SizedBox(height: 14),
                  Expanded(
                    child: GridView.count(
                      crossAxisCount: 2,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      children: [
                        _buildQuickActionCard(
                          icon: Icons.book,
                          title: 'Tarif Defteri',
                          color: const Color(0xFF4CAF50),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => RecipeBookPage()),
                            );
                          },
                        ),
                        _buildQuickActionCard(
                          icon: Icons.shopping_cart,
                          title: 'Alışveriş Listesi',
                          color: const Color(0xFF2196F3),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ShoppingListPage()),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActionCard({
    required IconData icon,
    required String title,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                color: color,
                size: 28,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              title,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Color(0xFF2D3748),
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  IconData _getSlideIcon(int index) {
    switch (index) {
      case 0:
        return Icons.eco;
      case 1:
        return Icons.stop_circle;
      case 2:
        return Icons.track_changes;
      default:
        return Icons.eco;
    }
  }
}

// Data class for slides
class SlideData {
  final String title;
  final String subtitle;
  final String imagePath;
  final Color backgroundColor;

  SlideData({
    required this.title,
    required this.subtitle,
    required this.imagePath,
    required this.backgroundColor,
  });
}
