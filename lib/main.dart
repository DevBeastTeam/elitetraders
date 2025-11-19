import 'package:flutter/material.dart';
import 'LoginPage.dart';

void main() {
  runApp(const RegisterUI());
}

class RegisterUI extends StatelessWidget {
  const RegisterUI({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
    );
  }
}
