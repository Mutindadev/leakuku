import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:leakuku/data/models/user_model.dart';
import 'package:leakuku/domain/entities/user.dart';
import 'package:leakuku/domain/repositories/auth_repository.dart';
import 'package:leakuku/features/auth/data/auth_local_data_source.dart';
import 'package:leakuku/features/auth/domain/usecases/login_user.dart';
import 'package:leakuku/features/auth/domain/usecases/register_user.dart';

final di = GetIt.instance;

class AuthState {
  final User? user;
  final String? error;
  final bool isLoading;
  final bool isAuthenticated; // Add this

  AuthState({
    this.user,
    this.error,
    this.isLoading = false,
    this.isAuthenticated = false, // Add this
  });

  AuthState copyWith({
    User? user,
    String? error,
    bool? isLoading,
    bool? isAuthenticated, // Add this
  }) {
    return AuthState(
      user: user ?? this.user,
      error: error,
      isLoading: isLoading ?? this.isLoading,
      isAuthenticated: isAuthenticated ?? this.isAuthenticated, // Add this
    );
  }
}

class AuthNotifier extends StateNotifier<AuthState> {
  final LoginUser _loginUser;
  final RegisterUser _registerUser;

  AuthNotifier(this._loginUser, this._registerUser) : super(AuthState());

  Future<void> login(String email, String password) async {
    state = state.copyWith(isLoading: true, error: null);
    final params = LoginParams(email: email, password: password);

    try {
      final result = await _loginUser(params);
      result.fold(
        (failure) => state = state.copyWith(
            isLoading: false, error: failure.message, isAuthenticated: false),
        (user) => state = state.copyWith(
            isLoading: false, user: user, isAuthenticated: true, error: null),
      );
    } catch (e) {
      state = state.copyWith(
          isLoading: false,
          error: 'An unexpected error occurred',
          isAuthenticated: false);
    }
  }

  Future<void> register(
      String name, String email, String password, String role) async {
    try {
      state = state.copyWith(isLoading: true, error: null);

      // Validate input parameters
      if (name.isEmpty || email.isEmpty || password.isEmpty || role.isEmpty) {
        state = state.copyWith(
            isLoading: false,
            error: 'All fields are required',
            isAuthenticated: false);
        return;
      }

      final params = RegisterParams(
          name: name, email: email, password: password, role: role);

      final result = await _registerUser(params);

      result.fold(
        (failure) => state = state.copyWith(
            isLoading: false,
            error: failure.message ?? 'Registration failed',
            isAuthenticated: false),
        (userModel) {
          if (userModel != null) {
            final user = User(
                id: userModel.id,
                name: userModel.name,
                email: userModel.email,
                role: userModel.role);
            state = state.copyWith(
                user: user,
                isLoading: false,
                isAuthenticated: true,
                error: null);
          } else {
            state = state.copyWith(
                isLoading: false,
                error: 'Failed to create user',
                isAuthenticated: false);
          }
        },
      );
    } catch (e) {
      state = state.copyWith(
          isLoading: false, error: e.toString(), isAuthenticated: false);
    }
  }

  void logout() {
    state = AuthState();
  }
}

final userBoxProvider = Provider<Box<UserModel>>((ref) {
  return di<Box<UserModel>>();
});

final authLocalDataSourceProvider = Provider<AuthLocalDataSource>((ref) {
  return di<AuthLocalDataSource>();
});

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return di<AuthRepository>();
});

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  return AuthNotifier(
    di<LoginUser>(),
    di<RegisterUser>(),
  );
});
