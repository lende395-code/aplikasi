import 'package:flutter/material.dart';
import 'login_screen.dart';

class DashboardScreen extends StatelessWidget {
  final String userEmail;

  const DashboardScreen({super.key, required this.userEmail});

  @override
  Widget build(BuildContext context) {
    // 3. DATA DUMMY 10 ITEM WAJIB
    final List<Map<String, dynamic>> menuItems = [
      {'icon': Icons.description, 'title': 'Dokumen 1'},
      {'icon': Icons.folder, 'title': 'Dokumen 2'},
      {'icon': Icons.analytics, 'title': 'Statistik'},
      {'icon': Icons.person, 'title': 'Profil'},
      {'icon': Icons.settings, 'title': 'Pengaturan'},
      {'icon': Icons.article, 'title': 'Laporan'},
      {'icon': Icons.group, 'title': 'Data User'},
      {'icon': Icons.calendar_today, 'title': 'Jadwal'},
      {'icon': Icons.notifications, 'title': 'Notifikasi'},
      {'icon': Icons.mail, 'title': 'Pesan'},
    ];

    return Scaffold(
      backgroundColor: Colors.grey[100],
      // 1. APPBAR + LOGOUT WAJIB
      appBar: AppBar(
        title: const Text('Dashboard'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              // 5. pushAndRemoveUntil WAJIB
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const LoginScreen()),
                (Route<dynamic> route) => false,
              );
            },
          ),
        ],
      ),
      // 6. DRAWER NILAI TAMBAH
      drawer: Drawer(
        child: ListView(
          children: const [
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
              child: Text('Menu', style: TextStyle(color: Colors.white, fontSize: 24)),
            ),
            ListTile(leading: Icon(Icons.home), title: Text('Home')),
            ListTile(leading: Icon(Icons.settings), title: Text('Settings')),
          ],
        ),
      ),
      body: Center(
        child: Container(
          width: 400,
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              // 4. CARD STYLING WAJIB
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    children: [
                      const CircleAvatar(
                        radius: 30,
                        backgroundColor: Colors.blue,
                        child: Icon(Icons.person, color: Colors.white, size: 35),
                      ),
                      const SizedBox(width: 16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Selamat Datang', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                          Text(userEmail, style: const TextStyle(color: Colors.grey)), // 2. DATA USER
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text('Menu Utama', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ),
              const SizedBox(height: 12),

              // 3. ListView.builder MINIMAL 10 ITEM - INI KUNCINYA
              Expanded(
                child: ListView.builder(
                  itemCount: menuItems.length, // 12 ITEM > 10
                  itemBuilder: (context, index) {
                    return Card(
                      margin: const EdgeInsets.only(bottom: 8),
                      child: ListTile(
                        leading: Icon(menuItems[index]['icon'], color: Colors.blue),
                        title: Text(menuItems[index]['title']),
                        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                        onTap: () {},
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}