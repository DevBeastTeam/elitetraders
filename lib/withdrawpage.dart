import 'package:flutter/material.dart';

class WithdrawPage extends StatelessWidget {
  const WithdrawPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10),
          const Center(
            child: Text(
              "Withdraw Funds",
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          const SizedBox(height: 20),

          /// MAIN WITHDRAW BOX
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: const Color(0xFF002b4d), // Darker Navy
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// BALANCE
                const Text(
                  "Available Balance",
                  style: TextStyle(color: Colors.white70, fontSize: 15),
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

                const SizedBox(height: 25),

                /// AMOUNT INPUT
                const Text(
                  "Enter Withdrawal Amount",
                  style: TextStyle(color: Colors.white70),
                ),
                const SizedBox(height: 8),
                TextField(
                  style: const TextStyle(color: Colors.white),
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: "Rs 0.00",
                    hintStyle: const TextStyle(color: Colors.white54),
                    filled: true,
                    fillColor: const Color(0xFF001a33), // Darkest Navy
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),

                const SizedBox(height: 25),

                /// PAYMENT METHOD
                const Text(
                  "Select Method",
                  style: TextStyle(color: Colors.white70),
                ),
                const SizedBox(height: 10),

                Row(
                  children: [
                    Expanded(
                      child: withdrawOption("JazzCash", Icons.phone_android),
                    ),
                    const SizedBox(width: 15),
                    Expanded(
                      child: withdrawOption("EasyPaisa", Icons.account_balance),
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                /// ACCOUNT NUMBER
                const Text(
                  "Enter Wallet / Account Number",
                  style: TextStyle(color: Colors.white70),
                ),
                const SizedBox(height: 8),
                TextField(
                  style: const TextStyle(color: Colors.white),
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    hintText: "03XXXXXXXXX",
                    hintStyle: const TextStyle(color: Colors.white54),
                    filled: true,
                    fillColor: const Color(0xFF001a33), // Darkest Navy
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),

                const SizedBox(height: 30),

                Center(child: buttonFilled("Withdraw Now")),
              ],
            ),
          ),

          const SizedBox(height: 30),
        ],
      ),
    );
  }
}

/// =================================================================
///   CUSTOM WIDGETS
/// =================================================================

Widget withdrawOption(String title, IconData icon) {
  return Container(
    padding: const EdgeInsets.symmetric(vertical: 14),
    decoration: BoxDecoration(
      color: const Color(0xFF002b4d), // Darker Navy
      borderRadius: BorderRadius.circular(14),
    ),
    child: Column(
      children: [
        Icon(icon, color: Colors.white, size: 30),
        const SizedBox(height: 6),
        Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ],
    ),
  );
}

Widget buttonFilled(String text) {
  return Container(
    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 35),
    decoration: BoxDecoration(
      color: const Color(0xFF003366), // Medium Navy
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
