# 🎓 ArtaHub – Platform Edukasi Digital Berbasis AI, Blockchain, dan WebSocket

**ArtaHub** adalah platform App & WebApp edukatif modern yang dirancang untuk meningkatkan kualitas pembelajaran digital di era Industri 4.0. Aplikasi ini menyediakan fitur asisten AI untuk penyusunan Rencana Pembelajaran Semester (RPS), dompet digital berbasis blockchain Ethereum (ArtaHub Wallet), forum diskusi interaktif real-time, dan beranda edukatif terintegrasi.

---

## 🚀 Fitur Utama

### 🧠 AI RPS Assistant
- Membantu menyusun dan menganalisis Rencana Pembelajaran Semester
- Output format evaluatif yang bisa dikonversi ke dokumen akademik

### 💰 ArtaHub Wallet (Dompet Digital)
- Generate & Import wallet Ethereum (BIP39)
- Transfer & cek saldo token ERC-20 (TargaryenCoin)
- Interaksi smart contract via ABI JSON
- QR Code untuk kirim/terima kripto
- Semua data disimpan lokal (Hive), tanpa backend atau cloud

### 💬 Forum Diskusi
- Komunikasi real-time antar pelajar dan pendidik
- Dibangun menggunakan WebSocket

### 🏠 Beranda Edukatif
- Feed informasi terbaru seputar pendidikan, AI, blockchain
- Navigasi modern dengan `go_router`

### ⚙️ Fitur Tambahan
- Tema Gelap/Terang
- Halaman login, daftar, profil, dan pengaturan
- Semua data pengguna tersimpan di perangkat (no Firebase, no cloud)

---

## 🧑‍💻 Teknologi yang Digunakan

| Teknologi | Fungsi |
|----------|--------|
| Flutter + Dart | UI/UX Cross-Platform |
| Hive | Penyimpanan lokal ringan |
| Web3dart | Interaksi Ethereum dan token |
| Mobile Scanner | QR Code Scanner |
| GoRouter | Navigasi halaman |
| Provider | State management |
| Socket.IO | Komunikasi real-time |
| Gemini API | Analisis AI untuk RPS |

---

## 🛠️ Cara Menjalankan

```bash
# 1. Clone repository
git clone https://github.com/Dimasbro12/artahub.git
cd artahub

# 2. Install dependencies
flutter pub get

# 3. Jalankan aplikasi
flutter run
