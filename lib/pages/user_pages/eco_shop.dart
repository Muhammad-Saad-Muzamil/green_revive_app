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
  }

  void removePlant(int index) {
    setState(() {
      plants.removeAt(index);
    });
  }

  void checkout() {
    // Handle checkout functionality (integrate payment later)
    // Example placeholder for error handling
    try {
      // Simulate checkout process
      // Throwing an error for demonstration
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
    // Show cart items
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Your Cart'),
        content: SizedBox(
          width: double.maxFinite,
          child: ListView.builder(
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
        title: const Text("Roots of Change"),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: showCart,
          ),
        ],
      ),
      body: plants.isEmpty
          ? const Center(
              child: Text(
                "No more plants available",
                style: TextStyle(fontSize: 18),
              ),
            )
          : Stack(
              alignment: Alignment.center,
              children: plants.asMap().entries.map((entry) {
                int index = entry.key;
                Map<String, dynamic> plant = entry.value;

                return Positioned(
                  top: index == 0 ? 50 : 70 - index * 5,
                  left: index == 0 ? 20 : 30 + index * 10,
                  child: DraggablePlantCard(
                    plant: plant,
                    onDismissed: () {
                      removePlant(index);
                    },
                    onAddToCart: addToCart,
                  ),
                );
              }).toList(),
            ),
      bottomNavigationBar: cart.isNotEmpty
          ? Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: checkout,
                child: const Text('Proceed to Checkout'),
              ),
            )
          : const SizedBox.shrink(),
    );
  }
}

class DraggablePlantCard extends StatelessWidget {
  final Map<String, dynamic> plant;
  final VoidCallback onDismissed;
  final Function(Map<String, dynamic>) onAddToCart;

  const DraggablePlantCard({
    required this.plant,
    required this.onDismissed,
    required this.onAddToCart,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(plant['name']),
      direction: DismissDirection.horizontal,
      onDismissed: (direction) {
        onDismissed();
      },
      background: Container(
        color: Colors.red,
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      secondaryBackground: Container(
        color: Colors.green,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: const Icon(Icons.done, color: Colors.white),
      ),
      child: SizedBox(
        width: 300,
        height: 400,
        child: Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          elevation: 4,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(plant['image'], height: 200, fit: BoxFit.cover),
              const SizedBox(height: 10),
              Text(
                plant['name'],
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              Text(
                '\$${plant['price']}',
                style: const TextStyle(fontSize: 20, color: Colors.green),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      // Donate functionality
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text('Donate ${plant['name']}'),
                          content: const Text('We will plant this tree on your behalf.'),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text('Cancel'),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                // Handle donation
                                Navigator.pop(context);
                              },
                              child: const Text('Donate'),
                            ),
                          ],
                        ),
                      );
                    },
                    child: const Text('Donate'),
                  ),
                  ElevatedButton(
                    onPressed: () => onAddToCart(plant),
                    child: const Text('Buy'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

