import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:artahub/routes/app_route_config.dart';
import 'package:flutter/services.dart';
import 'values/app_theme.dart';
import 'package:provider/provider.dart';
import 'package:artahub/utils/helpers/theme_helper.dart';
import 'package:artahub/wallet/services_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:artahub/wallet/utils/http_override.dart';

void main() async {
  if (kDebugMode) {
    HttpOverrides.global = MyHttpOverrides();
  }

  WidgetsFlutterBinding.ensureInitialized();

  const firebaseWebOptions = FirebaseOptions(
    apiKey: 'AIzaSyDWvJXaUYfFKdTHNxv5EA0iNEuCUAY7Nbo',
    authDomain: 'etherwallet-18c58.firebaseapp.com',
    databaseURL: 'https://etherwallet-18c58.firebaseio.com',
    projectId: 'etherwallet-18c58',
    storageBucket: 'etherwallet-18c58.appspot.com',
    messagingSenderId: '1087248227022',
    appId: '1:1087248227022:web:df8ff8ba4d302b361a4e9f',
    measurementId: 'G-V04M927HSD',
  );

  await Firebase.initializeApp(
    options: kIsWeb ? firebaseWebOptions : null,
  );

  final stores = await createProviders();

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => ThemeNotifier()),
          Provider.value(value: stores), // <-- kalau mau disimpan global
        ],
        child: MyApp(stores: stores),
      ),
    );
  });
}

class MyApp extends StatelessWidget {
  final dynamic stores;

  MyApp({super.key, required this.stores});

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    final _router = MyAppRouter(stores).router;

    return MaterialApp.router(
      title: 'ArtaHub',
      theme: AppTheme.themeData,
      darkTheme: AppTheme.darkThemeData,
      routerConfig: _router,
      debugShowCheckedModeBanner: true,
      themeMode: themeNotifier.currentTheme,
    );
  }
}
