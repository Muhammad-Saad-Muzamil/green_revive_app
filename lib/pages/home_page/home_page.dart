import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';


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
    ScheduleScreen(),
    UserScreen(),
  ];

  void _onTabSelected(int index) {
    setState(() {
      _selectedIndex = index; // Update the selected index
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.notifications),
        ),
        
        actions: <Widget>[
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.menu),
          ),
        ],
      ),
      body: _widgetOptions[_selectedIndex], // Use the correct list for body
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.eco),
            label: 'roots for change',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.delivery_dining),
            label: 'Schedule pickup',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'User',
          ),
        ],
        currentIndex: _selectedIndex, // Current active tab
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.grey,
        onTap: _onTabSelected, // Update the index when a tab is tapped
      ),
    );
  }
}

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Your Contribution to a Greener Environment',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20),
          Expanded(
            child: PieChart(
              PieChartData(
                sections: showingSections(),
                borderData: FlBorderData(show: false),
                centerSpaceRadius: 40,
              ),
            ),
          ),
          SizedBox(height: 20),
          Text(
            'Weekly Contribution in kWh',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          Expanded(
            child: LineChart(
              LineChartData(
                gridData: FlGridData(show: false),
                titlesData: FlTitlesData(
                  leftTitles: AxisTitles(),
                  bottomTitles: AxisTitles()
                ),
                borderData: FlBorderData(show: true),
                minX: 0,
                maxX: 6,
                minY: 0,
                maxY: 10,
                lineBarsData: [
                  LineChartBarData(
                    spots: [
                      FlSpot(0, 2),
                      FlSpot(1, 3),
                      FlSpot(2, 5),
                      FlSpot(3, 6),
                      FlSpot(4, 8),
                      FlSpot(5, 9),
                      FlSpot(6, 10),
                    ],
                    isCurved: true,
                   
                    dotData: FlDotData(show: false),
                    belowBarData: BarAreaData(show: false),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<PieChartSectionData> showingSections() {
    return List.generate(4, (i) {
      final isTouched = i == 0; // Change based on touch
      final fontSize = isTouched ? 25.0 : 16.0;
      final radius = isTouched ? 60.0 : 50.0;
      switch (i) {
        case 0:
          return PieChartSectionData(
            color: Colors.green,
            value: 40,
            title: 'Recycling',
            radius: radius,
            titleStyle: TextStyle(fontSize: fontSize, color: Colors.white),
          );
        case 1:
          return PieChartSectionData(
            color: Colors.blue,
            value: 30,
            title: 'Energy Saving',
            radius: radius,
            titleStyle: TextStyle(fontSize: fontSize, color: Colors.white),
          );
        case 2:
          return PieChartSectionData(
            color: Colors.orange,
            value: 20,
            title: 'Planting Trees',
            radius: radius,
            titleStyle: TextStyle(fontSize: fontSize, color: Colors.white),
          );
        case 3:
          return PieChartSectionData(
            color: Colors.red,
            value: 10,
            title: 'Other',
            radius: radius,
            titleStyle: TextStyle(fontSize: fontSize, color: Colors.white),
          );
        default:
          throw Error();
      }
    });
  }
}
