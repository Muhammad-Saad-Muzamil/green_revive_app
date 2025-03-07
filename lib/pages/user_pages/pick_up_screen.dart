
import"package:flutter/material.dart";
import "package:flutter_map/flutter_map.dart";
import "package:latlong2/latlong.dart";


class PickUpScreen extends StatefulWidget {
  const PickUpScreen({super.key});

  @override
  _PickUpScreenState createState() => _PickUpScreenState();
}

class _PickUpScreenState extends State<PickUpScreen> {
  final TextEditingController _addressController = TextEditingController();
  final MapController _mapController = MapController();
  LatLng _selectedLocation = const LatLng(24.8607, 67.0011); // Default location (Karachi)

  void _submitAddress() {
    String address = _addressController.text;
    if (address.isNotEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Address submitted: $address')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter an address')),
      );
    }
  }

  void _onMapTap(TapPosition tapPosition, LatLng latlng) {
    setState(() {
      _selectedLocation = latlng;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Schedule Garbage Pickup')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _addressController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Address',
                hintText: 'Enter your address',
              ),
            ),
          ),
          Expanded(
            child: FlutterMap(
              mapController: _mapController,
              options: MapOptions(
                initialCenter: _selectedLocation,
                initialZoom: 13.0,
                onTap: (tapPosition, latlng) => _onMapTap(tapPosition, latlng),
              ),
              children: [
                TileLayer(
                  urlTemplate:
                      "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                  subdomains: const ['a', 'b', 'c'],
                ),
                MarkerLayer(
                  markers: [
                    Marker(
                      point: _selectedLocation, // Marker moves when tapped
                      width: 40.0,
                      height: 40.0,
                      child: const Icon(
                        Icons.location_pin,
                        color: Colors.red,
                        size: 40,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: _submitAddress,
              child: const Text('Submit'),
            ),
          ),
        ],
      ),
    );
  }
}
