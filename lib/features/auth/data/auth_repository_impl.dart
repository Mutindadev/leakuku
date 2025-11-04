import 'package:dartz/dartz.dart';
import 'package:lea_kuku/core/failures/failures.dart';
import 'package:lea_kuku/features/auth/data/datasources/auth_local_data_source.dart';
import 'package:lea_kuku/features/auth/data/models/user_model.dart';
import 'package:lea_kuku/features/auth/domain/entities/user.dart';
import 'package:lea_kuku/features/auth/domain/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthLocalDataSource localDataSource;

  AuthRepositoryImpl({required this.localDataSource});

  @override
  Future<Either<Failure, User>> login(String email, String password) async {
    try {
      final userModel = await localDataSource.login(email, password);
      return Right(userModel);
    } on AuthFailure catch (e) {
      return Left(AuthFailure(e.message));
    } catch (e) {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, User>> register(User user, String password) async {
    try {
      final userModel = UserModel.fromEntity(user);
      final newUserModel = await localDataSource.register(userModel, password);
      return Right(newUserModel);
    } on AuthFailure catch (e) {
      return Left(AuthFailure(e.message));
    } catch (e) {
      return Left(CacheFailure());
    }
  }
}
