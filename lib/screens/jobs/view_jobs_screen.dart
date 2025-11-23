import 'package:flutter/material.dart';

class ViewJobsScreen extends StatelessWidget {
  const ViewJobsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final jobs = [
      {"title": "Harvesting Work", "location": "Village A", "status": "Open"},
      {"title": "Construction Help", "location": "Village B", "status": "Ongoing"},
      {"title": "Tractor Driver", "location": "Village C", "status": "Completed"},
    ];

    return Scaffold(
      appBar: AppBar(title: const Text("Jobs Overview")),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: jobs.length,
        itemBuilder: (context, index) {
          final job = jobs[index];
          return Card(
            elevation: 2,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: ListTile(
              leading: const CircleAvatar(
                backgroundColor: Colors.green,
                child: Icon(Icons.work, color: Colors.white),
              ),
              title: Text(job["title"]!),
              subtitle: Text(job["location"]!),
              trailing: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: job["status"] == "Completed"
                      ? Colors.green.shade100
                      : job["status"] == "Ongoing"
                          ? Colors.orange.shade100
                          : Colors.blue.shade100,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  job["status"]!,
                  style: TextStyle(
                    color: job["status"] == "Completed"
                        ? Colors.green.shade700
                        : job["status"] == "Ongoing"
                            ? Colors.orange.shade700
                            : Colors.blue.shade700,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
