import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  @override
  State<SplashScreen> createState() => _PreloadingState();
}

class _PreloadingState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
          child: FadeInImage(
        placeholder:
            const AssetImage('assets/img/animated_loader_gif_n6b5x0.gif'),
        image: const AssetImage(
            'assets/img/LogoArtaHubFix-removebg-preview 1.png'),
        fit: BoxFit.cover,
        fadeInDuration: const Duration(milliseconds: 500),
        fadeOutDuration: const Duration(milliseconds: 500),
      )),
    );
  }
}
