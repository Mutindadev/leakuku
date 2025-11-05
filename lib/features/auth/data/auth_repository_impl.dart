import 'package:dartz/dartz.dart';
import 'package:leakuku/core/error/failures.dart';
import 'package:leakuku/data/datasources/auth_local_data_source.dart';
import 'package:leakuku/domain/entities/user.dart';
import 'package:leakuku/domain/repositories/auth_repository.dart';
import 'package:leakuku/features/auth/data/auth_local_data_source.dart';
import 'package:leakuku/features/auth/domain/models/user_model.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthLocalDataSource localDataSource;

  AuthRepositoryImpl({required this.localDataSource});

  @override
  Future<Either<Failure, User>> login(String email, String password) async {
    try {
      final userModel = await localDataSource.login(email, password);
      return Right(userModel as User);
    } on AuthFailure catch (e) {
      return Left(AuthFailure(e.message));
    } catch (e) {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, User>> register(
      String name, String email, String password) async {
    try {
      final userModel = UserModel(name: name, email: email, id: '', role: '');
      final newUserModel = await localDataSource.register(userModel, password);
      return Right(newUserModel as User);
    } on AuthFailure catch (e) {
      return Left(AuthFailure(e.message));
    } catch (e) {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, void>> logout() {
    // TODO: implement logout
    throw UnimplementedError();
  }
}
