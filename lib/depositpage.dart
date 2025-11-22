import 'package:flutter/material.dart';

class DepositPage extends StatelessWidget {
  const DepositPage({super.key});

  @override
  Widget build(BuildContext context) {
    double maxWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color(0xFF001a33), // Dark Navy

      appBar: AppBar(
        backgroundColor: const Color(0xFF002b4d), // Darker Navy
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context); // Go back
          },
        ),
        centerTitle: true,
        title: const Text(
          "Deposit Funds",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 12),
            child: Icon(
              Icons.account_balance_wallet,
              color: Colors.orangeAccent,
            ),
          ),
        ],
      ),

      body: Center(
        child: SizedBox(
          width: maxWidth > 800 ? 800 : maxWidth,
          child: const SingleChildScrollView(
            padding: EdgeInsets.all(16),
            child: DepositForm(),
          ),
        ),
      ),
    );
  }
}

class DepositForm extends StatefulWidget {
  const DepositForm({super.key});

  @override
  State<DepositForm> createState() => _DepositFormState();
}

class _DepositFormState extends State<DepositForm> {
  final TextEditingController amountController = TextEditingController();
  final TextEditingController dailyProfitController = TextEditingController();
  final TextEditingController totalProfitController = TextEditingController();
  final TextEditingController level1Controller = TextEditingController();
  final TextEditingController level2Controller = TextEditingController();
  final TextEditingController durationController = TextEditingController();

  @override
  void dispose() {
    amountController.dispose();
    dailyProfitController.dispose();
    totalProfitController.dispose();
    level1Controller.dispose();
    level2Controller.dispose();
    durationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// --------------------------
        /// Deposit Amount
        /// --------------------------
        const Text(
          "Enter Deposit Amount",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 15),

        TextField(
          controller: amountController,
          keyboardType: TextInputType.number,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            hintText: "Rs 0.00",
            hintStyle: const TextStyle(color: Colors.white54),
            filled: true,
            fillColor: const Color(0xFF002b4d), // Darker Navy
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide.none,
            ),
          ),
        ),

        const SizedBox(height: 30),

        /// --------------------------
        /// Right Text Fields Only
        /// (Payment Method Removed)
        /// --------------------------
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            customTextField(dailyProfitController, "Daily Profit"),
            const SizedBox(height: 15),
            customTextField(totalProfitController, "Total Profit"),
            const SizedBox(height: 15),
            customTextField(level1Controller, "Level 1"),
            const SizedBox(height: 15),
            customTextField(level2Controller, "Level 2"),
            const SizedBox(height: 15),
            customTextField(durationController, "Duration"),
          ],
        ),

        const SizedBox(height: 40),

        Center(child: buttonFilled("Deposit Now")),
      ],
    );
  }

  Widget customTextField(TextEditingController controller, String hint) {
    return TextField(
      controller: controller,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.white54),
        filled: true,
        fillColor: const Color(0xFF002b4d), // Darker Navy
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}

///////////////////////////////////////////////////////////////////
/// BUTTON
///////////////////////////////////////////////////////////////////
Widget buttonFilled(String text) {
  return Container(
    padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 30),
    decoration: BoxDecoration(
      color: const Color(0xFF003366), // Medium Navy
      borderRadius: BorderRadius.circular(30),
    ),
    child: Text(
      text,
      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
    ),
  );
}
