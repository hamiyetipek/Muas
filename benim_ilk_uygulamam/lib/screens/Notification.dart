import 'package:flutter/material.dart';
import '../layouts/ortak.dart';

class NotificationPage extends StatefulWidget {
  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  final List<String> notifications = [
    "İletişim bilgilerini güncelleyerek hesabını güvende tutabilirsin",
    "Yeni israf haberlerimiz yayında! İncelemeye ne dersin?",
    "Senin için oluşturduğumuz tarifleri inceledin mi?",
    "Dolaptaki sütü BUGÜN değerlendirmezsen yarın çok geç olabilir",
  ];

  // Okundu bilgilerini tutan liste
  List<bool> isRead = [];

  @override
  void initState() {
    super.initState();
    isRead = List.filled(notifications.length, false);
  }

  @override
  Widget build(BuildContext context) {
    return OrtakLayout(
      child: ListView.builder(
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          return Container(
            color: isRead[index] ? Colors.white : Colors.blue[50],
            child: ListTile(
              leading: Icon(Icons.notifications,
                  color: isRead[index] ? Colors.grey : Colors.blue),
              title: Text(
                notifications[index],
                style: TextStyle(
                  color: isRead[index] ? Colors.black : Colors.blue[900],
                  fontWeight:
                      isRead[index] ? FontWeight.normal : FontWeight.bold,
                ),
              ),
              onTap: () {
                setState(() {
                  isRead[index] = true;
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("Bildirim seçildi: ${notifications[index]}"),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
