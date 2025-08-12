import 'package:flutter/material.dart';
import '../layouts/ortak.dart';

class ShoppingListPage extends StatefulWidget {
  @override
  _ShoppingListPageState createState() => _ShoppingListPageState();
}

class _ShoppingListPageState extends State<ShoppingListPage> {
  List<TextEditingController> controllers = [];
  List<FocusNode> focusNodes = [];
  List<bool> checked = [];
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    List<String> initialProducts = ["Domates", "Salatalık", "Biber"];
    controllers =
        initialProducts.map((e) => TextEditingController(text: e)).toList();

    focusNodes = List.generate(controllers.length, (_) => FocusNode());

    checked = List<bool>.filled(
        controllers.length, false); // Başlangıçta işaretli değil
  }

  @override
  void dispose() {
    for (var c in controllers) {
      c.dispose();
    }
    for (var f in focusNodes) {
      f.dispose();
    }
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return OrtakLayout(
      child: Column(
        children: [
          SizedBox(height: 12),
          Center(
            child: Text(
              "🛒",
              style: TextStyle(fontSize: 36),
            ),
          ),
          Expanded(
            child: CustomPaint(
              painter: LinesPainter(),
              child: ListView.builder(
                controller: _scrollController,
                padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                itemCount: controllers.length,
                itemBuilder: (context, index) {
                  if (index >= checked.length || index >= focusNodes.length) {
                    return SizedBox.shrink();
                  }
                  return Container(
                    color: Colors.transparent,
                    child: ListTile(
                      leading: Checkbox(
                        value: checked[index],
                        onChanged: (bool? value) {
                          setState(() {
                            checked[index] = value ?? false;
                          });
                        },
                      ),
                      title: TextField(
                        controller: controllers[index],
                        focusNode: focusNodes[index],
                        maxLines: null,
                        keyboardType: TextInputType.multiline,
                        decoration: InputDecoration(
                          hintText: "Ürünü yaz...",
                          border: InputBorder.none,
                        ),
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class LinesPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.blue.shade100
      ..strokeWidth = 1;

    double lineHeight = 56;
    for (double y = lineHeight; y < size.height; y += lineHeight) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
