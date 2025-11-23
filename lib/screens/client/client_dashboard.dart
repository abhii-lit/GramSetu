import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../widgets/quick_action_card.dart';
import '../../widgets/stat_card.dart';
import '../client/client_profile_screen.dart';

class ClientDashboard extends StatelessWidget {
  const ClientDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ===== Header Section =====
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ClientProfileScreen(),
                    ),
                  );
                },
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.orange,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    children: [
                      const CircleAvatar(
                        radius: 24,
                        backgroundColor: Colors.white,
                        child: Icon(
                          Icons.business_center,
                          color: Colors.orange,
                          size: 28,
                        ),
                      ),
                      const SizedBox(width: 12),
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Welcome, Meera!",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            "Client / Employer",
                            style: TextStyle(color: Colors.white70),
                          ),
                        ],
                      ),
                      const Spacer(),
                      const Icon(Icons.settings, color: Colors.white),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // ===== Stats Section =====
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  StatCard(title: "Jobs Posted", value: "12", icon: Icons.work),
                  StatCard(title: "Workers Hired", value: "32", icon: Icons.people),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  StatCard(title: "Pending Jobs", value: "3", icon: Icons.pending_actions),
                  StatCard(title: "Total Spent", value: "₹89k", icon: Icons.currency_rupee),
                ],
              ),

              const SizedBox(height: 30),

              // ===== Quick Actions Section =====
              const Text(
                "Quick Actions",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(height: 10),

              GridView.count(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 2.2,
                children: [
                  QuickActionCard(
                    title: "Post Job",
                    subtitle: "Create new job",
                    icon: Icons.add_box,
                    color: Colors.orange,
                    onTap: () {
                      // TODO: Navigate to post job screen
                    },
                  ),
                  QuickActionCard(
                    title: "Manage Jobs",
                    subtitle: "View or edit jobs",
                    icon: Icons.edit_note,
                    color: Colors.green,
                    onTap: () {
                      // TODO: Navigate to manage jobs
                    },
                  ),
                  QuickActionCard(
                    title: "Payments",
                    subtitle: "Track expenses",
                    icon: Icons.payments,
                    color: Colors.purple,
                    onTap: () {
                      // TODO: Navigate to payments
                    },
                  ),
                  QuickActionCard(
                    title: "Reports",
                    subtitle: "View analytics",
                    icon: Icons.analytics,
                    color: Colors.blue,
                    onTap: () {
                      // TODO: Navigate to reports
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
