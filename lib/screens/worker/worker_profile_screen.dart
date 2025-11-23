import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../auth/login_screen.dart';

class WorkerProfileScreen extends StatefulWidget {
  const WorkerProfileScreen({super.key});

  @override
  State<WorkerProfileScreen> createState() => _WorkerProfileScreenState();
}

class _WorkerProfileScreenState extends State<WorkerProfileScreen> {
  bool _isEditing = false;

  final TextEditingController _nameController =
      TextEditingController(text: "Sunil Yadav");
  final TextEditingController _roleController =
      TextEditingController(text: "Electrician");
  final TextEditingController _phoneController =
      TextEditingController(text: "+91 9988776655");
  final TextEditingController _skillsController =
      TextEditingController(text: "Wiring, Fan Repair, Lighting Installation");
  final TextEditingController _locationController =
      TextEditingController(text: "Lucknow, Uttar Pradesh");

  void _toggleEdit() => setState(() => _isEditing = !_isEditing);

  void _saveChanges() {
    setState(() => _isEditing = false);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Profile updated successfully")),
    );
  }

  void _signOut() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const LoginScreen()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: AppTheme.primaryGreen,
        title: const Text("Worker Profile"),
        actions: [
          IconButton(
            icon: Icon(_isEditing ? Icons.save : Icons.edit),
            onPressed: _isEditing ? _saveChanges : _toggleEdit,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const CircleAvatar(
              radius: 50,
              backgroundColor: AppTheme.primaryGreen,
              child: Icon(Icons.person, size: 60, color: Colors.white),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _nameController,
              enabled: _isEditing,
              textAlign: TextAlign.center,
              decoration: const InputDecoration(border: InputBorder.none),
              style: const TextStyle(
                  fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
            ),
            TextField(
              controller: _roleController,
              enabled: _isEditing,
              textAlign: TextAlign.center,
              decoration: const InputDecoration(border: InputBorder.none),
              style: const TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 20),
            const Divider(),

            _buildInfoField(
              icon: Icons.phone,
              label: "Phone Number",
              controller: _phoneController,
            ),
            _buildInfoField(
              icon: Icons.build,
              label: "Skills",
              controller: _skillsController,
            ),
            _buildInfoField(
              icon: Icons.location_on,
              label: "Location",
              controller: _locationController,
            ),

            const SizedBox(height: 30),

            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.redAccent,
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: _signOut,
              icon: const Icon(Icons.logout),
              label: const Text(
                "Sign Out",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoField({
    required IconData icon,
    required String label,
    required TextEditingController controller,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: controller,
        enabled: _isEditing,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon, color: AppTheme.primaryGreen),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Colors.grey),
          ),
        ),
      ),
    );
  }
}
