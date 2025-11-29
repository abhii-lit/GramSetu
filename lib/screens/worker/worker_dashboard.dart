import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../widgets/quick_action_card.dart';
import '../../widgets/stat_card.dart';
import '../jobs/view_jobs_screen.dart';
import '../payments/payments_screen.dart';
import '../reports/reports_screen.dart';
import '../auth/login_screen.dart'; // used to navigate back after sign out

class WorkerDashboard extends StatefulWidget {
  final String userName;
  const WorkerDashboard({super.key, required this.userName});

  @override
  State<WorkerDashboard> createState() => _WorkerDashboardState();
}

class _WorkerDashboardState extends State<WorkerDashboard> {
  // placeholder stats — replace with Firestore queries if needed
  int tasksDone = 0;
  int activeJobs = 0;
  int pendingPayments = 0;
  String earnings = '₹0';
  bool loading = true;

  @override
  void initState() {
    super.initState();
    _loadStats();
  }

  Future<void> _loadStats() async {
    setState(() => loading = true);

    // TODO: Replace with Firestore queries based on your schema.
    // Example:
    // final uid = FirebaseAuth.instance.currentUser?.uid;
    // if (uid != null) {
    //   final jobs = await FirebaseFirestore.instance
    //       .collection('jobs')
    //       .where('workerId', isEqualTo: uid)
    //       .get();
    //   setState(() {
    //     tasksDone = jobs.docs.where((d) => d['status'] == 'done').length;
    //     activeJobs = jobs.docs.where((d) => d['status'] == 'active').length;
    //     pendingPayments = calculatePendingPayments(jobs);
    //     earnings = '₹${calculateEarnings(jobs)}';
    //     loading = false;
    //   });
    //   return;
    // }

    await Future.delayed(const Duration(milliseconds: 450));
    setState(() {
      tasksDone = 18;
      activeJobs = 4;
      pendingPayments = 1;
      earnings = '₹12,400';
      loading = false;
    });
  }

  Future<void> _signOut() async {
    await FirebaseAuth.instance.signOut();
    // Navigate to login (explicit) so the user returns to sign-in screen
    if (!mounted) return;
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const LoginScreen()),
      (route) => false,
    );
  }

  String _initials(String name) {
    final parts = name.trim().split(RegExp(r'\s+'));
    if (parts.isEmpty) return 'W';
    if (parts.length == 1) return parts.first[0].toUpperCase();
    return (parts[0][0] + parts[1][0]).toUpperCase();
  }

  // Pull-to-refresh handler
  Future<void> _onRefresh() async {
    await _loadStats();
  }

  Widget _buildHeader(BuildContext context) {
    final initials = _initials(widget.userName);
    final width = MediaQuery.of(context).size.width;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(colors: [Color(0xFF4C9F70), Color(0xFF2BB673)]),
        borderRadius: BorderRadius.circular(14),
        boxShadow: [BoxShadow(color: Colors.green.withOpacity(0.08), blurRadius: 12)],
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: width > 600 ? 32 : 28,
            backgroundColor: Colors.white,
            child: Text(
              initials,
              style: const TextStyle(
                color: AppTheme.primaryGreen,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('Welcome back,', style: TextStyle(color: Colors.white.withOpacity(0.95), fontSize: 13)),
              const SizedBox(height: 4),
              Text(
                widget.userName,
                style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w700),
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 6),
              Text('Worker • Skilled', style: TextStyle(color: Colors.white.withOpacity(0.9))),
            ]),
          ),
          PopupMenuButton<int>(
            icon: const Icon(Icons.more_vert, color: Colors.white),
            color: Colors.white,
            tooltip: 'Profile & actions',
            itemBuilder: (_) => const [
              PopupMenuItem(value: 1, child: Text('Profile')),
              PopupMenuItem(value: 2, child: Text('Sign out')),
            ],
            onSelected: (v) {
              if (v == 1) {
                // TODO: Navigate to profile screen if implemented
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Profile screen not implemented yet.')));
              } else if (v == 2) {
                _signOut();
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildStatsTiles() {
    if (loading) {
      return const Center(child: Padding(padding: EdgeInsets.all(8), child: CircularProgressIndicator()));
    }

    // Responsive 2-column layout for stats
    return Column(
      children: [
        Row(
          children: [
            Expanded(child: StatCard(title: 'Tasks Done', value: tasksDone.toString(), icon: Icons.check_circle)),
            const SizedBox(width: 12),
            Expanded(child: StatCard(title: 'Active Jobs', value: activeJobs.toString(), icon: Icons.work_outline)),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(child: StatCard(title: 'Pending Payments', value: pendingPayments.toString(), icon: Icons.pending_actions)),
            const SizedBox(width: 12),
            Expanded(child: StatCard(title: 'Earnings', value: earnings, icon: Icons.currency_rupee)),
          ],
        ),
      ],
    );
  }

  Widget _buildQuickActions() {
    // adapt columns by width (2 for mobile, 4 for wide screens)
    final cross = MediaQuery.of(context).size.width > 700 ? 4 : 2;
    return GridView.count(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      crossAxisCount: cross,
      crossAxisSpacing: 12,
      mainAxisSpacing: 12,
      childAspectRatio: 2.4,
      children: [
        QuickActionCard(
          title: 'Browse Jobs',
          subtitle: 'Find nearby jobs',
          icon: Icons.search,
          color: Colors.green,
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ViewJobsScreen())),
        ),
        QuickActionCard(
          title: 'My Jobs',
          subtitle: 'Active & history',
          icon: Icons.list_alt,
          color: Colors.blueAccent,
          onTap: () {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('My Jobs not implemented yet.')));
          },
        ),
        QuickActionCard(
          title: 'Payments',
          subtitle: 'Payment history',
          icon: Icons.account_balance_wallet,
          color: Colors.purple,
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const PaymentsScreen())),
        ),
        QuickActionCard(
          title: 'Reports',
          subtitle: 'Performance',
          icon: Icons.bar_chart,
          color: Colors.orange,
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ReportsScreen())),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    const double padding = 16.0;

    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        title: const Text('Dashboard'),
        backgroundColor: AppTheme.primaryGreen,
        elevation: 0,
        actions: [
          IconButton(
            tooltip: 'Refresh',
            icon: const Icon(Icons.refresh),
            onPressed: _onRefresh,
          ),
          IconButton(
            tooltip: 'Sign out',
            icon: const Icon(Icons.logout),
            onPressed: _signOut,
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _onRefresh,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.all(padding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(context),
              const SizedBox(height: 18),
              const Text('Overview', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              const SizedBox(height: 12),
              _buildStatsTiles(),
              const SizedBox(height: 20),
              const Text('Quick Actions', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              const SizedBox(height: 12),
              _buildQuickActions(),
              const SizedBox(height: 28),

              // Tip / info card
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
                    Expanded(child: Text('Tip: Keep your profile updated — add photos of completed work to attract more jobs.', style: TextStyle(color: Colors.grey.shade800))),
                    TextButton(onPressed: () {}, child: const Text('Learn more')),
                  ],
                ),
              ),
              const SizedBox(height: 36),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ViewJobsScreen())),
        label: const Text('Find Jobs'),
        icon: const Icon(Icons.search),
        backgroundColor: AppTheme.primaryGreen,
      ),
    );
  }
}
