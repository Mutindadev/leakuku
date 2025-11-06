import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:leakuku/core/di.dart';
import 'package:leakuku/domain/entities/user.dart';
import 'package:leakuku/features/auth/domain/usecases/login_user.dart';
import 'package:leakuku/features/auth/domain/usecases/register_user.dart';

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
      error: error,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

class AuthNotifier extends StateNotifier<AuthState> {
  final Ref ref;
  
  AuthNotifier(this.ref) : super(AuthState());

  Future<void> login(String email, String password) async {
    if (email.isEmpty || password.isEmpty) {
      state = AuthState(error: 'Please enter email and password');
      return;
    }

    state = state.copyWith(isLoading: true, error: null);
    
    try {
      final loginUseCase = ref.read(loginUserProvider);
      final result = await loginUseCase(LoginParams(email: email, password: password));
      
      result.fold(
        (failure) {
          state = AuthState(error: failure.message, isLoading: false);
        },
        (user) {
          state = AuthState(user: user, isLoading: false);
        },
      );
    } catch (e) {
      state = AuthState(error: e.toString(), isLoading: false);
    }
  }

  Future<void> register(String name, String email, String password, String role) async {
    if (name.isEmpty || email.isEmpty || password.isEmpty) {
      state = AuthState(error: 'Please fill all fields');
      return;
    }

    state = state.copyWith(isLoading: true, error: null);
    
    try {
      final registerUseCase = ref.read(registerUserProvider);
      final result = await registerUseCase(RegisterParams(name: name, email: email, password: password, role: role));
      
      result.fold(
        (failure) {
          state = AuthState(error: failure.message, isLoading: false);
        },
        (user) {
          state = AuthState(user: user, isLoading: false);
        },
      );
    } catch (e) {
      state = AuthState(error: e.toString(), isLoading: false);
    }
  }

  void logout() {
    state = AuthState();
  }
}

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  return AuthNotifier(ref);
});
