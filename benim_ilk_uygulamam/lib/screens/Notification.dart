import 'package:flutter/material.dart';
import '../layouts/ortak.dart';

class NotificationPage extends StatelessWidget {
  final List<String> notifications = [
    "İletişim bilgilerini güncelleyerek hesabnı güvende tutabilirsin",
    "Yeni israf haberlerimiz yaynda incelemeye ne dersin!",
    "Senin inin oluşturduğumuz tarifleri inceledin mi?",
    "Dolptaki sütü BUGÜN değerlendirmezsen yarın çok geç olabilir",
  ];

  @override
  Widget build(BuildContext context) {
    return OrtakLayout(
      child: ListView.builder(
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Icon(Icons.notifications, color: Colors.blue),
            title: Text(notifications[index]),
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                    content: Text("Bildirim seçildi: ${notifications[index]}")),
              );
            },
          );
        },
      ),
    );
  }
}
