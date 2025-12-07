import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class AdminDepositsPage extends StatelessWidget {
  const AdminDepositsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF001a33), // User App Background
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Deposit Requests',
            style: TextStyle(
              color: Colors.white,
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Manage and approve user deposits',
            style: TextStyle(color: Colors.grey, fontSize: 14),
          ),
          const SizedBox(height: 24),
          Expanded(
            child: Card(
              color: const Color(0xFF002b4d), // User App Card Color
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('deposits')
                    .orderBy('createdAt', descending: true)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.account_balance_wallet_outlined,
                            size: 64,
                            color: Colors.grey[700],
                          ),
                          const SizedBox(height: 16),
                          const Text(
                            'No deposits found',
                            style: TextStyle(color: Colors.grey, fontSize: 16),
                          ),
                        ],
                      ),
                    );
                  }

                  return SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: DataTable(
                        headingRowColor: WidgetStateProperty.all(
                          Colors.transparent,
                        ),
                        dataRowColor: WidgetStateProperty.all(
                          Colors.transparent,
                        ),
                        columnSpacing: 30,
                        horizontalMargin: 20,
                        columns: const [
                          DataColumn(
                            label: Text(
                              'User ID',
                              style: TextStyle(
                                color: Colors.orange,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          DataColumn(
                            label: Text(
                              'Amount',
                              style: TextStyle(
                                color: Colors.orange,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          DataColumn(
                            label: Text(
                              'Method',
                              style: TextStyle(
                                color: Colors.orange,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          DataColumn(
                            label: Text(
                              'Status',
                              style: TextStyle(
                                color: Colors.orange,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          DataColumn(
                            label: Text(
                              'Date',
                              style: TextStyle(
                                color: Colors.orange,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          DataColumn(
                            label: Text(
                              'Actions',
                              style: TextStyle(
                                color: Colors.orange,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                        rows: snapshot.data!.docs.map((doc) {
                          final data = doc.data() as Map<String, dynamic>;
                          final status = data['status'] ?? 'pending';

                          return DataRow(
                            cells: [
                              DataCell(
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.person_outline,
                                      size: 16,
                                      color: Colors.grey,
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      '${(data['userId'] ?? 'N/A').toString().substring(0, 8)}...',
                                      style: const TextStyle(
                                        color: Colors.white70,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              DataCell(
                                Text(
                                  'Rs ${data['amount'] ?? 0}',
                                  style: const TextStyle(
                                    color: Colors.green,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              DataCell(
                                Text(
                                  data['method'] ?? 'Manual',
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ),
                              DataCell(
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 6,
                                  ),
                                  decoration: BoxDecoration(
                                    color: status == 'approved'
                                        ? Colors.green.withOpacity(0.2)
                                        : status == 'rejected'
                                        ? Colors.red.withOpacity(0.2)
                                        : Colors.orange.withOpacity(0.2),
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(
                                      color: status == 'approved'
                                          ? Colors.green
                                          : status == 'rejected'
                                          ? Colors.red
                                          : Colors.orange,
                                      width: 1,
                                    ),
                                  ),
                                  child: Text(
                                    status.toUpperCase(),
                                    style: TextStyle(
                                      color: status == 'approved'
                                          ? Colors.green
                                          : status == 'rejected'
                                          ? Colors.red
                                          : Colors.orange,
                                      fontSize: 11,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                              DataCell(
                                Text(
                                  data['createdAt'] != null
                                      ? DateFormat('dd MMM HH:mm').format(
                                          (data['createdAt'] as Timestamp)
                                              .toDate(),
                                        )
                                      : 'N/A',
                                  style: const TextStyle(color: Colors.grey),
                                ),
                              ),
                              DataCell(
                                status == 'pending'
                                    ? Row(
                                        children: [
                                          IconButton(
                                            icon: const Icon(
                                              Icons.check_circle,
                                              color: Colors.green,
                                            ),
                                            tooltip: 'Approve',
                                            onPressed: () => _approveDeposit(
                                              context,
                                              doc.id,
                                              data,
                                            ),
                                          ),
                                          IconButton(
                                            icon: const Icon(
                                              Icons.cancel,
                                              color: Colors.red,
                                            ),
                                            tooltip: 'Reject',
                                            onPressed: () =>
                                                _rejectDeposit(context, doc.id),
                                          ),
                                        ],
                                      )
                                    : Icon(
                                        status == 'approved'
                                            ? Icons.check
                                            : Icons.close,
                                        color: status == 'approved'
                                            ? Colors.green
                                            : Colors.red,
                                        size: 20,
                                      ),
                              ),
                            ],
                          );
                        }).toList(),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _approveDeposit(
    BuildContext context,
    String depositId,
    Map<String, dynamic> data,
  ) async {
    try {
      final userId = data['userId'];
      final amount = (data['amount'] ?? 0).toDouble();

      // Update deposit status
      await FirebaseFirestore.instance
          .collection('deposits')
          .doc(depositId)
          .update({'status': 'approved'});

      // Update user balance
      final userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .get();
      if (userDoc.exists) {
        final currentBalance = (userDoc.get('availableBalance') ?? 0)
            .toDouble();
        final currentTotalDeposit = (userDoc.get('totalDeposit') ?? 0)
            .toDouble();

        await FirebaseFirestore.instance
            .collection('users')
            .doc(userId)
            .update({
              'availableBalance': currentBalance + amount,
              'totalDeposit': currentTotalDeposit + amount,
            });
      }

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Deposit approved successfully'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e'), backgroundColor: Colors.red),
        );
      }
    }
  }

  Future<void> _rejectDeposit(BuildContext context, String depositId) async {
    try {
      await FirebaseFirestore.instance
          .collection('deposits')
          .doc(depositId)
          .update({'status': 'rejected'});

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Deposit rejected'),
            backgroundColor: Colors.orange,
          ),
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e'), backgroundColor: Colors.red),
        );
      }
    }
  }
}
