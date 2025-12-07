import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: const Color(0xFF001a33),
        appBar: AppBar(
          title: const Text(
            "Transaction History",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: const Color(0xFF002b4d),
          iconTheme: const IconThemeData(color: Colors.white),
          centerTitle: true,
          bottom: const TabBar(
            labelColor: Colors.white,
            unselectedLabelColor: Colors.grey,
            indicatorColor: Colors.orange,
            tabs: [
              Tab(text: "Deposits"),
              Tab(text: "Withdrawals"),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            TransactionList(collection: 'deposits'),
            TransactionList(collection: 'withdrawals'),
          ],
        ),
      ),
    );
  }
}

class TransactionList extends StatelessWidget {
  final String collection;
  const TransactionList({super.key, required this.collection});

  @override
  Widget build(BuildContext context) {
    final User? user = FirebaseAuth.instance.currentUser;
    if (user == null) return const Center(child: Text("Please login"));

    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection(collection)
          .where('userId', isEqualTo: user.uid)
          .orderBy('createdAt', descending: true)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return Center(
            child: Text(
              "No $collection found.",
              style: const TextStyle(color: Colors.grey),
            ),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: snapshot.data!.docs.length,
          itemBuilder: (context, index) {
            var data =
                snapshot.data!.docs[index].data() as Map<String, dynamic>;
            bool isDeposit = collection == 'deposits';
            Color amountColor = isDeposit
                ? Colors.greenAccent
                : Colors.redAccent;
            IconData icon = isDeposit
                ? Icons.arrow_downward
                : Icons.arrow_upward;

            return Card(
              color: const Color(0xFF002b4d),
              margin: const EdgeInsets.only(bottom: 10),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: const Color(0xFF003366),
                  child: Icon(icon, color: Colors.white),
                ),
                title: Text(
                  "Rs ${data['amount']}",
                  style: TextStyle(
                    color: amountColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(
                  DateFormat(
                    'yyyy-MM-dd HH:mm',
                  ).format((data['createdAt'] as Timestamp).toDate()),
                  style: const TextStyle(color: Colors.grey),
                ),
                trailing: Text(
                  data['status']?.toUpperCase() ?? 'PENDING',
                  style: TextStyle(
                    color: data['status'] == 'approved'
                        ? Colors.green
                        : Colors.orange,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
