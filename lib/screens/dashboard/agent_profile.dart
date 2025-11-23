import 'package:flutter/material.dart';
import 'package:gramsetu_app/screens/dashboard/agent_profile.dart';
import 'package:gramsetu_app/theme/app_theme.dart';
import 'package:gramsetu_app/widgets/stat_card.dart';
import 'package:gramsetu_app/widgets/quick_action_card.dart';

class AgentDashboard extends StatelessWidget {
  const AgentDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        title: const Text('Agent Dashboard'),
        backgroundColor: AppTheme.primaryGreen,
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.account_circle),
            tooltip: 'Profile',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AgentProfilePage()),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Quick Actions',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 10),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                QuickActionCard(
                  title: 'Add Worker',
                  subtitle: 'Register new workers',
                  icon: Icons.person_add,
                  color: AppTheme.primaryGreen,
                  onTap: () {
                    // Navigate to add worker screen
                  },
                ),
                QuickActionCard(
                  title: 'Assign Job',
                  subtitle: 'Match jobs to workers',
                  icon: Icons.assignment,
                  color: Colors.orange,
                  onTap: () {
                    // Navigate to job assignment screen
                  },
                ),
                QuickActionCard(
                  title: 'Payments',
                  subtitle: 'Track and release payments',
                  icon: Icons.payment,
                  color: Colors.blue,
                  onTap: () {
                    // Navigate to payment screen
                  },
                ),
                QuickActionCard(
                  title: 'Reports',
                  subtitle: 'View performance stats',
                  icon: Icons.analytics,
                  color: Colors.purple,
                  onTap: () {
                    // Navigate to reports screen
                  },
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Text(
              'Statistics',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 10),
            const StatCard(
              title: 'Workers Added',
              value: '24',
              color: Color(0xFFDDEEFF),
            ),
            const StatCard(
              title: 'Jobs Assigned',
              value: '47',
              color: Color(0xFFEFE5FF),
            ),
            const StatCard(
              title: 'Pending Payments',
              value: '3',
              color: Color(0xFFFFF4D9),
            ),
            const StatCard(
              title: 'Total Earned',
              value: '₹46k',
              color: Color(0xFFDFFFE0),
            ),
          ],
        ),
      ),
    );
  }
}
