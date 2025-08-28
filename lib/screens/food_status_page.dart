import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../layouts/ortak.dart';
import 'package:benim_ilk_uygulamam/models/food_items.dart';
import '../Services/foodstatus_service.dart';
import '../providers/user_provider.dart';
import 'package:intl/intl.dart';

class FoodStatusPage extends StatefulWidget {
  const FoodStatusPage({Key? key}) : super(key: key);

  @override
  State<FoodStatusPage> createState() => _FoodStatusPageState();
}

class _FoodStatusPageState extends State<FoodStatusPage> {
  late Future<List<FoodItem>> _futureFoodItems;

  @override
  void initState() {
    super.initState();
    final userId = Provider.of<UserProvider>(context, listen: false).userId;
    _futureFoodItems = FoodService().fetchFoodItems(userId);
  }

  Future<bool> _confirmDelete(FoodItem item) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Silmek istediğine emin misin?"),
        content: Text("${item.name} silinecek."),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: const Text("İptal")),
          TextButton(onPressed: () => Navigator.pop(context, true), child: const Text("Sil")),
        ],
      ),
    );
    return confirmed ?? false;
  }

  Future<void> _deleteItem(FoodItem item) async {
    final userId = Provider.of<UserProvider>(context, listen: false).userId;
    final success = await FoodService().deleteFoodItem(item.id, userId);
    if (success) {
      setState(() => _futureFoodItems = FoodService().fetchFoodItems(userId));
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("${item.name} silindi"), duration: const Duration(seconds: 2)),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("${item.name} silinemedi"), duration: const Duration(seconds: 2)),
      );
    }
  }

  String getWarningText(DateTime expireDate) {
    final now = DateTime.now();
    final daysLeft = expireDate.difference(now).inDays;

    if (daysLeft < 0) return 'Son kullanma tarihi geçti!';
    if (daysLeft <= 2) return 'Son $daysLeft gün';
    if (daysLeft <= 6) return 'Son $daysLeft gün';
    return 'Son $daysLeft gün';
  }

  @override
  Widget build(BuildContext context) {
    final userId = Provider.of<UserProvider>(context, listen: false).userId;

    return OrtakLayout(
      selectedIndex: 1,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() => _futureFoodItems = FoodService().fetchFoodItems(userId));
        },
        child: const Icon(Icons.refresh),
      ),
      child: SafeArea(
        child: FutureBuilder<List<FoodItem>>(
          future: _futureFoodItems,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return const Center(child: Text("Ürünler yüklenirken bir hata oluştu."));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text("Hiç ürün bulunamadı."));
            }

            final foodItems = snapshot.data!;
            return ListView.builder(
              padding: const EdgeInsets.only(bottom: 24),
              itemCount: foodItems.length,
              itemBuilder: (context, index) {
                final item = foodItems[index];
                final formattedDate = DateFormat('dd.MM.yyyy').format(item.expireDate);
                final warningText = getWarningText(item.expireDate);

                return Dismissible(
                  key: ValueKey(item.id),
                  direction: DismissDirection.endToStart,
                  background: Container(
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    color: Colors.red,
                    child: const Icon(Icons.delete, color: Colors.white),
                  ),
                  confirmDismiss: (_) => _confirmDelete(item),
                  onDismissed: (_) => _deleteItem(item),
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.blue[50],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(item.icon, color: item.color, size: 30),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Text(
                                item.name,
                                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: item.color.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                item.status,
                                style: TextStyle(fontWeight: FontWeight.bold, color: item.color),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(warningText, style: TextStyle(color: item.color, fontWeight: FontWeight.w600)),
                        Text("Son Kullanma: $formattedDate"),
                        Text("Miktar: ${item.quantity} ${item.unit}"),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}