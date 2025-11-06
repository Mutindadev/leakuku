import 'package:hive/hive.dart';
import 'package:leakuku/core/error/failures.dart';
import 'package:leakuku/data/models/user_model.dart';

abstract class AuthLocalDataSource {
  Future<UserModel> login(String email, String password);
  Future<UserModel> register(UserModel user, String password);
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final Box<UserModel> userBox;

  AuthLocalDataSourceImpl({required this.userBox});

  @override
  Future<UserModel> login(String email, String password) async {
    // In a real app, we would hash the password and check against a stored hash.
    // For this local mock, we'll just check if the user exists.
    try {
      final user = userBox.values.firstWhere((u) => u.email == email);
      // Mock password check: in a real app, this is where the hash check happens.
      // Since we don't store passwords in the UserModel for simplicity,
      // we'll simulate a successful login if the user is found.
      return user;
    } on StateError {
      throw AuthFailure('Invalid email or password.');
    } catch (e) {
      throw AuthFailure(e.toString());
    }
  }

  @override
  Future<UserModel> register(UserModel user, String password) async {
    // Check if user with this email already exists
    final existingUser = userBox.values.where((u) => u.email == user.email).firstOrNull;
    
    if (existingUser != null) {
      throw AuthFailure('User with this email already exists.');
    }

    // Create new user with email as ID
    final newUser = UserModel(
      id: user.email,
      name: user.name,
      email: user.email,
      role: user.role,
    );

    await userBox.put(newUser.email, newUser);
    return newUser;
  }
}
