import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PlanPage extends StatefulWidget {
  const PlanPage({super.key});

  @override
  State<PlanPage> createState() => _PlanPageState();
}

class _PlanPageState extends State<PlanPage> {
  @override
  void initState() {
    super.initState();
    _seedPlans();
  }

  Future<void> _seedPlans() async {
    final plansRef = FirebaseFirestore.instance.collection('plans');
    final snapshot = await plansRef.limit(1).get();

    if (snapshot.docs.isEmpty) {
      // Seed default plans if collection is empty
      final defaultPlans = [
        {
          'title': "VIP 1",
          'price': 1000,
          'dailyProfit': 50,
          'totalProfit': 1500,
          'duration': 30,
        },
        {
          'title': "VIP 2",
          'price': 3000,
          'dailyProfit': 160,
          'totalProfit': 4800,
          'duration': 30,
        },
        {
          'title': "VIP 3",
          'price': 5000,
          'dailyProfit': 280,
          'totalProfit': 8400,
          'duration': 30,
        },
        {
          'title': "VIP 4",
          'price': 10000,
          'dailyProfit': 600,
          'totalProfit': 18000,
          'duration': 30,
        },
      ];

      for (var plan in defaultPlans) {
        await plansRef.add(plan);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF001a33),
      appBar: AppBar(
        title: const Text(
          "Investment Plans",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFF002b4d),
        iconTheme: const IconThemeData(color: Colors.white),
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('plans')
            .orderBy('price')
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Text(
                "No plans available",
                style: TextStyle(color: Colors.white),
              ),
            );
          }

          final plans = snapshot.data!.docs;

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: plans.length,
            itemBuilder: (context, index) {
              final plan = plans[index].data() as Map<String, dynamic>;
              return PlanCard(
                title: plan['title'] ?? 'Plan',
                price: (plan['price'] ?? 0).toInt(),
                dailyProfit: (plan['dailyProfit'] ?? 0).toInt(),
                totalProfit: (plan['totalProfit'] ?? 0).toInt(),
                duration: (plan['duration'] ?? 30).toInt(),
              );
            },
          );
        },
      ),
    );
  }
}

class PlanCard extends StatefulWidget {
  final String title;
  final int price;
  final int dailyProfit;
  final int totalProfit;
  final int duration;

  const PlanCard({
    super.key,
    required this.title,
    required this.price,
    required this.dailyProfit,
    required this.totalProfit,
    required this.duration,
  });

  @override
  State<PlanCard> createState() => _PlanCardState();
}

class _PlanCardState extends State<PlanCard> {
  bool _isLoading = false;

  Future<void> _buyPlan() async {
    setState(() => _isLoading = true);
    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    try {
      DocumentReference userRef = FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid);

      await FirebaseFirestore.instance.runTransaction((transaction) async {
        DocumentSnapshot snapshot = await transaction.get(userRef);
        if (!snapshot.exists) throw Exception("User does not exist!");

        double currentBalance = (snapshot.get('availableBalance') ?? 0)
            .toDouble();

        if (currentBalance < widget.price) {
          throw Exception("Insufficient Balance!");
        }

        // Deduct balance
        transaction.update(userRef, {
          'availableBalance': currentBalance - widget.price,
        });

        // Add plan to user's active plans
        DocumentReference planRef = userRef.collection('plans').doc();
        transaction.set(planRef, {
          'title': widget.title,
          'price': widget.price,
          'dailyProfit': widget.dailyProfit,
          'startDate': Timestamp.now(),
          'endDate': Timestamp.fromDate(
            DateTime.now().add(Duration(days: widget.duration)),
          ),
          'status': 'active',
        });
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Plan Purchased Successfully!")),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.toString().replaceAll("Exception: ", ""))),
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xFF002b4d),
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _infoColumn("Price", "Rs ${widget.price}"),
                _infoColumn("Daily", "Rs ${widget.dailyProfit}"),
                _infoColumn("Total", "Rs ${widget.totalProfit}"),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [_infoColumn("Duration", "${widget.duration} Days")],
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _isLoading ? null : _buyPlan,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF003366),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
                child: _isLoading
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                        ),
                      )
                    : const Text("Invest Now"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _infoColumn(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(color: Colors.grey, fontSize: 12)),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
