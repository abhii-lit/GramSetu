import 'package:flutter/material.dart';

class PaymentsScreen extends StatelessWidget {
  const PaymentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final transactions = [
      {"date": "Oct 28, 2025", "desc": "Construction Job", "amount": "+ ₹2,500"},
      {"date": "Oct 25, 2025", "desc": "Field Work", "amount": "+ ₹1,200"},
      {"date": "Oct 22, 2025", "desc": "Transport Help", "amount": "- ₹800"},
    ];

    return Scaffold(
      appBar: AppBar(title: const Text("Payments")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Earnings Summary", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.green.shade100,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text("Total Earned", style: TextStyle(fontSize: 16)),
                  Text("₹46,000", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            const SizedBox(height: 24),
            const Text("Recent Transactions", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Expanded(
              child: ListView.builder(
                itemCount: transactions.length,
                itemBuilder: (context, index) {
                  final t = transactions[index];
                  return Card(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    child: ListTile(
                      leading: Icon(
                        t["amount"]!.startsWith("+") ? Icons.arrow_downward : Icons.arrow_upward,
                        color: t["amount"]!.startsWith("+") ? Colors.green : Colors.red,
                      ),
                      title: Text(t["desc"]!),
                      subtitle: Text(t["date"]!),
                      trailing: Text(
                        t["amount"]!,
                        style: TextStyle(
                          color: t["amount"]!.startsWith("+") ? Colors.green : Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
