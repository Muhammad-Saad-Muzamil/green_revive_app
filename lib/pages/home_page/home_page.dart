import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:greenreviveapp/pages/user_pages/account_page.dart';
import 'package:greenreviveapp/pages/user_pages/eco_shop.dart';
import 'package:greenreviveapp/pages/user_pages/pick_up_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    Dashboard(),
    EcoShopScreen(),
    PickUpScreen(),
    AccountScreen(),
  ];

  void _onTabSelected(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Green Revive',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: Colors.green[800],
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.notifications, color: Colors.white),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.menu, color: Colors.white),
          ),
        ],
      ),
      body: _widgetOptions[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.green[800],
        unselectedItemColor: Colors.grey,
        onTap: _onTabSelected,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.eco),
            label: 'Eco Shop',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.delivery_dining),
            label: 'Pickup',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Your Green Impact',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  const Text(
                    'Weekly Contribution',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    height: 200,
                    child: PieChart(
                      PieChartData(
                        sections: showingSections(),
                        borderData: FlBorderData(show: false),
                        centerSpaceRadius: 40,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            'Energy Saved (kWh)',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SizedBox(
                height: 200,
                child: LineChart(
                  LineChartData(
                    gridData: const FlGridData(show: false),
                    titlesData: const FlTitlesData(show: false),
                    borderData: FlBorderData(show: false),
                    minX: 0,
                    maxX: 6,
                    minY: 0,
                    maxY: 10,
                    lineBarsData: [
                      LineChartBarData(
                        spots: const [
                          FlSpot(0, 2),
                          FlSpot(1, 3),
                          FlSpot(2, 5),
                          FlSpot(3, 6),
                          FlSpot(4, 8),
                          FlSpot(5, 9),
                          FlSpot(6, 10),
                        ],
                        isCurved: true,
                        color: Colors.green[800],
                        barWidth: 3,
                        belowBarData: BarAreaData(
                          show: true,
                          color: Colors.green[800]!.withOpacity(0.2),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

List<PieChartSectionData> showingSections() {
  return List.generate(4, (i) {
    const radius = 50.0;
    switch (i) {
      case 0:
        return PieChartSectionData(
          color: Colors.blue,
          value: 40,
          title: '40%',
          radius: radius,
          titleStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        );
      case 1:
        return PieChartSectionData(
          color: Colors.yellow,
          value: 30,
          title: '30%',
          radius: radius,
          titleStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        );
      case 2:
        return PieChartSectionData(
          color: Colors.purple,
          value: 15,
          title: '15%',
          radius: radius,
          titleStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        );
      case 3:
        return PieChartSectionData(
          color: Colors.green,
          value: 15,
          title: '15%',
          radius: radius,
          titleStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        );
      default:
        throw Error();
    }
  });
}