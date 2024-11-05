import 'package:flutter/material.dart';
import 'splash_screen.dart';
import 'login.dart';
import 'dashboard.dart';
import 'paymant.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Blangkis UMKM',
      debugShowCheckedModeBanner: false, // Menghilangkan label "Debug"
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/login': (context) => const LoginScreen(),
        '/dashboard': (context) => const DashboardScreen(),
      },
      onGenerateRoute: (settings) {
        if (settings.name == '/payment') {
          final args = settings.arguments as Map<String, dynamic>;

          return MaterialPageRoute(
            builder: (context) => PaymentScreen(
              total: args['total'],
              cart: args['cart'],
            ),
          );
        }
        return null;
      },
    );
  }
}
