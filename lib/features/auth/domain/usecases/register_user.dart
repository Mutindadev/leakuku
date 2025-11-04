import 'package:dartz/dartz.dart';
import 'package:leakuku/core/error/failures.dart';
import 'package:leakuku/domain/entities/user.dart';
import 'package:leakuku/domain/repositories/auth_repository.dart';

class RegisterParams {
  final String name;
  final String email;
  final String password;
  final String role;

  RegisterParams({
    required this.name,
    required this.email,
    required this.password,
    required this.role,
  });
}

class RegisterUser {
  final AuthRepository repository;

  RegisterUser(this.repository);

  Future<Either<Failure, User>> call(RegisterParams params) async {
    return await repository.register(
      params.name,
      params.email,
      params.password,
      params.role,
    );
  }
}
