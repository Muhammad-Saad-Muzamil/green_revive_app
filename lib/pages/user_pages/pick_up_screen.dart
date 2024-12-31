import 'package:flutter/material.dart';

class PickUpScreen extends StatefulWidget {
  const PickUpScreen({super.key});

  @override
  _PickUpScreenState createState() => _PickUpScreenState();
}

class _PickUpScreenState extends State<PickUpScreen> {
  final TextEditingController _addressController = TextEditingController();

  @override
  void dispose() {
    _addressController.dispose(); // Clean up the controller
    super.dispose();
  }

  void _submitAddress() {
    String address = _addressController.text;
    if (address.isNotEmpty) {
      // You can handle the submitted address here, e.g., send to a server or display it
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Address submitted: $address')),
      );
    } else {
      // Handle the case when the address field is empty
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter an address')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Schedule Garbage Pickup'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Enter your address for garbage pickup:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _addressController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Address',
                hintText: 'Enter your address',
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _submitAddress,
              child: const Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
