import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:lea_kuku/core/failures/failures.dart';
import 'package:lea_kuku/features/auth/domain/entities/user.dart';
import 'package:lea_kuku/features/auth/domain/auth_repository.dart';

class RegisterUser {
  final AuthRepository repository;

  RegisterUser(this.repository);

  Future<Either<Failure, User>> call(RegisterParams params) async {
    final newUser = User(
      id: params.email, // Using email as temporary ID
      name: params.name,
      email: params.email,
      role: params.role,
    );
    return await repository.register(newUser, params.password);
  }
}

class RegisterParams extends Equatable {
  final String name;
  final String email;
  final String password;
  final String role; // 'Farmer' or 'Admin'

  const RegisterParams({
    required this.name,
    required this.email,
    required this.password,
    required this.role,
  });

  @override
  List<Object> get props => [name, email, password, role];
}
