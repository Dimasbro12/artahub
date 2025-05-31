import 'package:artahub/wallet/context/wallet/wallet_provider.dart';
import 'package:artahub/wallet/router.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

class DompetScreen extends StatelessWidget {
  const DompetScreen(this.stores, {Key? key}) : super(key: key);

  final List<SingleChildWidget> stores;

  static FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  static FirebaseAnalyticsObserver observer =
      FirebaseAnalyticsObserver(analytics: analytics);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: stores,
      child: WalletProvider(
        builder: (context, store) => MaterialApp(
          title: 'ArtaHub',
          initialRoute: '/',
          routes: getRoutes(context),
          navigatorObservers: [observer],
          theme: ThemeData(
            primarySwatch: Colors.blue,
            buttonTheme: const ButtonThemeData(
              buttonColor: Colors.blue,
              textTheme: ButtonTextTheme.primary,
            ),
          ),
        ),
      ),
    );
  }
}
