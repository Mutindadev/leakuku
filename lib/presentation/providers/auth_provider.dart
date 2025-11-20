import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:leakuku/core/di.dart';
import 'package:leakuku/domain/entities/user.dart';
import 'package:leakuku/features/auth/domain/usecases/login_user.dart';
import 'package:leakuku/features/auth/domain/usecases/register_user.dart';

class AuthState {
  final User? user;
  final String? error;
  final bool isLoading;
  // NEW: which action produced the last message and whether it's an input validation error
  final bool? lastWasRegister;
  final bool errorIsInput;

  AuthState({
    this.user,
    this.error,
    this.isLoading = false,
    this.lastWasRegister,
    this.errorIsInput = false,
  });

  AuthState copyWith({
    User? user,
    String? error,
    bool? isLoading,
    bool? lastWasRegister,
    bool? errorIsInput,
  }) {
    return AuthState(
      user: user ?? this.user,
      // keep as-is: passing null explicitly clears the error, omitting the param also clears
      error: error,
      isLoading: isLoading ?? this.isLoading,
      lastWasRegister: lastWasRegister ?? this.lastWasRegister,
      errorIsInput: errorIsInput ?? this.errorIsInput,
    );
  }
}

class AuthNotifier extends StateNotifier<AuthState> {
  final Ref ref;
  
  AuthNotifier(this.ref) : super(AuthState());

  Future<void> login(String email, String password) async {
    final e = email.trim();
    final p = password.trim();

    if (e.isEmpty || p.isEmpty) {
      state = state.copyWith(
        error: 'Please enter email and password',
        isLoading: false,
        lastWasRegister: false,
        errorIsInput: true,
      );
      return;
    }

    state = state.copyWith(isLoading: true, error: null, lastWasRegister: false, errorIsInput: false);
    try {
      final loginUseCase = ref.read(loginUserProvider);
      final result = await loginUseCase(LoginParams(email: e, password: p));
      result.fold(
        (failure) => state = state.copyWith(
          error: failure.message,
          isLoading: false,
          lastWasRegister: false,
          errorIsInput: false,
        ),
        (user) => state = state.copyWith(
          user: user,
          isLoading: false,
          error: null,
          lastWasRegister: false,
          errorIsInput: false,
        ),
      );
    } catch (e) {
      state = state.copyWith(
        error: e.toString(),
        isLoading: false,
        lastWasRegister: false,
        errorIsInput: false,
      );
    }
  }

  Future<void> register(String name, String email, String password, String role) async {
    final n = name.trim();
    final e = email.trim();
    final p = password.trim();

    if (n.isEmpty || e.isEmpty || p.isEmpty) {
      state = state.copyWith(
        error: 'Please fill all fields',
        isLoading: false,
        lastWasRegister: true,
        errorIsInput: true,
      );
      return;
    }

    state = state.copyWith(isLoading: true, error: null, lastWasRegister: true, errorIsInput: false);
    try {
      final registerUseCase = ref.read(registerUserProvider);
      final result = await registerUseCase(RegisterParams(name: n, email: e, password: p, role: role));
      result.fold(
        (failure) => state = state.copyWith(
          error: failure.message,
          isLoading: false,
          lastWasRegister: true,
          errorIsInput: false,
        ),
        (user) => state = state.copyWith(
          user: user,
          isLoading: false,
          error: null,
          lastWasRegister: true,
          errorIsInput: false,
        ),
      );
    } catch (e) {
      state = state.copyWith(
        error: e.toString(),
        isLoading: false,
        lastWasRegister: true,
        errorIsInput: false,
      );
    }
  }

  void logout() {
    state = AuthState();
  }
}

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  return AuthNotifier(ref);
});
