import 'package:flutter/material.dart';

class EliteTradersApp extends StatelessWidget {
  const EliteTradersApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const ResponsiveHome(),
    );
  }
}

class ResponsiveHome extends StatefulWidget {
  const ResponsiveHome({super.key});

  @override
  State<ResponsiveHome> createState() => _ResponsiveHomeState();
}

class _ResponsiveHomeState extends State<ResponsiveHome> {
  int _selectedIndex = 0;

  static const List<Widget> _pages = <Widget>[
    MainDashboard(),
    DepositPage(),
    WithdrawPage(),
    Center(
      child: Text("Logout Page", style: TextStyle(color: Colors.white)),
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    /// Bottom nav logout click
    if (index == 3) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const LoginPage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    double maxWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color(0xff032f1b),

      // -------------------------------
      //            APP BAR
      // -------------------------------
      appBar: AppBar(
        backgroundColor: const Color(0xff023017),
        elevation: 0,
        leading: const Icon(Icons.menu, color: Colors.white),

        centerTitle: true,
        title: const Text(
          "ELITETRDRS",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),

        actions: [
          /// WITHDRAW ICON
          IconButton(
            icon: const Icon(Icons.money, color: Colors.orangeAccent),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const WithdrawPage()),
              );
            },
          ),

          /// LOGOUT ICON → LOGIN PAGE
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.redAccent),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => LoginPage()),
              );
            },
          ),
        ],
      ),

      body: Center(
        child: SizedBox(
          width: maxWidth > 600 ? 600 : maxWidth,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: _pages[_selectedIndex],
          ),
        ),
      ),

      // -------------------------------
      //     BOTTOM NAVIGATION BAR
      // -------------------------------
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xff023017),
        selectedItemColor: Colors.greenAccent,
        unselectedItemColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.account_balance),
            label: "Account",
          ),
          BottomNavigationBarItem(icon: Icon(Icons.savings), label: "Deposit"),
          BottomNavigationBarItem(icon: Icon(Icons.money), label: "Withdraw"),
          BottomNavigationBarItem(icon: Icon(Icons.logout), label: "Logout"),
        ],
      ),
    );
  }
}

///////////////////////////////////////////////////////////////
///  DASHBOARD
///////////////////////////////////////////////////////////////
class MainDashboard extends StatelessWidget {
  const MainDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 10),
        const Text(
          "Welcome, dev",
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 5),
        const Text(
          "Here's your account overview",
          style: TextStyle(color: Colors.white70),
        ),
        const SizedBox(height: 20),

        /// BALANCE CARD
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: const Color(0xff064d2c),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            children: [
              const Text(
                "Available Balance",
                style: TextStyle(color: Colors.white70, fontSize: 16),
              ),
              const SizedBox(height: 6),
              const Text(
                "Rs 0.00",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 14),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [buttonFilled("Deposit"), buttonBorder("Withdraw")],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

///////////////////////////////////////////////////////////////
///  DEPOSIT PAGE
///////////////////////////////////////////////////////////////
class DepositPage extends StatelessWidget {
  const DepositPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 10),
        const Text(
          "Deposit Funds",
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 20),

        Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: const Color(0xff064d2c),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            children: [
              const Text(
                "Enter Amount",
                style: TextStyle(color: Colors.white70),
              ),
              const SizedBox(height: 10),

              TextField(
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: "Rs 0.00",
                  hintStyle: const TextStyle(color: Colors.white54),
                  filled: true,
                  fillColor: const Color(0xff023017),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide.none,
                  ),
                ),
                keyboardType: TextInputType.number,
              ),

              const SizedBox(height: 20),
              buttonFilled("Deposit Now"),
            ],
          ),
        ),
      ],
    );
  }
}

///////////////////////////////////////////////////////////////
///   WITHDRAW PAGE (FULL PROFESSIONAL PAGE)
///////////////////////////////////////////////////////////////
class WithdrawPage extends StatelessWidget {
  const WithdrawPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 10),
          const Text(
            "Withdraw Funds",
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),

          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: const Color(0xff064d2c),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              children: [
                const Text(
                  "Available Balance",
                  style: TextStyle(color: Colors.white70),
                ),
                const SizedBox(height: 6),
                const Text(
                  "Rs 0.00",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),

                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Enter Withdrawal Amount",
                    style: TextStyle(color: Colors.white70),
                  ),
                ),
                const SizedBox(height: 8),

                TextField(
                  style: const TextStyle(color: Colors.white),
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: "Rs 0.00",
                    hintStyle: const TextStyle(color: Colors.white54),
                    filled: true,
                    fillColor: const Color(0xff023017),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                Row(
                  children: [
                    Expanded(child: withdrawOption("JazzCash", Icons.phone)),
                    const SizedBox(width: 10),
                    Expanded(child: withdrawOption("EasyPaisa", Icons.wallet)),
                  ],
                ),

                const SizedBox(height: 20),

                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Enter Wallet Number",
                    style: TextStyle(color: Colors.white70),
                  ),
                ),
                const SizedBox(height: 8),

                TextField(
                  style: const TextStyle(color: Colors.white),
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    hintText: "03XXXXXXXXX",
                    hintStyle: const TextStyle(color: Colors.white54),
                    filled: true,
                    fillColor: const Color(0xff023017),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),

                const SizedBox(height: 30),
                buttonFilled("Withdraw Now"),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

///////////////////////////////////////////////////////////////
///   LOGIN PAGE (ADDED)
///////////////////////////////////////////////////////////////
class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff032f1b),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(20),
          margin: const EdgeInsets.symmetric(horizontal: 30),
          decoration: BoxDecoration(
            color: const Color(0xff064d2c),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "Login",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),

              TextField(
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: "Email",
                  hintStyle: const TextStyle(color: Colors.white54),
                  filled: true,
                  fillColor: const Color(0xff023017),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),

              const SizedBox(height: 15),

              TextField(
                obscureText: true,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: "Password",
                  hintStyle: const TextStyle(color: Colors.white54),
                  filled: true,
                  fillColor: const Color(0xff023017),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),

              const SizedBox(height: 25),
              buttonFilled("Login"),
            ],
          ),
        ),
      ),
    );
  }
}

///////////////////////////////////////////////////////////////
///  SMALL REUSABLE WIDGETS
///////////////////////////////////////////////////////////////
Widget buttonFilled(String text) {
  return Container(
    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 30),
    decoration: BoxDecoration(
      color: Colors.green,
      borderRadius: BorderRadius.circular(30),
    ),
    child: Text(
      text,
      style: const TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: 16,
      ),
    ),
  );
}

Widget buttonBorder(String text) {
  return Container(
    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 30),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(30),
      border: Border.all(color: Colors.white, width: 2),
    ),
    child: Text(
      text,
      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
    ),
  );
}

Widget withdrawOption(String title, IconData icon) {
  return Container(
    padding: const EdgeInsets.symmetric(vertical: 14),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14),
    ),
    child: Column(
      children: [
        Icon(icon, color: Colors.green, size: 30),
        const SizedBox(height: 6),
        Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
      ],
    ),
  );
}

Widget linkBox() {
  return Container(
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(15),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: const [
        Expanded(
          child: Text(
            "https://elite-traders.pro/signup...",
            style: TextStyle(fontSize: 14),
          ),
        ),
        Icon(Icons.copy, color: Colors.green),
      ],
    ),
  );
}

Widget adminBox(String title) {
  return Container(
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(18),
    ),
    child: Column(
      children: [
        const Icon(Icons.message, color: Colors.green, size: 40),
        const SizedBox(height: 6),
        Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
          decoration: BoxDecoration(
            color: const Color(0xff064d2c),
            borderRadius: BorderRadius.circular(10),
          ),
          child: const Text("Contact", style: TextStyle(color: Colors.white)),
        ),
      ],
    ),
  );
}
