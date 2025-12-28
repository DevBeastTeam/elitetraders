import 'package:flutter/material.dart';
import 'LoginPage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'HomePage.dart';
import 'firebase_options.dart';
import 'package:elitetraders/AdminDashboard.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Auto-create admin account if not exists
  // Auto-create admin account if not exists
  // try {
  //   await FirebaseAuth.instance.createUserWithEmailAndPassword(
  //     email: 'admin@admin.com',
  //     password: '123456',
  //   );

  //   print('✅ Admin account created: admin@admin.com / 123456');
  // } catch (e) {

  //   print('Admin account already exists or error: $e');
  // }

  runApp(const RegisterUI());
}

class RegisterUI extends StatelessWidget {
  const RegisterUI({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const AuthWrapper(),
      theme: ThemeData(scaffoldBackgroundColor: const Color(0xFF001a33)),
      routes: {'/admin-dashboard': (context) => const AdminDashboard()},
    );
  }
}

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
        if (snapshot.hasData) {
          // final user = snapshot.data!;
          // if (user.email == 'admin@admin.com') {
          //   return const AdminDashboard();
          // }
          return const EliteTradersApp(); // User is logged in
        }
        return const LoginPage(); // User is not logged in
      },
    );
  }
}
