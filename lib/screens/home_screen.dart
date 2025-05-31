import 'package:artahub/routes/app_route_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../utils/helpers/carousel_slider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final cardWidth =
        MediaQuery.of(context).size.width * 0.45; // Menghitung lebar kartu
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.settings, color: Colors.white),
          onPressed: () {
            context.go(MyAppRouteConstants.settings);
          },
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: GestureDetector(
              onTap: () {
                context.go(MyAppRouteConstants.profile);
              },
              child: CircleAvatar(
                backgroundImage: AssetImage(
                    'assets/img/profile.png'), // Ganti dengan path avatar kamu
                radius: 18,
              ),
            ),
          ),
        ],
        backgroundColor: CupertinoColors.activeBlue,
        elevation: 0,
      ), // Jarak antara AppBar dan konten
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Column(
                children: [
                  Image.asset(
                    'assets/img/LogoArtaHubFix-removebg-preview 1.png', // Ganti dengan path logo kamu
                    height: 120, // Atur ukuran sesuai kebutuhan
                    width: 120, // Atur ukuran sesuai kebutuhan
                    fit: BoxFit.cover, // Atur cara menampilkan gambar
                    color: CupertinoColors.activeBlue,
                  ),
                  const SizedBox(width: 10), // Jarak antara logo dan teks
                  const Text(
                    'Hai, Selamat Datang Pengguna',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: CupertinoColors.activeBlue),
                  ),
                  const SizedBox(height: 26),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      padding: const EdgeInsets.only(left: 20),
                      child: const Text(
                        'Terkini',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(204, 46, 48, 49)),
                      ),
                    ),
                  ),
                  BeritaCarousel(),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      padding: const EdgeInsets.only(left: 20),
                      child: const Text(
                        'Fitur',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(204, 46, 48, 49)),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildCard(
                            icon: Icons.school,
                            label: 'Laboratorium Pendidikan',
                            width: cardWidth,
                            onTap: () {
                              context
                                  .pushNamed(MyAppRouteConstants.labpendidikan);
                            }),
                        _buildCard(
                            icon: Icons.forum,
                            label: 'Forum Diskusi',
                            width: cardWidth,
                            onTap: () {
                              context.pushNamed(MyAppRouteConstants.forum);
                            }),
                      ]),
                  _buildCard(
                      icon: Icons.wallet,
                      label: 'Dompet Pendidikan',
                      width: MediaQuery.of(context).size.width * 0.90,
                      onTap: () {
                        context.pushNamed(MyAppRouteConstants.dompet);
                      }),
                  const SizedBox(height: 10),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

Widget _buildCard({
  required IconData icon,
  required String label,
  required double width,
  required VoidCallback onTap,
}) {
  return Card(
    elevation: 4, // menambahkan shadow
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
    child: InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: onTap, // handle klik
      child: Container(
        width: width,
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 36, color: Colors.blue),
            const SizedBox(height: 4),
            Text(label, textAlign: TextAlign.center),
          ],
        ),
      ),
    ),
  );
}
