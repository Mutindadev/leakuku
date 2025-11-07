import 'package:dartz/dartz.dart';
import 'package:leakuku/core/error/failures.dart';
import 'package:leakuku/data/models/user_model.dart';
import 'package:leakuku/domain/entities/user.dart';
import 'package:leakuku/domain/repositories/auth_repository.dart';
import 'package:leakuku/features/auth/data/auth_local_data_source.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthLocalDataSource localDataSource;

  AuthRepositoryImpl({required this.localDataSource});

  @override
  Future<Either<Failure, User>> login(String username, String password) async {
    try {
      final userModel = await localDataSource.login(username, password);
      // Convert UserModel to User entity
      final user = User(
        id: userModel.id,
        name: userModel.name,
        email: userModel.email,
        role: userModel.role,
      );
      return Right(user);
    } on AuthFailure catch (e) {
      return Left(AuthFailure(e.message));
    } catch (e) {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, UserModel>> register(
      String name, String email, String password) async {
    try {
      final userModel = UserModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        name: name,
        email: email,
        role: 'Farmer', // Set default role to Farmer
      );

      final newUser = await localDataSource.register(userModel, password);
      return Right(newUser);
    } on AuthFailure catch (e) {
      return Left(AuthFailure(e.message));
    } catch (e) {
      return Left(AuthFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> logout() async {
    // Clear user session/cache if needed
    return const Right(null);
  }
}
