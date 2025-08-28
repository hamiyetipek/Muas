import 'package:flutter/material.dart';
import '../layouts/ortak.dart';

class UrunEklemeSayfasi extends StatelessWidget {
  const UrunEklemeSayfasi({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OrtakLayout(
      selectedIndex: 3, // Alt bardaki aktif ikon (Ürün Ekleme)
      child: UrunEkleme(),
    );
  }
}

class UrunEkleme extends StatefulWidget {
  const UrunEkleme({Key? key}) : super(key: key);

  @override
  State<UrunEkleme> createState() => _UrunEklemeState();
}

class _UrunEklemeState extends State<UrunEkleme> with TickerProviderStateMixin {
  List<Ingredient> ingredients = [];
  bool isAddingIngredient = false;
  late AnimationController _animationController;
  late Animation<double> _animation;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  String _selectedUnit = 'gram';

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    _nameController.dispose();
    _quantityController.dispose();
    super.dispose();
  }

  void _showAddIngredientPanel() {
    setState(() {
      isAddingIngredient = true;
    });
    _animationController.forward();
  }

  void _hideAddIngredientPanel() {
    _animationController.reverse().then((_) {
      setState(() {
        isAddingIngredient = false;
      });
    });
    _clearForm();
  }

  void _clearForm() {
    _nameController.clear();
    _quantityController.clear();
    _selectedUnit = 'gram';
  }

  void _addIngredient() {
    if (_nameController.text.isNotEmpty &&
        _quantityController.text.isNotEmpty) {
      setState(() {
        ingredients.add(Ingredient(
          name: _nameController.text,
          quantity: _quantityController.text,
          unit: _selectedUnit,
        ));
      });
      _hideAddIngredientPanel();
    }
  }

  void _editIngredient(int index) {
    final ingredient = ingredients[index];
    _nameController.text = ingredient.name;
    _quantityController.text = ingredient.quantity;
    _selectedUnit = ingredient.unit;

    setState(() {
      ingredients.removeAt(index);
      isAddingIngredient = true;
    });
    _animationController.forward();
  }

  void _deleteIngredient(int index) {
    setState(() {
      ingredients.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFF8F9FA),
      child: Column(
        children: [
          // Page title
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            color: Colors.white,
            child: const Text(
              'Ürün Ekleme',
              style: TextStyle(
                color: Color(0xFF2D3748),
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          // Main content
          Expanded(
            child: Column(
              children: [
                // Add button section
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  color: Colors.white,
                  child: Column(
                    children: [
                      if (!isAddingIngredient)
                        ElevatedButton.icon(
                          onPressed: _showAddIngredientPanel,
                          icon: const Icon(Icons.add, color: Colors.white),
                          label: const Text(
                            'Malzeme Ekle',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF4CAF50),
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 32,
                              vertical: 16,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            elevation: 2,
                          ),
                        ),
                    ],
                  ),
                ),
                // Ingredients list
                Expanded(
                  child: Container(
                    color: const Color(0xFFF8F9FA),
                    child: ingredients.isEmpty
                        ? const Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.restaurant_menu,
                                  size: 64,
                                  color: Color(0xFFE2E8F0),
                                ),
                                SizedBox(height: 16),
                                Text(
                                  'Henüz malzeme eklenmedi',
                                  style: TextStyle(
                                    color: Color(0xFF718096),
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                          )
                        : ListView.builder(
                            padding: const EdgeInsets.all(20),
                            itemCount: ingredients.length,
                            itemBuilder: (context, index) {
                              final ingredient = ingredients[index];
                              return Container(
                                margin: const EdgeInsets.only(bottom: 12),
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.05),
                                      blurRadius: 10,
                                      offset: const Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 48,
                                      height: 48,
                                      decoration: BoxDecoration(
                                        color: const Color(0xFF4CAF50)
                                            .withOpacity(0.1),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: const Icon(
                                        Icons.local_dining,
                                        color: Color(0xFF4CAF50),
                                        size: 24,
                                      ),
                                    ),
                                    const SizedBox(width: 16),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            ingredient.name,
                                            style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                              color: Color(0xFF2D3748),
                                            ),
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            '${ingredient.quantity} ${ingredient.unit}',
                                            style: const TextStyle(
                                              fontSize: 14,
                                              color: Color(0xFF718096),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        IconButton(
                                          onPressed: () =>
                                              _editIngredient(index),
                                          icon: const Icon(
                                            Icons.edit,
                                            color: Color(0xFF3182CE),
                                            size: 20,
                                          ),
                                        ),
                                        IconButton(
                                          onPressed: () =>
                                              _deleteIngredient(index),
                                          icon: const Icon(
                                            Icons.delete,
                                            color: Color(0xFFE53E3E),
                                            size: 20,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                  ),
                ),
              ],
            ),
          ),
          
          if (isAddingIngredient)
            AnimatedBuilder(
              animation: _animation,
              builder: (context, child) {
                return Transform.translate(
                  offset: Offset(0, -300 * (1 - _animation.value)),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 20,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: SafeArea(
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Malzeme Ekle',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF2D3748),
                                  ),
                                ),
                                IconButton(
                                  onPressed: _hideAddIngredientPanel,
                                  icon: const Icon(
                                    Icons.close,
                                    color: Color(0xFF718096),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),

                            // Ingredient name field
                            TextField(
                              controller: _nameController,
                              decoration: InputDecoration(
                                labelText: 'Malzeme Adı',
                                hintText: 'Örn: Domates',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: const BorderSide(
                                    color: Color(0xFF4CAF50),
                                    width: 2,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 16),

                            // Quantity and unit row
                            Row(
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: TextField(
                                    controller: _quantityController,
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                      labelText: 'Miktar',
                                      hintText: '500',
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                        borderSide: const BorderSide(
                                          color: Color(0xFF4CAF50),
                                          width: 2,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  flex: 1,
                                  child: DropdownButtonFormField<String>(
                                    value: _selectedUnit,
                                    decoration: InputDecoration(
                                      labelText: 'Birim',
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                        borderSide: const BorderSide(
                                          color: Color(0xFF4CAF50),
                                          width: 2,
                                        ),
                                      ),
                                    ),
                                    items: const [
                                      DropdownMenuItem(
                                          value: 'gram', child: Text('gram')),
                                      DropdownMenuItem(
                                          value: 'kg', child: Text('kg')),
                                      DropdownMenuItem(
                                          value: 'ml', child: Text('ml')),
                                      DropdownMenuItem(
                                          value: 'litre', child: Text('litre')),
                                      DropdownMenuItem(
                                          value: 'adet', child: Text('adet')),
                                      DropdownMenuItem(
                                          value: 'çorba kaşığı',
                                          child: Text('çorba kaşığı')),
                                      DropdownMenuItem(
                                          value: 'tatlı kaşığı',
                                          child: Text('tatlı kaşığı')),
                                      DropdownMenuItem(
                                          value: 'bardak',
                                          child: Text('bardak')),
                                    ],
                                    onChanged: (value) {
                                      setState(() {
                                        _selectedUnit = value!;
                                      });
                                    },
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 24),

                            // Action buttons
                            Row(
                              children: [
                                Expanded(
                                  child: OutlinedButton(
                                    onPressed: _hideAddIngredientPanel,
                                    style: OutlinedButton.styleFrom(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 16),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      side: const BorderSide(
                                        color: Color(0xFFE2E8F0),
                                      ),
                                    ),
                                    child: const Text(
                                      'İptal',
                                      style: TextStyle(
                                        color: Color(0xFF718096),
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: ElevatedButton(
                                    onPressed: _addIngredient,
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color(0xFF4CAF50),
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 16),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                    ),
                                    child: const Text(
                                      'Ekle',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
        ],
      ),
    );
  }
}

class Ingredient {
  final String name;
  final String quantity;
  final String unit;

  Ingredient({
    required this.name,
    required this.quantity,
    required this.unit,
  });
}
