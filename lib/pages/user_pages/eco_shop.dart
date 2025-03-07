import 'package:flutter/material.dart';

class EcoShopScreen extends StatefulWidget {
  const EcoShopScreen({super.key});

  @override
  State<EcoShopScreen> createState() => _EcoShopScreenState();
}

class _EcoShopScreenState extends State<EcoShopScreen> {
  List<Map<String, dynamic>> plants = [
    {'name': 'Neem Tree', 'price': 500, 'image': 'images/plant.jpg'},
    {'name': 'Mango Tree', 'price': 700, 'image': 'images/plant.jpg'},
    {'name': 'Banyan Tree', 'price': 300, 'image': 'images/plant.jpg'},
  ];

  List<Map<String, dynamic>> cart = [];

  void addToCart(Map<String, dynamic> plant) {
    setState(() {
      cart.add(plant);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${plant['name']} added to cart!'),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  void removePlant(int index) {
    setState(() {
      plants.removeAt(index);
    });
  }

  void checkout() {
    try {
      // Simulate checkout process
      throw Exception('Checkout process failed.'); // Remove this line in actual implementation
    } catch (e) {
      showErrorDialog('Checkout Error', e.toString());
    }
  }

  void showErrorDialog(String title, String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  void showCart() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Your Cart'),
        content: SizedBox(
          width: double.maxFinite,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: cart.length,
            itemBuilder: (context, index) {
              final item = cart[index];
              return ListTile(
                title: Text(item['name']),
                subtitle: Text('\$${item['price']}'),
              );
            },
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Green Market", style: TextStyle(fontWeight: FontWeight.bold)),
        actions: [
          Stack(
            children: [
              IconButton(
                icon: const Icon(Icons.shopping_cart),
                onPressed: showCart,
              ),
              if (cart.isNotEmpty)
                Positioned(
                  right: 0,
                  top: 0,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    constraints: const BoxConstraints(
                      minWidth: 16,
                      minHeight: 16,
                    ),
                    child: Text(
                      '${cart.length}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
      body: plants.isEmpty
          ? const Center(
              child: Text(
                "No plants available",
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: plants.length,
              itemBuilder: (context, index) {
                final plant = plants[index];
                return PlantCard(
                  plant: plant,
                  onAddToCart: () => addToCart(plant),
                  onRemove: () => removePlant(index),
                );
              },
            ),
      bottomNavigationBar: cart.isNotEmpty
          ? Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, -5),
                  )
                ],
              ),
              child: ElevatedButton(
                onPressed: checkout,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green[800],
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Checkout',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            )
          : null,
    );
  }
}

class PlantCard extends StatelessWidget {
  final Map<String, dynamic> plant;
  final VoidCallback onAddToCart;
  final VoidCallback onRemove;

  const PlantCard({
    required this.plant,
    required this.onAddToCart,
    required this.onRemove,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
            child: Image.asset(
              plant['image'],
              height: 150,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  height: 150,
                  color: Colors.grey[200],
                  child: const Icon(Icons.image, size: 50, color: Colors.grey),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  plant['name'],
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text(
                  '\$${plant['price']}',
                  style: const TextStyle(fontSize: 18, color: Colors.green),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: onAddToCart,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green[800],
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text(
                          'Redeem',
                          style: TextStyle(color: Colors.white), // White text
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: OutlinedButton(
                        onPressed: onRemove,
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text('Remove'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}