import 'package:carapp/app_localizations.dart';
import 'package:carapp/constants/Languages.dart';
import 'package:carapp/services/LanguageService.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'constants/AppData.dart';
import 'home.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AppData()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) =>
      ChangeNotifierProvider(
          create: (context) => LanguageService(),
          builder: (context, child) {
            final provider = Provider.of<LanguageService>(context);

            return MaterialApp(
              title: 'Car App',
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                primarySwatch: Colors.blue,
              ),
              localizationsDelegates: const [
                AppLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              supportedLocales: Languages.languages.map((e) => Locale(e.code))
                  .toList(),
              locale: provider.locale,
              home: const HomePage(title: 'Home'),
            );
          }
      );
}
