import 'package:flutter/material.dart';
import '../auth/login_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("My Profile")),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const CircleAvatar(
              radius: 50,
              backgroundColor: Colors.green,
              child: Icon(Icons.person, color: Colors.white, size: 50),
            ),
            const SizedBox(height: 12),
            const Text("Ramesh Kumar", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const Text("Village Panchayat Member", style: TextStyle(color: Colors.grey)),
            const SizedBox(height: 24),
            ListTile(
              leading: const Icon(Icons.phone),
              title: const Text("+91 98765 43210"),
            ),
            ListTile(
              leading: const Icon(Icons.location_on),
              title: const Text("Rampur, Uttar Pradesh"),
            ),
            ListTile(
              leading: const Icon(Icons.badge),
              title: const Text("Verified Agent"),
              trailing: Icon(Icons.verified, color: Colors.green.shade700),
            ),
            const Spacer(),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent, minimumSize: const Size.fromHeight(48)),
              onPressed: () {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const LoginScreen()));
              },
              icon: const Icon(Icons.logout),
              label: const Text("Logout"),
            )
          ],
        ),
      ),
    );
  }
}
