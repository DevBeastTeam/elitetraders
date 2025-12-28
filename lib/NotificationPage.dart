import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  static final List<Map<String, dynamic>> mockNotifications = [
    {
      'title': 'Deposit Approved',
      'body':
          'Your deposit of Rs 50,000 via JazzCash has been approved successfully.',
      'type': 'deposit',
      'timestamp': DateTime.now().subtract(const Duration(minutes: 5)),
    },
    {
      'title': 'Withdrawal Request',
      'body': 'Your withdrawal request of Rs 10,000 is under review.',
      'type': 'withdraw',
      'timestamp': DateTime.now().subtract(const Duration(hours: 2)),
    },
    {
      'title': 'Special Promo!',
      'body':
          'Get 10% bonus on all deposits made this weekend. Don\'t miss out!',
      'type': 'promo',
      'timestamp': DateTime.now().subtract(const Duration(days: 1)),
    },
    {
      'title': 'Security Alert',
      'body':
          'A new login was detected from a new device. If this wasn\'t you, change your password immediately.',
      'type': 'security',
      'timestamp': DateTime.now().subtract(const Duration(days: 3)),
    },
  ];

  @override
  Widget build(BuildContext context) {
    final User? user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      backgroundColor: const Color(0xFF001a33), // Dark Navy Background
      appBar: AppBar(
        title: const Text(
          'Notifications',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFF002b4d),
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: user == null
          ? const Center(
              child: Text(
                'Please login to view notifications',
                style: TextStyle(color: Colors.grey),
              ),
            )
          : StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('users')
                  .doc(user.uid)
                  .collection('notifications')
                  .orderBy('timestamp', descending: true)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                // Use Firestore data if available, otherwise fallback to mock data
                final List<Map<String, dynamic>> notifications =
                    (snapshot.hasData && snapshot.data!.docs.isNotEmpty)
                    ? snapshot.data!.docs
                          .map((doc) => doc.data() as Map<String, dynamic>)
                          .toList()
                    : mockNotifications;

                if (notifications.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.notifications_none,
                          size: 64,
                          color: Colors.grey.withOpacity(0.5),
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          'No notifications yet',
                          style: TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                  );
                }

                return ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: notifications.length,
                  itemBuilder: (context, index) {
                    var data = notifications[index];

                    // Handle Timestamp vs DateTime difference
                    DateTime dateTime;
                    if (data['timestamp'] is Timestamp) {
                      dateTime = (data['timestamp'] as Timestamp).toDate();
                    } else if (data['timestamp'] is DateTime) {
                      dateTime = data['timestamp'] as DateTime;
                    } else {
                      dateTime = DateTime.now();
                    }

                    return Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      decoration: BoxDecoration(
                        color: const Color(0xFF002b4d),
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: ListTile(
                        contentPadding: const EdgeInsets.all(16),
                        leading: Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.1),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.notifications,
                            color: Colors.white,
                            size: 24,
                          ),
                        ),
                        title: Text(
                          data['title'] ?? 'Notification',
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 4),
                            Text(
                              data['body'] ?? '',
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.7),
                                fontSize: 13,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              DateFormat('dd MMM, hh:mm a').format(dateTime),
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.4),
                                fontSize: 11,
                              ),
                            ),
                          ],
                        ),
                        isThreeLine: true,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => NotificationDetailPage(
                                data: {...data, 'timestamp': dateTime},
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  },
                );
              },
            ),
    );
  }
}

class NotificationDetailPage extends StatelessWidget {
  final Map<String, dynamic> data;

  const NotificationDetailPage({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF001a33),
      appBar: AppBar(
        title: const Text(
          'Notification Details',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFF002b4d),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: const Color(0xFF002b4d),
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white24, width: 2),
                ),
                child: const Icon(
                  Icons.notifications,
                  size: 60,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 32),
            Text(
              data['title'] ?? 'No Title',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              DateFormat(
                'EEEE, dd MMM yyyy • hh:mm a',
              ).format(data['timestamp'] as DateTime),
              style: TextStyle(
                color: Colors.white.withOpacity(0.5),
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 24),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFF002b4d),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Text(
                data['body'] ?? 'No Content',
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 16,
                  height: 1.5,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
