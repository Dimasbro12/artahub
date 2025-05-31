import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:url_launcher/url_launcher.dart';

class BeritaCarousel extends StatelessWidget {
  const BeritaCarousel({super.key});

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      items: [
        _buildImage(
          "https://www.unesa.ac.id/images/foto-09-05-2025-05-26-52-5758.png",
          "https://unesa.ac.id/langkah-unesa-merespons-dan-mengatasi-dugaan-scam-yang-dialami-mahasiswa",
        ),
        _buildImage(
          "https://www.unesa.ac.id/images/foto-09-05-2025-05-22-31-7346.png",
          "https://unesa.ac.id/fakultas-ketahanan-pangan-canangkan-zona-integritas-menuju-wbk-dan-wbbm",
        ),
        _buildImage(
          "https://unesa.ac.id/images/foto-23-04-2025-07-32-57-538.png",
          "https://unesa.ac.id/berjalan-lancar-utbk-hari-pertama-di-unesa-diikuti-2462-peserta",
        ),
        _buildImage(
          "https://unesa.ac.id/images/foto-01-05-2025-01-02-35-3897.png",
          "https://unesa.ac.id/hari-buruh-dosen-fisipol-soroti-hak-upah-minimum-dan-phk",
        ),
        _buildImage(
          "https://unesa.ac.id/images/foto-07-05-2025-07-31-54-1969.png",
          "https://unesa.ac.id/tugas-akhir-menjawab-kebutuhan-publik-taburan-inovasi-mahasiswa-dkv-dalam-enigma-2025",
        ),
      ],
      options: CarouselOptions(
        height: 180.0,
        enlargeCenterPage: true,
        autoPlay: true,
        aspectRatio: 16 / 9,
        autoPlayCurve: Curves.fastOutSlowIn,
        enableInfiniteScroll: true,
        autoPlayAnimationDuration: const Duration(milliseconds: 800),
        viewportFraction: 0.8,
      ),
    );
  }

  Widget _buildImage(String imageUrl, String linkUrl) {
    return GestureDetector(
      onTap: () async {
        if (await canLaunch(linkUrl)) {
          await launch(linkUrl); // Membuka URL di browser
        } else {
          throw 'Could not launch $linkUrl';
        }
      },
      child: Container(
        margin: const EdgeInsets.all(6.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          image: DecorationImage(
            image: NetworkImage(imageUrl),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
