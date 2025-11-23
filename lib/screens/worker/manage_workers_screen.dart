import 'package:flutter/material.dart';

class ManageWorkersScreen extends StatelessWidget {
  const ManageWorkersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final workers = [
      {"name": "Raju", "skill": "Mason"},
      {"name": "Sunita", "skill": "Farmer"},
      {"name": "Amit", "skill": "Driver"},
    ];

    return Scaffold(
      appBar: AppBar(title: const Text("Manage Workers")),
      body: ListView.builder(
        itemCount: workers.length,
        itemBuilder: (context, index) {
          final worker = workers[index];
          return ListTile(
            leading: const CircleAvatar(child: Icon(Icons.person)),
            title: Text(worker["name"]!),
            subtitle: Text(worker["skill"]!),
            trailing: IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () {},
            ),
          );
        },
      ),
    );
  }
}

