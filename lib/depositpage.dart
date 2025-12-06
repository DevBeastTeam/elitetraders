import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
  // Removed unused controllers for simplicity as per standard flow
  // If you need them, keep them. For now, we focus on Amount + Proof/Method

  bool _isLoading = false;

  @override
  void dispose() {
    amountController.dispose();
    super.dispose();
  }

  Future<void> _submitDeposit() async {
    if (amountController.text.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Please enter amount")));
      return;
    }

    setState(() => _isLoading = true);
    User? user = FirebaseAuth.instance.currentUser;

    try {
      if (user != null) {
        await FirebaseFirestore.instance.collection('deposits').add({
          'userId': user.uid,
          'amount': double.parse(amountController.text.trim()),
          'status': 'pending',
          'createdAt': Timestamp.now(),
          'method': 'Manual', // Can be enhanced to select method
        });

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Deposit Request Submitted!")),
          );
          Navigator.pop(context);
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Error: $e")));
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
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

        // Instructions
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFF002b4d),
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Instructions:",
                style: TextStyle(
                  color: Colors.orange,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Text(
                "1. Send amount to Admin Account.",
                style: TextStyle(color: Colors.white70),
              ),
              Text(
                "2. Enter amount above.",
                style: TextStyle(color: Colors.white70),
              ),
              Text(
                "3. Click Deposit Now.",
                style: TextStyle(color: Colors.white70),
              ),
              Text(
                "4. Wait for approval.",
                style: TextStyle(color: Colors.white70),
              ),
            ],
          ),
        ),

        const SizedBox(height: 40),

        Center(
          child: SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _isLoading ? null : _submitDeposit,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF003366), // Medium Navy
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: _isLoading
                  ? const CircularProgressIndicator(color: Colors.white)
                  : const Text(
                      "Deposit Now",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
            ),
          ),
        ),
      ],
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
