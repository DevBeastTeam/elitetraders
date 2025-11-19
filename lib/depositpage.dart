import 'package:flutter/material.dart';

class DepositPage extends StatelessWidget {
  const DepositPage({super.key});

  @override
  Widget build(BuildContext context) {
    double maxWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 3, 118, 66),

      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 3, 125, 58),
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
            fillColor: const Color(0xff064d2c),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide.none,
            ),
          ),
        ),
        const SizedBox(height: 30),

        /// Middle Row: Payment Methods + Text Fields
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Left: Payment Methods
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    "Choose Payment Method",
                    style: TextStyle(color: Colors.white70, fontSize: 16),
                  ),
                  const SizedBox(height: 15),
                  Wrap(
                    spacing: 20,
                    runSpacing: 15,
                    children: [
                      paymentButton(Icons.account_balance, "Bank Transfer"),
                      paymentButton(Icons.account_balance_wallet, "E-Wallet"),
                      paymentButton(Icons.credit_card, "Card Payment"),
                      paymentButton(Icons.qr_code, "QR Payment"),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(width: 20),

            /// Right: Text Fields
            Expanded(
              child: Column(
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
            ),
          ],
        ),

        const SizedBox(height: 40),

        /// Submit Button
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
        fillColor: const Color(0xff064d2c),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}

///////////////////////////////////////////////////////////////////
/// BUTTONS
///////////////////////////////////////////////////////////////////
Widget buttonFilled(String text) {
  return Container(
    padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 30),
    decoration: BoxDecoration(
      color: Colors.green,
      borderRadius: BorderRadius.circular(30),
    ),
    child: Text(
      text,
      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
    ),
  );
}

Widget paymentButton(IconData icon, String title) {
  return Container(
    width: 140,
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(15),
    ),
    child: Column(
      children: [
        Icon(icon, size: 40, color: Colors.green),
        const SizedBox(height: 8),
        Text(
          title,
          textAlign: TextAlign.center,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ],
    ),
  );
}
