import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:lea_kuku/features/flock/data/flock_model.dart';

import 'package:lea_kuku/features/auth/presentation/login_register_page.dart';
import 'package:lea_kuku/features/flock/presentation/dashboard_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(UserModelAdapter());
  Hive.registerAdapter(FlockModelAdapter());

  runApp(const ProviderScope(child: LeaKukuApp()));
}

class LeaKukuApp extends StatelessWidget {
  const LeaKukuApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lea Kuku',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color(0xFF4CAF50),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF4CAF50),
          primary: const Color(0xFF4CAF50),
          secondary: const Color(0xFFFF9800),
        ),
        scaffoldBackgroundColor: const Color(0xFFF5F5F5),
        useMaterial3: true,
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF4CAF50),
          foregroundColor: Colors.white,
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => LoginRegisterPage(),
        '/dashboard': (context) => const DashboardPage(),
        // Add other routes here (e.g., /profile, /progress, /feed_vaccination)
      },
    );
  }
}
