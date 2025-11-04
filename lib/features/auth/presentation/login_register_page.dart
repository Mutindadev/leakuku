import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lea_kuku/features/auth/presentation/providers/auth_provider.dart';

class LoginRegisterPage extends ConsumerWidget {
  LoginRegisterPage({super.key});

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final ValueNotifier<bool> _isLogin = ValueNotifier(true);
  final ValueNotifier<String> _role = ValueNotifier('Farmer');

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<AuthState>(authProvider, (previous, next) {
      if (next.error != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: ${next.error.toString()}')),
        );
      }
      if (next.user != null) {
        // Navigate to Dashboard
        Navigator.of(context).pushReplacementNamed('/dashboard');
      }
    });

    final authState = ref.watch(authProvider);

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5), // Neutral Background
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(32.0),
          child: Card(
            elevation: 8.0,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: ValueListenableBuilder<bool>(
                valueListenable: _isLogin,
                builder: (context, isLogin, child) {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        FontAwesomeIcons.cow, // Placeholder icon
                        size: 60,
                        color: const Color(0xFF4CAF50),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        isLogin ? 'Welcome Back!' : 'Join Lea Kuku',
                        style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF212121),
                        ),
                      ),
                      const SizedBox(height: 24),
                      if (!isLogin) ...[
                        TextFormField(
                          controller: _nameController,
                          decoration: _inputDecoration('Name', FontAwesomeIcons.user),
                        ),
                        const SizedBox(height: 16),
                      ],
                      TextFormField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: _inputDecoration('Email', FontAwesomeIcons.envelope),
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _passwordController,
                        obscureText: true,
                        decoration: _inputDecoration('Password', FontAwesomeIcons.lock),
                      ),
                      if (!isLogin) ...[
                        const SizedBox(height: 16),
                        ValueListenableBuilder<String>(
                          valueListenable: _role,
                          builder: (context, role, child) {
                            return DropdownButtonFormField<String>(
                              value: role,
                              decoration: _inputDecoration('Role', FontAwesomeIcons.userTag),
                              items: ['Farmer', 'Admin'].map((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                              onChanged: (String? newValue) {
                                if (newValue != null) {
                                  _role.value = newValue;
                                }
                              },
                            );
                          },
                        ),
                      ],
                      const SizedBox(height: 32),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: authState.isLoading
                              ? null
                              : () {
                                  if (isLogin) {
                                    ref.read(authProvider.notifier).login(
                                      _emailController.text,
                                      _passwordController.text,
                                    );
                                  } else {
                                    ref.read(authProvider.notifier).register(
                                      _nameController.text,
                                      _emailController.text,
                                      _passwordController.text,
                                      _role.value,
                                    );
                                  }
                                },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF4CAF50), // Primary Color
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          ),
                          child: authState.isLoading
                              ? const CircularProgressIndicator(color: Colors.white)
                              : Text(
                                  isLogin ? 'LOGIN' : 'REGISTER',
                                  style: const TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
                                ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      TextButton(
                        onPressed: () {
                          _isLogin.value = !isLogin;
                        },
                        child: Text(
                          isLogin ? 'Don\'t have an account? Register' : 'Already have an account? Login',
                          style: TextStyle(color: const Color(0xFFFF9800)), // Accent Color
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  InputDecoration _inputDecoration(String label, IconData icon) {
    return InputDecoration(
      labelText: label,
      prefixIcon: Icon(icon, color: const Color(0xFF4CAF50)), // Primary Color
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      filled: true,
      fillColor: Colors.white,
    );
  }
}
