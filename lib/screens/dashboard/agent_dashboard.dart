import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../widgets/stat_card.dart';
import '../../widgets/quick_action_card.dart';
import '../worker/add_worker_screen.dart';
import '../worker/manage_workers_screen.dart';
import '../jobs/view_jobs_screen.dart';
import '../payments/payments_screen.dart';
import '../reports/reports_screen.dart';
import '../dashboard/agent_profile_screen.dart'; // 👈 Add this new file

class AgentDashboard extends StatelessWidget {
  const AgentDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ===== Header Section =====
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const AgentProfileScreen()),
                  );
                },
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppTheme.primaryGreen,
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 26,
                            backgroundColor: AppTheme.lightGreen.withOpacity(0.3),
                            child: const Icon(Icons.person, color: Colors.white, size: 30),
                          ),
                          const SizedBox(width: 12),
                          const Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Welcome back, Ramesh Kumar!",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  "Village Panchayat Member",
                                  style: TextStyle(
                                    color: Colors.white70,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Icon(Icons.arrow_forward_ios, color: Colors.white, size: 20),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Text(
                          "Verified Agent",
                          style: TextStyle(
                            color: AppTheme.primaryGreen,
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // ===== Stats Section =====
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  StatCard(title: "Workers Added", value: "24", icon: Icons.group),
                  StatCard(title: "Jobs Assigned", value: "47", icon: Icons.work),
                ],
              ),
              const SizedBox(height: 10),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  StatCard(title: "Pending", value: "3", icon: Icons.access_time),
                  StatCard(title: "Total Earned", value: "₹46k", icon: Icons.currency_rupee),
                ],
              ),

              const SizedBox(height: 32),

              // ===== Quick Actions =====
              const Text(
                "Quick Actions",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
              ),
              const SizedBox(height: 12),

              GridView.count(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 2.3,
                children: [
                  QuickActionCard(
                    title: "Add Worker",
                    subtitle: "Register new worker",
                    icon: Icons.person_add_alt_1,
                    color: AppTheme.primaryGreen,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const AddWorkerScreen()),
                      );
                    },
                  ),
                  QuickActionCard(
                    title: "View Workers",
                    subtitle: "Manage worker list",
                    icon: Icons.list_alt,
                    color: Colors.purple,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const ManageWorkersScreen()),
                      );
                    },
                  ),
                  QuickActionCard(
                    title: "Browse Jobs",
                    subtitle: "Find opportunities",
                    icon: Icons.search,
                    color: Colors.green,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const ViewJobsScreen()),
                      );
                    },
                  ),
                  QuickActionCard(
                    title: "Payments",
                    subtitle: "Track earnings",
                    icon: Icons.payments,
                    color: Colors.orange,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const PaymentsScreen()),
                      );
                    },
                  ),
                  QuickActionCard(
                    title: "Reports",
                    subtitle: "Performance overview",
                    icon: Icons.bar_chart,
                    color: Colors.blueAccent,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const ReportsScreen()),
                      );
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
