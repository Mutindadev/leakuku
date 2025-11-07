// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:leakuku/core/error/failures.dart';
// import 'package:leakuku/core/di.dart';
// import 'package:leakuku/domain/entities/user.dart';
// import 'package:leakuku/features/auth/domain/usecases/login_user.dart';
// import 'package:leakuku/features/auth/domain/usecases/register_user.dart';

// class AuthState {
//   final User? user;
//   final String? error;
//   final bool isLoading;
//   final bool isAuthenticated; // Add this

//   AuthState({
//     this.user,
//     this.error,
//     this.isLoading = false,
//     this.isAuthenticated = false, // Add this
//   });

//   AuthState copyWith({
//     User? user,
//     String? error,
//     bool? isLoading,
//     bool? isAuthenticated, // Add this
//   }) {
//     return AuthState(
//       user: user ?? this.user,
//       error: error,
//       isLoading: isLoading ?? this.isLoading,
//       isAuthenticated: isAuthenticated ?? this.isAuthenticated, // Add this
//     );
//   }
// }

// class AuthNotifier extends StateNotifier<AuthState> {
//   final LoginUser _loginUser;
//   final RegisterUser _registerUser;

//   AuthNotifier(this._loginUser, this._registerUser) : super(AuthState());

//   Future<void> login(String email, String password) async {
//     state = state.copyWith(isLoading: true, error: null);
//     final params = LoginParams(email: email, password: password);
//     final result = await _loginUser(params);

//     result.fold(
//       (failure) =>
//           state = state.copyWith(isLoading: false, error: failure.message),
//       (user) => state = state.copyWith(isLoading: false, user: user),
//     );
//   }

//   Future<void> register(
//       String name, String email, String password, String role) async {
//     state = state.copyWith(isLoading: true, error: null);
//     final params = RegisterParams(
//         name: name, email: email, password: password, role: role);
//     final result = await _registerUser(params);

//     result.fold(
//       (failure) =>
//           state = state.copyWith(isLoading: false, error: failure.message),
//       (user) => state = state.copyWith(isLoading: false, user: user),
//     );
//   }

//   void logout() {
//     state = AuthState();
//   }
// }

// final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
//   return AuthNotifier(
//     ref.watch(loginUserProvider),
//     ref.watch(registerUserProvider),
//   );
// });
