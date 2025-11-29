import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../theme/app_theme.dart';
import '../dashboard/agent_dashboard.dart';
import '../worker/worker_dashboard.dart';
import '../client/client_dashboard.dart' as client; // 👈 FIX: avoid name clash
import '../auth/signup_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _emailOrPhoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  String _selectedRole = '';
  bool _loading = false;
  bool _obscure = true;

  @override
  void dispose() {
    _emailOrPhoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _show(String text) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text)));
  }

  Future<void> _sendPasswordReset() async {
    final id = _emailOrPhoneController.text.trim();
    if (id.isEmpty || !id.contains('@')) {
      _show('Please enter your registered email to reset password.');
      return;
    }
    try {
      await _auth.sendPasswordResetEmail(email: id);
      _show('Password reset email sent. Check your inbox.');
    } catch (e) {
      _show('Error: $e');
    }
  }

  // ---------- MAIN LOGIN ----------
  Future<void> _login() async {
    if (!_formKey.currentState!.validate()) return;
    if (_selectedRole.isEmpty) {
      _show('Please select a role.');
      return;
    }

    final id = _emailOrPhoneController.text.trim();
    final password = _passwordController.text;

    setState(() => _loading = true);

    try {
      // Resolve email (if phone login)
      String emailForSignIn = id;

      if (!id.contains('@')) {
        final q = await _firestore
            .collection('users')
            .where('phone', isEqualTo: id)
            .limit(1)
            .get();

        if (q.docs.isEmpty) {
          throw FirebaseAuthException(code: 'user-not-found', message: 'No user found with this phone');
        }

        emailForSignIn = q.docs.first['email'];
      }

      // Firebase Auth login
      final cred = await _auth.signInWithEmailAndPassword(
        email: emailForSignIn,
        password: password,
      );

      final user = cred.user;
      if (user == null) throw FirebaseAuthException(code: 'no-uid', message: 'Invalid user');

      // Firestore user data
      final doc = await _firestore.collection('users').doc(user.uid).get();
      if (!doc.exists) {
        _auth.signOut();
        _show("User data not found. Please sign up.");
        return;
      }

      final data = doc.data()!;
      final role = (data['role'] ?? '').toLowerCase();
      final selected = _selectedRole.toLowerCase();
      final name = data['name'] ?? "User";

      if (role != selected) {
        await _auth.signOut();
        _show('Role mismatch. Your role is "$role". Choose correct role.');
        return;
      }

      // ---------- NAVIGATION ----------
      late Widget destination;

      if (role == "agent") {
        destination = AgentDashboard(userName: name);
      } else if (role == "worker") {
        destination = WorkerDashboard(userName: name);
      } else {
        destination = client.ClientDashboard(userName: name); // 👈 FIX
      }

      if (!mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => destination),
      );

    } on FirebaseAuthException catch (e) {
      String msg = 'Login failed.';
      if (e.code == 'user-not-found') msg = 'User not found.';
      if (e.code == 'wrong-password') msg = 'Wrong password.';
      if (e.code == 'invalid-email') msg = 'Invalid email.';
      if (e.code == 'user-disabled') msg = 'User disabled.';
      _show(msg);
    } catch (e) {
      _show('Error: $e');
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  Widget _buildRoleCard(String role, IconData icon, Color color) {
    final isSelected = _selectedRole == role;
    return GestureDetector(
      onTap: () => setState(() => _selectedRole = role),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: isSelected ? color.withOpacity(0.12) : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? color : Colors.grey.shade300,
            width: isSelected ? 2 : 1,
          ),
          boxShadow: isSelected
              ? [BoxShadow(color: color.withOpacity(0.05), blurRadius: 8)]
              : null,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 34, color: isSelected ? color : Colors.grey.shade700),
            const SizedBox(height: 8),
            Text(role, style: TextStyle(fontWeight: FontWeight.w600, color: isSelected ? color : Colors.black87)),
          ],
        ),
      ),
    );
  }

  // ---------- UI ----------
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const Spacer(),
              const Text("Welcome Back 👋", style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
              const SizedBox(height: 6),
              const Text("Login to your account", style: TextStyle(color: Colors.grey)),
              const SizedBox(height: 24),

              Form(
                key: _formKey,
                child: Column(
                  children: [
                    // Email or Phone
                    TextFormField(
                      controller: _emailOrPhoneController,
                      validator: (v) => v!.trim().isEmpty ? "Enter email or phone" : null,
                      decoration: InputDecoration(
                        labelText: "Email or Phone",
                        prefixIcon: const Icon(Icons.person_outline),
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Password
                    TextFormField(
                      controller: _passwordController,
                      obscureText: _obscure,
                      validator: (v) => v!.isEmpty ? "Enter password" : null,
                      decoration: InputDecoration(
                        labelText: "Password",
                        prefixIcon: const Icon(Icons.lock_outline),
                        suffixIcon: IconButton(
                          icon: Icon(_obscure ? Icons.visibility_off : Icons.visibility),
                          onPressed: () => setState(() => _obscure = !_obscure),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                    ),

                    const SizedBox(height: 16),

                    Row(
                      children: [
                        TextButton(
                          onPressed: _loading ? null : _sendPasswordReset,
                          child: const Text("Forgot password?"),
                        ),
                      ],
                    ),

                    const SizedBox(height: 12),
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text("Login as", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                    ),
                    const SizedBox(height: 12),

                    // Role cards
                    Row(
                      children: [
                        Expanded(child: _buildRoleCard('Worker', Icons.construction, Colors.blue)),
                        const SizedBox(width: 12),
                        Expanded(child: _buildRoleCard('Agent', Icons.person, Colors.green)),
                        const SizedBox(width: 12),
                        Expanded(child: _buildRoleCard('Client', Icons.business_center, Colors.orange)),
                      ],
                    ),

                    const SizedBox(height: 24),

                    // Login Button
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: _loading ? null : _login,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppTheme.primaryGreen,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                        child: _loading
                            ? const CircularProgressIndicator(color: Colors.white, strokeWidth: 2)
                            : const Text("Login", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                      ),
                    ),

                    const SizedBox(height: 10),

                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const SignupScreen()),
                        );
                      },
                      child: const Text("Don't have an account? Create one"),
                    ),
                  ],
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
