import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:elitetraders/LoginPage.dart';
import 'package:elitetraders/depositpage.dart';
import 'package:elitetraders/withdrawpage.dart';

class EliteTradersApp extends StatelessWidget {
  const EliteTradersApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EliteTraders',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue, // Not used, we override colors
        scaffoldBackgroundColor: const Color(0xFF001a33), // Dark Navy
        textTheme: const TextTheme(bodyMedium: TextStyle(color: Colors.white)),
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  static const List<Widget> _pages = <Widget>[
    MainDashboard(),
    DepositPage(),
    WithdrawPage(),
  ];

  void _onItemTapped(int index) {
    if (index == 3) {
      // Logout
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginPage()),
      );
    } else {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF002b4d), // Darker Navy
        elevation: 0,
        title: const Text(
          'ELITETRDERS',
          style: TextStyle(
            color: Color.fromARGB(255, 247, 246, 246),
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.menu, color: Colors.white),
          onPressed: () {},
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings, color: Colors.orange),
            onPressed: () {},
          ),
        ],
      ),
      body: IndexedStack(index: _selectedIndex, children: _pages),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xFF002b4d), // Darker Navy
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white70,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Account'),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_balance_wallet),
            label: 'Deposit',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.upload), label: 'Withdraw'),
          BottomNavigationBarItem(icon: Icon(Icons.logout), label: 'Logout'),
        ],
      ),
    );
  }
}

class MainDashboard extends StatelessWidget {
  const MainDashboard({super.key});

  Future<void> _launchWhatsApp() async {
    const url = "https://wa.me/923001234567";
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          // -------------------------------
          // 🔥 CARD SAME AS BEFORE
          // -------------------------------
          Card(
            color: const Color(0xFF002b4d), // Darker Navy
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  const Text(
                    'Welcome, dev',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    "Here's your account overview",
                    style: TextStyle(color: Colors.grey),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Available Balance',
                    style: TextStyle(color: Colors.grey, fontSize: 16),
                  ),
                  const Text(
                    'Rs 0.00',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const DepositPage(),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(
                            0xFF003366,
                          ), // Medium Navy
                          foregroundColor: Colors.white,
                        ),
                        child: const Text('Deposit'),
                      ),
                      const SizedBox(width: 20),
                      OutlinedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const WithdrawPage(),
                            ),
                          );
                        },
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(
                            color: Color(0xFF003366),
                          ), // Medium Navy
                        ),
                        child: const Text(
                          'Withdraw',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Referred By:',
                    style: TextStyle(color: Colors.grey),
                  ),
                  const Text('', style: TextStyle(color: Colors.blue)),
                  const SizedBox(height: 15),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFF001a33), // Darkest Navy
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Row(
                      children: [
                        Expanded(
                          child: Text(
                            'https://elite-traders.pro/signup.php?ref=...',
                            style: TextStyle(color: Colors.white, fontSize: 12),
                          ),
                        ),
                        Icon(Icons.copy, color: Colors.white, size: 18),
                      ],
                    ),
                  ),
                  const SizedBox(height: 25),
                  const Text(
                    'Contact Us on WhatsApp',
                    style: TextStyle(color: Colors.grey),
                  ),
                  const SizedBox(height: 15),
                  Row(
                    children: [
                      Expanded(child: _adminContactBox('Admin-1')),
                      const SizedBox(width: 15),
                      Expanded(child: _adminContactBox('Admin-2')),
                    ],
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 20),

          Row(
            children: [
              Expanded(
                child: _MenuIcon(icon: Icons.description, label: 'Plan'),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: _MenuIcon(icon: Icons.swap_horiz, label: 'Referral'),
              ),
            ],
          ),

          const SizedBox(height: 30),
          Row(
            children: [
              Expanded(
                child: _MenuIcon(icon: Icons.history, label: 'History'),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: _MenuIcon(
                  icon: Icons.account_balance_wallet,
                  label: 'Earning',
                ),
              ),
            ],
          ),

          const SizedBox(height: 30),
          Row(
            children: const [
              _StatCard(
                title: 'Total Profit',
                amount: 'Rs 0',
                color: Colors.lightBlueAccent,
              ),
              SizedBox(width: 12),
              _StatCard(
                title: 'Total Deposit',
                amount: 'Rs 0',
                color: Colors.tealAccent,
              ),
              SizedBox(width: 12),
              _StatCard(
                title: 'Total Withdraw',
                amount: 'Rs 0.00',
                color: Colors.lightGreen,
              ),
            ],
          ),

          const SizedBox(height: 40),
          const Text(
            'Account Summary',
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 20),

          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            childAspectRatio: 2.5,
            mainAxisSpacing: 15,
            crossAxisSpacing: 15,
            children: const [
              _SummaryCard(
                icon: Icons.card_giftcard,
                title: 'Referral Bonus',
                value: 'Rs 0',
              ),
              _SummaryCard(
                icon: Icons.hourglass_bottom,
                title: 'Pending Withdraw',
                value: 'Rs 0',
              ),
              _SummaryCard(
                icon: Icons.people,
                title: 'Team Member',
                value: '0',
              ),
              _SummaryCard(
                icon: Icons.monetization_on,
                title: 'Team Investment',
                value: 'Rs 0',
              ),
            ],
          ),

          const SizedBox(height: 40),
          ClipRRect(
            borderRadius: BorderRadius.circular(16.0),
            child: Image.asset(
              'assets/banner.jpg',
              fit: BoxFit.cover,
              width: double.infinity,
            ),
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }
}

Widget _adminContactBox(String name) {
  return GestureDetector(
    onTap: () async {
      const url = "https://wa.me/923001234567";
      if (await canLaunchUrl(Uri.parse(url))) await launchUrl(Uri.parse(url));
    },
    child: Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
      decoration: BoxDecoration(
        color: const Color(0xFF002b4d), // Darker Navy
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          const Icon(Icons.message, color: Colors.white, size: 30),
          const SizedBox(height: 8),
          Text(
            name,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
            decoration: BoxDecoration(
              color: const Color(0xFF003366), // Medium Navy
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Text(
              "Contact",
              style: TextStyle(color: Colors.white, fontSize: 12),
            ),
          ),
        ],
      ),
    ),
  );
}

class _MenuIcon extends StatelessWidget {
  final IconData icon;
  final String label;
  const _MenuIcon({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      decoration: BoxDecoration(
        color: const Color(0xFF002b4d), // Darker Navy
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Icon(icon, size: 30, color: Colors.white),
          const SizedBox(height: 10),
          Text(
            label,
            style: const TextStyle(color: Colors.white, fontSize: 16),
          ),
        ],
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String title;
  final String amount;
  final Color color;
  const _StatCard({
    required this.title,
    required this.amount,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Card(
        color: const Color(0xFF002b4d), // Darker Navy
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Icon(Icons.show_chart, color: color),
              const SizedBox(height: 8),
              Text(
                title,
                style: const TextStyle(color: Colors.grey, fontSize: 12),
              ),
              Text(
                amount,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SummaryCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;
  const _SummaryCard({
    required this.icon,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xFF002b4d), // Darker Navy
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Icon(icon, color: Colors.white, size: 40),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(color: Colors.grey)),
                  const SizedBox(height: 4),
                  Text(
                    value,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
