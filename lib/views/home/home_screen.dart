import 'package:circular_bottom_navigation/circular_bottom_navigation.dart';
import 'package:circular_bottom_navigation/tab_item.dart';
import 'package:flutter/material.dart';
import 'package:my_clean_city/views/home/body_home.dart';
import 'package:my_clean_city/views/settings/profile_screen.dart';
import 'package:my_clean_city/views/settings/settings_screen.dart';
import 'package:my_clean_city/views/settings/theme_setting_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<TabItem> tabItems = List.of([
    TabItem(Icons.home, 'Home', Colors.green),
    TabItem(Icons.map, 'Map', Colors.green),
    TabItem(Icons.notifications, 'Notifications', Colors.green),
    TabItem(Icons.settings, 'Settings', Colors.green),
  ]);

  List<Widget> screens = [];

  int selectedIndex = 0;
  CircularBottomNavigationController _navigationController =
      CircularBottomNavigationController(0);
  @override
  void dispose() {
    _navigationController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _navigationController = CircularBottomNavigationController(selectedIndex);
    screens = [
      BodyHome(),
      ProfileScreen(),
      ThemeSettingScreen(),
      SettingsScreen(),
    ];
  }

  void onTabTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[selectedIndex],
      bottomNavigationBar: CircularBottomNavigation(
        tabItems,
        animationDuration: Duration(milliseconds: 300),
        controller: _navigationController,
        selectedCallback: (selectedPos) {
          setState(() {
            selectedIndex = selectedPos!;
          });
        },
      ),
    );
  }
}
