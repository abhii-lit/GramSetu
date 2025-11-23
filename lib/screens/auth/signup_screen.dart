import 'package:flutter/material.dart';
import 'login_screen.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final nameController = TextEditingController();
    final emailController = TextEditingController();
    final passwordController = TextEditingController();

    return Scaffold(
      appBar: AppBar(title: const Text("Create Account")),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: ListView(
          children: [
            const SizedBox(height: 12),
            TextField(controller: nameController, decoration: const InputDecoration(labelText: "Full Name")),
            const SizedBox(height: 16),
            TextField(controller: emailController, decoration: const InputDecoration(labelText: "Email")),
            const SizedBox(height: 16),
            TextField(controller: passwordController, obscureText: true, decoration: const InputDecoration(labelText: "Password")),

            const SizedBox(height: 28),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.blueAccent, minimumSize: const Size.fromHeight(48)),
              onPressed: () {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const LoginScreen()));
              },
              child: const Text("Sign Up"),
            ),
          ],
        ),
      ),
    );
  }
}
