import 'package:flutter/material.dart';
import 'dashboard_screen.dart';
import 'report_case_screen.dart';

import 'education/education_screen.dart';
import 'profile_screen.dart';
import '../admin_dashboard/admin_dashboard_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  void changeTab(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  int _selectedIndex = 0;

  static const List<String> _pageTitles = [
    'Dashboard',
    'Report New Case',
    'Admin',
    'Education Hub',
    'My Profile',
  ];

  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = <Widget>[
      DashboardScreen(onNavigate: _onItemTapped),
      const ReportNewCaseScreen(),
      const AdminDashboardScreen(),
      const EducationScreen(),
      ProfileScreen(),
    ];
  }
  void onTap(){
    setState(() {
      _selectedIndex = 4;
    });
  }
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: _selectedIndex == 0
            ? Padding(
                padding: EdgeInsets.only(left: 15, top: 10, bottom: 10),
                child: InkWell(
                  onTap: onTap,
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Text(
                      'AS',
                      style: TextStyle(
                        color: Color.fromARGB(255, 19, 20, 20),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              )
            : IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  setState(() {
                    _selectedIndex = 0; // Go back to Dashboard
                  });
                },
              ),
        title: Text(_pageTitles[_selectedIndex]),
      ),
      body: IndexedStack(index: _selectedIndex, children: _pages),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.note_add_outlined),
            activeIcon: Icon(Icons.note_add),
            label: 'Report',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.admin_panel_settings_outlined), // ✅ Admin icon
            activeIcon: Icon(Icons.admin_panel_settings),
            label: 'Admin',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school_outlined),
            activeIcon: Icon(Icons.school),
            label: 'Learn',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            activeIcon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
