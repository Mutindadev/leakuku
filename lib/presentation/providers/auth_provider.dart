import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:leakuku/domain/entities/user.dart';

class AuthState {
  final User? user;
  final String? error;
  final bool isLoading;

  AuthState({
    this.user,
    this.error,
    this.isLoading = false,
  });

  AuthState copyWith({
    User? user,
    String? error,
    bool? isLoading,
  }) {
    return AuthState(
      user: user ?? this.user,
      error: error ?? this.error,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

class AuthNotifier extends StateNotifier<AuthState> {
  AuthNotifier() : super(AuthState());

  Future<void> login(String email, String password) async {
    state = AuthState(isLoading: true);
    try {
      // TODO: Implement actual login logic
      throw UnimplementedError();
    } catch (e) {
      state = AuthState(error: e.toString());
    }
  }

  Future<void> register(String name, String email, String password, String role) async {
    state = AuthState(isLoading: true);
    try {
      // TODO: Implement actual registration logic
      throw UnimplementedError();
    } catch (e) {
      state = AuthState(error: e.toString());
    }
  }
}

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  return AuthNotifier();
});
