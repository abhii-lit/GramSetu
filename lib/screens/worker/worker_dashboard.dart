import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../widgets/quick_action_card.dart';
import '../../widgets/stat_card.dart';
import '../worker/worker_profile_screen.dart';

class WorkerDashboard extends StatelessWidget {
  const WorkerDashboard({super.key});

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
                      builder: (context) => const WorkerProfileScreen(),
                    ),
                  );
                },
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppTheme.primaryGreen,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    children: [
                      const CircleAvatar(
                        radius: 24,
                        backgroundColor: Colors.white,
                        child: Icon(
                          Icons.engineering,
                          color: AppTheme.primaryGreen,
                          size: 28,
                        ),
                      ),
                      const SizedBox(width: 12),
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Welcome, Rajesh!",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            "Skilled Worker",
                            style: TextStyle(color: Colors.white70),
                          ),
                        ],
                      ),
                      const Spacer(),
                      const Icon(Icons.notifications, color: Colors.white),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // ===== Stats Section =====
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  StatCard(
                    title: "Active Jobs",
                    value: "5",
                    icon: Icons.work_outline,
                  ),
                  StatCard(
                    title: "Completed",
                    value: "22",
                    icon: Icons.check_circle_outline,
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  StatCard(
                    title: "Pending",
                    value: "2",
                    icon: Icons.access_time,
                  ),
                  StatCard(
                    title: "Earnings",
                    value: "₹18k",
                    icon: Icons.currency_rupee,
                  ),
                ],
              ),

              const SizedBox(height: 30),

              // ===== Quick Actions =====
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
                    title: "Browse Jobs",
                    subtitle: "Find new work",
                    icon: Icons.search,
                    color: AppTheme.primaryGreen,
                    onTap: () {
                      // TODO: Navigate to job search screen
                    },
                  ),
                  QuickActionCard(
                    title: "My Applications",
                    subtitle: "View applied jobs",
                    icon: Icons.assignment_turned_in,
                    color: Colors.orange,
                    onTap: () {
                      // TODO: Navigate to applied jobs
                    },
                  ),
                  QuickActionCard(
                    title: "Payments",
                    subtitle: "Track your earnings",
                    icon: Icons.payments,
                    color: Colors.purple,
                    onTap: () {
                      // TODO: Navigate to payments
                    },
                  ),
                  QuickActionCard(
                    title: "Support",
                    subtitle: "Get help",
                    icon: Icons.support_agent,
                    color: Colors.blue,
                    onTap: () {
                      // TODO: Navigate to support screen
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
