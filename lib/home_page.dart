import 'package:flutter/material.dart';
import 'login_page.dart'; // Impor LoginPage untuk tombol Logout

class HomePage extends StatelessWidget {
  // Variabel untuk menampung nama
  final String name;

  // Constructor untuk menerima data nama
  const HomePage({super.key, required this.name});

  // Fungsi untuk proses logout, dipanggil dari drawer
  void _logout(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        backgroundColor: const Color(0xFF1E1E1E),
        elevation: 0,
        // Tombol logout 'actions' dihapus dari sini
        // Ikon menu (hamburger) akan muncul otomatis karena ada 'drawer'
      ),
      // --- TAMBAHAN: SIDEBAR (DRAWER) ---
      drawer: Drawer(
        backgroundColor: const Color(0xFF1E1E1E),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            // Header untuk Drawer
            UserAccountsDrawerHeader(
              accountName: Text(
                name,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              accountEmail: const Text("user@email.com"), // Email placeholder
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.blueAccent,
                child: Text(
                  name.isNotEmpty ? name[0].toUpperCase() : "A", // Inisial
                  style: const TextStyle(fontSize: 40.0, color: Colors.white),
                ),
              ),
              decoration: const BoxDecoration(
                color: Color(0xFF2A2A2A),
              ),
            ),
            // Item menu navigasi
            ListTile(
              leading: const Icon(Icons.home, color: Colors.white),
              title: const Text('Home', style: TextStyle(color: Colors.white)),
              onTap: () {
                Navigator.pop(context); // Tutup drawer
              },
            ),
            ListTile(
              leading: const Icon(Icons.person, color: Colors.white),
              title: const Text('Profile', style: TextStyle(color: Colors.white)),
              onTap: () {
                // TODO: Nanti bisa navigasi ke halaman profil
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings, color: Colors.white),
              title:
                  const Text('Settings', style: TextStyle(color: Colors.white)),
              onTap: () {
                // TODO: Nanti bisa navigasi ke halaman pengaturan
                Navigator.pop(context);
              },
            ),
            const Divider(color: Color(0xFF2A2A2A)),
            // Tombol Logout
            ListTile(
              leading: const Icon(Icons.logout, color: Colors.redAccent),
              title: const Text('Logout',
                  style: TextStyle(color: Colors.redAccent)),
              onTap: () => _logout(context), // Panggil fungsi logout
            ),
          ],
        ),
      ),
      // --- MODIFIKASI: TAMPILAN BODY UTAMA ---
      body: SingleChildScrollView(
        // Membuat body bisa di-scroll
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Bagian 1: Header Selamat Datang
            Text(
              'Selamat Datang Kembali,',
              style: TextStyle(fontSize: 18, color: Colors.grey[400]),
            ),
            Text(
              name,
              style: const TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 24),

            // Bagian 2: Judul Menu Grid
            const Text(
              'Menu Utama',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 16),

            // Bagian 3: Menu Grid
            GridView.count(
              crossAxisCount: 2, // 2 kolom
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              shrinkWrap: true, // Penting untuk GridView di dalam Column
              physics:
                  const NeverScrollableScrollPhysics(), // Agar tidak bentrok scroll
              children: [
                // Memanggil fungsi untuk membuat kartu menu
                _buildDashboardCard(
                  context,
                  icon: Icons.person_outline,
                  title: 'Profil Saya',
                  onTap: () {
                    // Aksi saat kartu 'Profil' ditekan
                  },
                ),
                _buildDashboardCard(
                  context,
                  icon: Icons.analytics_outlined,
                  title: 'Statistik',
                  onTap: () {
                    // Aksi saat kartu 'Statistik' ditekan
                  },
                ),
                _buildDashboardCard(
                  context,
                  icon: Icons.message_outlined,
                  title: 'Pesan',
                  onTap: () {
                    // Aksi saat kartu 'Pesan' ditekan
                  },
                ),
                _buildDashboardCard(
                  context,
                  icon: Icons.settings_outlined,
                  title: 'Pengaturan',
                  onTap: () {
                    // Aksi saat kartu 'Pengaturan' ditekan
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // --- WIDGET BARU: Fungsi untuk membuat kartu menu ---
  // Ini adalah "template" untuk kartu di dalam grid
  Widget _buildDashboardCard(BuildContext context,
      {required IconData icon,
      required String title,
      required VoidCallback onTap}) {
    return InkWell(
      // Membuat kartu bisa ditekan
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFF1E1E1E), // Warna kartu
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            // Memberi efek bayangan tipis
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              spreadRadius: 1,
              blurRadius: 5,
            )
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, size: 40, color: Colors.blueAccent),
            const SizedBox(height: 16),
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}