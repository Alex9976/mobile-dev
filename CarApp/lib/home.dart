import 'package:carapp/extensions/string_extensions.dart';
import 'package:carapp/page/cars.dart';
import 'package:carapp/page/map.dart';
import 'package:carapp/page/settings.dart';
import 'package:carapp/services/DataService.dart';
import 'package:carapp/services/FirebaseService.dart';
import 'package:carapp/services/TextService.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';

import 'constants/LanguageConstants.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

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
  void initState() {
    super.initState();
    FirebaseService.initFirebase();
  }

  @override
  Widget build(BuildContext context) {
    final fontProvider = Provider.of<TextService>(context);

    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: DataService.primaryColor));

    return Scaffold(
      body: PageStorage(
        child: currentScreen,
        bucket: bucket,
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(color: Colors.white, boxShadow: [
          BoxShadow(
            blurRadius: 20,
            color: Colors.black.withOpacity(.1),
          )
        ]),
        child: SafeArea(
          child: Padding(
            padding:
            const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
            child: GNav(
              rippleColor: Colors.grey[300]!,
              hoverColor: Colors.grey[100]!,
              gap: 8,
              activeColor: Colors.black,
              iconSize: 24,
              padding:
              const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              duration: const Duration(milliseconds: 400),
              tabBackgroundColor: Colors.grey[100]!,
              tabs: [
                GButton(
                  icon: LineIcons.car,
                  text: LanguageConstants.carsTabButton.t(context),
                  textStyle: TextStyle(
                      fontSize: fontProvider.fontSize,
                      color: fontProvider.fontColor),
                ),
                GButton(
                  icon: LineIcons.map,
                  text: LanguageConstants.mapTabButton.t(context),
                  textStyle: TextStyle(
                      fontSize: fontProvider.fontSize,
                      color: fontProvider.fontColor),
                ),
                GButton(
                  icon: LineIcons.cog,
                  text: LanguageConstants.settingsTabButton.t(context),
                  textStyle: TextStyle(
                      fontSize: fontProvider.fontSize,
                      color: fontProvider.fontColor),
                ),
              ],
              onTabChange: (index) {
                _changePage(index);
              },
            ),
          ),
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
