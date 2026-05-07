import 'package:flutter/material.dart';
import 'screens/login_screen.dart';
import 'screens/forgot_password_screen.dart';
import 'screens/dashboard_screen.dart'; // IMPORT DASHBOARD

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.indigo),
      initialRoute: '/',
      routes: {
        '/': (context) => const LoginScreen(),
        '/forgot': (context) => const ForgotPasswordScreen(),
        // HAPUS ROUTE /dashboard DARI SINI
      },
      // PAKE onGenerateRoute BUAT KIRIM PARAMETER
      onGenerateRoute: (settings) {
        if (settings.name == '/dashboard') {
          final args = settings.arguments as String; // TERIMA EMAIL
          return MaterialPageRoute(
            builder: (context) => DashboardScreen(userEmail: args),
          );
        }
        return null;
      },
    );
  }
}