import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../dashboard/agent_dashboard.dart';
import '../worker/worker_dashboard.dart';
import '../client/client_dashboard.dart';
import '../auth/signup_screen.dart'; // 👈 Create this file next

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailOrPhoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String _selectedRole = '';

  void _login() {
    if (_selectedRole.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please select your role")),
      );
      return;
    }

    if (_emailOrPhoneController.text.isEmpty || _passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter your credentials")),
      );
      return;
    }

    // Navigate to the correct dashboard
    Widget destination;
    if (_selectedRole == 'Agent') {
      destination = const AgentDashboard();
    } else if (_selectedRole == 'Worker') {
      destination = const WorkerDashboard();
    } else {
      destination = const ClientDashboard();
    }

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => destination),
    );
  }

  Widget _buildRoleCard(String role, IconData icon, Color color) {
    final bool isSelected = _selectedRole == role;
    return GestureDetector(
      onTap: () => setState(() => _selectedRole = role),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected ? color.withOpacity(0.1) : Colors.white,
          border: Border.all(
            color: isSelected ? color : Colors.grey.shade300,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(14),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color, size: 36),
            const SizedBox(height: 8),
            Text(
              role,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16,
                color: isSelected ? color : Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Spacer(),
              const Text(
                "Welcome Back 👋",
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 6),
              const Text(
                "Login to your account",
                style: TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 30),

              // Email / Phone Input
              TextField(
                controller: _emailOrPhoneController,
                decoration: InputDecoration(
                  labelText: "Email or Phone",
                  prefixIcon: const Icon(Icons.person_outline),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 16),

              // Password Input
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: "Password",
                  prefixIcon: const Icon(Icons.lock_outline),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),

              const SizedBox(height: 30),

              const Text(
                "Login as",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 12),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(child: _buildRoleCard('Worker', Icons.construction, Colors.blue)),
                  const SizedBox(width: 12),
                  Expanded(child: _buildRoleCard('Agent', Icons.person, Colors.green)),
                  const SizedBox(width: 12),
                  Expanded(child: _buildRoleCard('Client', Icons.business_center, Colors.orange)),
                ],
              ),

              const SizedBox(height: 40),

              // Login Button
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.primaryGreen,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: _login,
                  child: const Text(
                    "Login",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Signup Redirect
              Center(
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const SignupScreen()),
                    );
                  },
                  child: const Text(
                    "Don't have an account? Create one",
                    style: TextStyle(color: Colors.blueAccent),
                  ),
                ),
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
