import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:realtime_webapp/screens/employeeListScreen.dart';
import 'package:realtime_webapp/screens/employerListScreen.dart';
import 'package:realtime_webapp/screens/home.dart';
import 'package:realtime_webapp/screens/projectListScreen.dart';
import 'package:realtime_webapp/screens/statisticsScreen.dart';

import 'package:titled_navigation_bar/titled_navigation_bar.dart';

class Navigation extends StatefulWidget {
  int index = 0;
  bool hardcoded = false;
  Navigation({Key key, this.index, this.hardcoded}) : super(key: key);

  @override
  _NavigationState createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  final List<TitledNavigationBarItem> items = [
    TitledNavigationBarItem(title: Text('Homepage'), icon: Icons.home),
    TitledNavigationBarItem(title: Text('Employers'), icon: Icons.business),
    TitledNavigationBarItem(title: Text('Projects'), icon: Icons.file_copy),
    TitledNavigationBarItem(title: Text('Employees'), icon: Icons.person),
  ];

  int _currentIndex = 0;

  final tabs = [
    HomeScreen(),
    EmployerListScreen(),
    ProjectListScreen(),
    EmployeeListScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("RealTime manager tool"),
        backgroundColor: HexColor("#222C4A"),
      ),
      body: widget.hardcoded == true ? tabs[widget.index] : tabs[_currentIndex],
      bottomNavigationBar: TitledBottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        curve: Curves.easeInBack,
        items: items,
        activeColor: HexColor("#222C4A"),
        inactiveColor: Colors.blueGrey,
      ),
    );
  }
}
