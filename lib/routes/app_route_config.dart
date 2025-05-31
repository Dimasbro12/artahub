import 'package:artahub/routes/app_route_constants.dart';
import 'package:artahub/screens/diskusi_screen.dart';
import 'package:artahub/screens/dompet_screen.dart';
import 'package:artahub/screens/home_screen.dart';
import 'package:artahub/screens/labpendidikan_screens.dart';
import 'package:artahub/screens/login_screen.dart';
import 'package:artahub/screens/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:artahub/screens/splash_screen.dart';
import 'package:artahub/screens/loading.dart';
import 'package:artahub/screens/daftar_screen.dart';
import 'package:artahub/screens/settings_screen.dart';

class MyAppRouter {
  final dynamic stores;

  MyAppRouter(this.stores);

  late final GoRouter router = GoRouter(
    routes: [
      GoRoute(
        name: MyAppRouteConstants.login,
        path: '/login',
        pageBuilder: (context, state) => const MaterialPage(
          child: LoginScreen(),
        ),
      ),
      GoRoute(
        name: MyAppRouteConstants.register,
        path: '/register',
        pageBuilder: (context, state) => const MaterialPage(
          child: RegisterScreen(),
        ),
      ),
      GoRoute(
        name: MyAppRouteConstants.home,
        path: '/home',
        pageBuilder: (context, state) => const MaterialPage(
          child: HomeScreen(),
        ),
      ),
      GoRoute(
        name: MyAppRouteConstants.settings,
        path: '/settings',
        pageBuilder: (context, state) => const MaterialPage(
          child: SettingsScreen(),
        ),
      ),
      GoRoute(
        name: MyAppRouteConstants.profile,
        path: '/profile',
        pageBuilder: (context, state) => const MaterialPage(
          child: ProfileScreen(),
        ),
      ),
      GoRoute(
        name: MyAppRouteConstants.labpendidikan,
        path: '/labpendidikan',
        pageBuilder: (context, state) => const MaterialPage(
          child: LabPendidikanPage(),
        ),
      ),
      GoRoute(
        name: MyAppRouteConstants.forum,
        path: '/forum',
        pageBuilder: (context, state) => const MaterialPage(
          child: DiskusiScreen(),
        ),
      ),
      GoRoute(
        name: MyAppRouteConstants.dompet,
        path: '/dompet',
        pageBuilder: (context, state) => MaterialPage(
          child: DompetScreen(stores),
        ),
      ),
      GoRoute(
        name: MyAppRouteConstants.splash,
        path: '/',
        pageBuilder: (context, state) => const MaterialPage(
          child: SplashScreen(),
        ),
      ),
      GoRoute(
        name: MyAppRouteConstants.Loading,
        path: '/loading',
        pageBuilder: (context, state) => const MaterialPage(
          child: Loading(),
        ),
      ),
    ],
    errorPageBuilder: (context, state) => const MaterialPage(
      child: Scaffold(
        body: Center(
          child: Text('Error: Page not found'),
        ),
      ),
    ),
  );
}
