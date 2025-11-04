import 'package:dartz/dartz.dart';
import 'package:lea_kuku/core/failures/failures.dart';
import 'package:lea_kuku/features/auth/domain/entities/user.dart';

abstract class AuthRepository {
  Future<Either<Failure, User>> login(String email, String password);
  Future<Either<Failure, User>> register(User user, String password);
}
