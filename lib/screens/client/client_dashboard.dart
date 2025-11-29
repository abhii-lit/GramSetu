import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../widgets/quick_action_card.dart';
import '../../widgets/stat_card.dart';
import '../client/client_profile_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ClientDashboard extends StatefulWidget {
  final String userName;

  const ClientDashboard({super.key, required this.userName});

  @override
  State<ClientDashboard> createState() => _ClientDashboardState();
}

class _ClientDashboardState extends State<ClientDashboard> {
  // Example fields for stats (replace with real queries)
  int jobsPosted = 0;
  int workersHired = 0;
  int pendingJobs = 0;
  String totalSpent = '₹0';

  bool _loadingStats = true;

  @override
  void initState() {
    super.initState();
    _loadStats();
  }

  Future<void> _loadStats() async {
    // TODO: Replace these with actual Firestore queries.
    // Example template for Firestore (uncomment & adapt to your schema):
    //
    // final uid = FirebaseAuth.instance.currentUser?.uid;
    // if (uid != null) {
    //   final jobsSnap = await FirebaseFirestore.instance.collection('jobs')
    //       .where('createdBy', isEqualTo: uid).get();
    //   final hiredSnap = await FirebaseFirestore.instance.collection('hired')
    //       .where('clientId', isEqualTo: uid).get();
    //   setState(() {
    //     jobsPosted = jobsSnap.size;
    //     workersHired = hiredSnap.size;
    //     // pendingJobs & totalSpent computed similarly
    //     pendingJobs = jobsSnap.docs.where((d) => d['status']=='pending').length;
    //     totalSpent = '₹${computeTotalSpent(jobsSnap).toString()}';
    //     _loadingStats = false;
    //   });
    //   return;
    // }
    //
    // For now, simulate loading:
    await Future.delayed(const Duration(milliseconds: 450));
    setState(() {
      jobsPosted = 12;
      workersHired = 32;
      pendingJobs = 3;
      totalSpent = '₹89,000';
      _loadingStats = false;
    });
  }

  Future<void> _signOut() async {
    await FirebaseAuth.instance.signOut();
    // If you use an AuthGate or Navigator routing, the app will react to auth change.
    // Otherwise navigate to login explicitly:
    // Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const LoginScreen()));
  }

  Widget _buildHeader(BuildContext context) {
    final name = widget.userName.trim();
    final initials = name.isEmpty
        ? 'U'
        : name.split(' ').map((s) => s.isNotEmpty ? s[0] : '').take(2).join().toUpperCase();

    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (_) => const ClientProfileScreen()));
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
        decoration: BoxDecoration(
          gradient: const LinearGradient(colors: [Color(0xFFEF8A4F), Color(0xFFFB9B67)]),
          borderRadius: BorderRadius.circular(14),
          boxShadow: [BoxShadow(color: Colors.orange.withOpacity(0.12), blurRadius: 12, offset: const Offset(0,6))],
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 30,
              backgroundColor: Colors.white,
              child: Text(initials, style: const TextStyle(color: Colors.deepOrange, fontSize: 20, fontWeight: FontWeight.bold)),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Welcome back,', style: TextStyle(color: Colors.white.withOpacity(0.95), fontSize: 14)),
                  const SizedBox(height: 4),
                  Text(
                    widget.userName,
                    style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w700),
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 6),
                  Text('Client • Employer', style: TextStyle(color: Colors.white.withOpacity(0.9))),
                ],
              ),
            ),
            PopupMenuButton<int>(
              color: Colors.white,
              icon: const Icon(Icons.more_vert, color: Colors.white),
              itemBuilder: (ctx) => [
                const PopupMenuItem(value: 1, child: Text('Profile')),
                const PopupMenuItem(value: 2, child: Text('Sign out')),
              ],
              onSelected: (v) {
                if (v == 1) {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => const ClientProfileScreen()));
                } else if (v == 2) {
                  _signOut();
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStats() {
    if (_loadingStats) {
      return const Center(child: Padding(padding: EdgeInsets.all(8), child: CircularProgressIndicator()));
    }

    return Column(
      children: [
        Row(
          children: [
            Expanded(child: StatCard(title: 'Jobs Posted', value: jobsPosted.toString(), icon: Icons.work)),
            const SizedBox(width: 12),
            Expanded(child: StatCard(title: 'Workers Hired', value: workersHired.toString(), icon: Icons.people)),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Expanded(child: StatCard(title: 'Pending Jobs', value: pendingJobs.toString(), icon: Icons.pending_actions)),
            const SizedBox(width: 12),
            Expanded(child: StatCard(title: 'Total Spent', value: totalSpent, icon: Icons.currency_rupee)),
          ],
        ),
      ],
    );
  }

  Widget _buildQuickActions() {
    return GridView.count(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      crossAxisCount: MediaQuery.of(context).size.width > 700 ? 4 : 2,
      crossAxisSpacing: 12,
      mainAxisSpacing: 12,
      childAspectRatio: 2.4,
      children: [
        QuickActionCard(
          title: 'Post Job',
          subtitle: 'Create a new job',
          icon: Icons.add_box_outlined,
          color: Colors.deepOrange,
          onTap: () {
            // TODO: push post job screen
          },
        ),
        QuickActionCard(
          title: 'Manage Jobs',
          subtitle: 'View / edit jobs',
          icon: Icons.edit_calendar,
          color: Colors.green,
          onTap: () {
            // TODO: push manage jobs screen
          },
        ),
        QuickActionCard(
          title: 'Payments',
          subtitle: 'Track expenses',
          icon: Icons.payments_outlined,
          color: Colors.purple,
          onTap: () {
            // TODO: push payments screen
          },
        ),
        QuickActionCard(
          title: 'Reports',
          subtitle: 'View analytics',
          icon: Icons.analytics_outlined,
          color: Colors.blue,
          onTap: () {
            // TODO: push reports screen
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final spacing = 16.0;
    return Scaffold(
      backgroundColor: AppTheme.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(spacing),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(context),
              const SizedBox(height: 18),
              const Text('Overview', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              _buildStats(),
              const SizedBox(height: 24),
              const Text('Quick Actions', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              _buildQuickActions(),
              const SizedBox(height: 36),

              // Example: quick links / suggestions
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 8)],
                ),
                child: Row(
                  children: [
                    const Icon(Icons.info_outline, color: Colors.black54),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        'Tip: Add clear job details and a fixed budget to attract more qualified workers.',
                        style: TextStyle(color: Colors.grey.shade800),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        // TODO: show onboarding/help
                      },
                      child: const Text('Learn more'),
                    )
                  ],
                ),
              ),

              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}
