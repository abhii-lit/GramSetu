import 'package:flutter/material.dart';

class AddWorkerScreen extends StatelessWidget {
  const AddWorkerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add New Worker")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            TextField(decoration: const InputDecoration(labelText: "Worker Name")),
            const SizedBox(height: 12),
            TextField(decoration: const InputDecoration(labelText: "Skill / Job Type")),
            const SizedBox(height: 12),
            TextField(decoration: const InputDecoration(labelText: "Phone Number")),
            const SizedBox(height: 12),
            TextField(decoration: const InputDecoration(labelText: "Location")),
            const SizedBox(height: 24),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.blueAccent),
              onPressed: () {},
              child: const Text("Add Worker"),
            ),
          ],
        ),
      ),
    );
  }
}
