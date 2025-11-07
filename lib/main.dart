import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:leakuku/core/di.dart';
import 'package:leakuku/data/models/user_model.dart';
import 'package:leakuku/data/models/user_model_adapter.dart';

import 'package:leakuku/features/auth/presentation/login_register_page.dart';
import 'package:leakuku/features/flock/domain/flock_model.dart';
import 'package:leakuku/features/flock/presentation/dashboard_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(UserModelAdapter());

  // await Hive.openBox<UserModel>('userBox');

  Hive.registerAdapter(FlockModelAdapter());
  // Open Hive boxes before initializing dependencies
  final userBox = await Hive.openBox<UserModel>('userBox');
  final flockBox = await Hive.openBox<FlockModel>('flockBox');

  // Initialize dependencies with opened boxes
  await initializeDependencies(userBox: userBox, flockBox: flockBox);

  runApp(const ProviderScope(child: LeaKukuApp()));
}

class LeaKukuApp extends StatelessWidget {
  const LeaKukuApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LeaKuku',
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
        '/': (context) => const LoginRegisterPage(),
        '/dashboard': (context) => const DashboardPage(),
      },
    );
  }
}
