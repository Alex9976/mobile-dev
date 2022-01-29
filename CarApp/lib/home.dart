import 'package:carapp/page/cars.dart';
import 'package:carapp/page/map.dart';
import 'package:carapp/page/settings.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final List<Widget> screens = [
    const CarPage(),
    const MapPage(),
    const SettingsPage()
  ];

  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = const CarPage();

  void _changePage(index) {
    setState(() {
      currentScreen = screens[index];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageStorage(
        child: currentScreen,
        bucket: bucket,
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                blurRadius: 20,
                color: Colors.black.withOpacity(.1),
              )
            ]
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
            child: GNav(
              rippleColor: Colors.grey[300]!,
              hoverColor: Colors.grey[100]!,
              gap: 8,
              activeColor: Colors.black,
              iconSize: 24,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              duration: const Duration(milliseconds: 400),
              tabBackgroundColor: Colors.grey[100]!,
              tabs: const [
                GButton(
                  icon: LineIcons.car,
                  text: "Cars",
                ),
                GButton(
                  icon: LineIcons.map,
                  text: "Map",
                ),
                GButton(
                  icon: LineIcons.cog,
                  text: "Settings",
                ),
              ],
              onTabChange: (index){
                _changePage(index);
              },
            ),
          ),
        ),
      ),// This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}