import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../widgets/quick_action_card.dart';
import '../../widgets/stat_card.dart';
import '../worker/add_worker_screen.dart';
import '../worker/manage_workers_screen.dart';
import '../jobs/view_jobs_screen.dart';
import '../payments/payments_screen.dart';
import '../reports/reports_screen.dart';
import 'agent_profile_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AgentDashboard extends StatefulWidget {
  final String userName;

  const AgentDashboard({super.key, required this.userName});

  @override
  State<AgentDashboard> createState() => _AgentDashboardState();
}

class _AgentDashboardState extends State<AgentDashboard> {
  // stats (replace with Firestore queries)
  int workersAdded = 0;
  int jobsAssigned = 0;
  int pending = 0;
  String totalEarned = '₹0';
  bool loading = true;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    _loadStats();
  }

  Future<void> _loadStats() async {
    // TODO: Replace simulation with actual Firestore queries based on your schema.
    // Example:
    // final uid = FirebaseAuth.instance.currentUser?.uid;
    // if (uid != null) {
    //   final workers = await _firestore.collection('workers').where('addedBy', isEqualTo: uid).get();
    //   final jobs = await _firestore.collection('jobs').where('agentId', isEqualTo: uid).get();
    //   setState(() {
    //     workersAdded = workers.size;
    //     jobsAssigned = jobs.size;
    //     pending = jobs.docs.where((d) => d['status']=='pending').length;
    //     totalEarned = '₹${calculateTotal(jobs)}';
    //     loading = false;
    //   });
    //   return;
    // }
    await Future.delayed(const Duration(milliseconds: 420));
    setState(() {
      workersAdded = 24;
      jobsAssigned = 47;
      pending = 3;
      totalEarned = '₹46,000';
      loading = false;
    });
  }

  Future<void> _signOut() async {
    await FirebaseAuth.instance.signOut();
    // Your AuthGate should react to this and redirect to login.
  }

  String _initials(String name) {
    final parts = name.trim().split(' ');
    if (parts.isEmpty) return 'A';
    if (parts.length == 1) return parts.first.substring(0, 1).toUpperCase();
    return (parts[0][0] + parts[1][0]).toUpperCase();
  }

  Widget _buildHeader() {
    final initials = _initials(widget.userName);
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(colors: [Color(0xFF2BB673), Color(0xFF0EA16E)]),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.green.withOpacity(0.12), blurRadius: 12, offset: const Offset(0,6))],
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: Colors.white,
            child: Text(initials, style: const TextStyle(color: AppTheme.primaryGreen, fontWeight: FontWeight.bold, fontSize: 20)),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Hello,', style: TextStyle(color: Colors.white.withOpacity(0.9))),
                const SizedBox(height: 4),
                Text(
                  widget.userName,
                  style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w700),
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 6),
                Text('Verified Agent', style: TextStyle(color: Colors.white.withOpacity(0.9), fontSize: 13)),
              ],
            ),
          ),
          // Notifications icon
          IconButton(
            onPressed: () {
              // TODO: open notifications
            },
            icon: Stack(
              alignment: Alignment.topRight,
              children: [
                const Icon(Icons.notifications_none, color: Colors.white),
                Positioned(
                  right: 0,
                  top: 0,
                  child: Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(color: Colors.redAccent, borderRadius: BorderRadius.circular(8)),
                  ),
                ),
              ],
            ),
          ),
          // Profile menu
          PopupMenuButton<int>(
            icon: const Icon(Icons.more_vert, color: Colors.white),
            color: Colors.white,
            onSelected: (v) {
              if (v == 1) {
                Navigator.push(context, MaterialPageRoute(builder: (_) => AgentProfileScreen()));
              } else if (v == 2) {
                _signOut();
              }
            },
            itemBuilder: (_) => const [
              PopupMenuItem(value: 1, child: Text('Profile')),
              PopupMenuItem(value: 2, child: Text('Sign out')),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 8)],
      ),
      child: Row(
        children: [
          const Icon(Icons.search, color: Colors.black54),
          const SizedBox(width: 8),
          Expanded(
            child: TextField(
              decoration: const InputDecoration(
                hintText: 'Search jobs, workers or posts',
                border: InputBorder.none,
                isDense: true,
              ),
              onSubmitted: (q) {
                // TODO: implement search
              },
            ),
          ),
          IconButton(
            onPressed: () {
              // TODO: filter
            },
            icon: const Icon(Icons.filter_list),
          )
        ],
      ),
    );
  }

  Widget _buildStats() {
    if (loading) {
      return const Center(child: Padding(padding: EdgeInsets.symmetric(vertical: 12), child: CircularProgressIndicator()));
    }

    return Column(
      children: [
        Row(
          children: [
            Expanded(child: StatCard(title: 'Workers Added', value: workersAdded.toString(), icon: Icons.group)),
            const SizedBox(width: 12),
            Expanded(child: StatCard(title: 'Jobs Assigned', value: jobsAssigned.toString(), icon: Icons.work)),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Expanded(child: StatCard(title: 'Pending', value: pending.toString(), icon: Icons.access_time)),
            const SizedBox(width: 12),
            Expanded(child: StatCard(title: 'Total Earned', value: totalEarned, icon: Icons.currency_rupee)),
          ],
        ),
      ],
    );
  }

  Widget _buildQuickActions() {
    // Responsive columns
    final cross = MediaQuery.of(context).size.width > 700 ? 4 : 2;
    return GridView.count(
      crossAxisCount: cross,
      crossAxisSpacing: 12,
      mainAxisSpacing: 12,
      childAspectRatio: 2.4,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        QuickActionCard(
          title: 'Add Worker',
          subtitle: 'Register new worker',
          icon: Icons.person_add_alt_1,
          color: AppTheme.primaryGreen,
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const AddWorkerScreen())),
        ),
        QuickActionCard(
          title: 'View Workers',
          subtitle: 'Manage worker list',
          icon: Icons.list_alt,
          color: Colors.purple,
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ManageWorkersScreen())),
        ),
        QuickActionCard(
          title: 'Browse Jobs',
          subtitle: 'Find opportunities',
          icon: Icons.search,
          color: Colors.green,
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ViewJobsScreen())),
        ),
        QuickActionCard(
          title: 'Payments',
          subtitle: 'Track earnings',
          icon: Icons.payments,
          color: Colors.orange,
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const PaymentsScreen())),
        ),
        QuickActionCard(
          title: 'Reports',
          subtitle: 'Performance overview',
          icon: Icons.bar_chart,
          color: Colors.blueAccent,
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ReportsScreen())),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    const spacing = 16.0;
    return Scaffold(
      backgroundColor: AppTheme.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(spacing),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(),
              const SizedBox(height: 16),
              _buildSearchBar(),
              const SizedBox(height: 18),
              const Text('Overview', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              const SizedBox(height: 12),
              _buildStats(),
              const SizedBox(height: 24),
              const Text('Quick Actions', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              const SizedBox(height: 12),
              _buildQuickActions(),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 8)],
                ),
                child: Row(
                  children: [
                    const Icon(Icons.info_outline, color: Colors.black54),
                    const SizedBox(width: 10),
                    Expanded(child: Text('Tip: Keep worker documents complete (id, skills, experience) to speed up placement.', style: TextStyle(color: Colors.grey.shade800))),
                    TextButton(onPressed: () {/* TODO */}, child: const Text('Learn more'))
                  ],
                ),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
