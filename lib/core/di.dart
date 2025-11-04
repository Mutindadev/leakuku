import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:lea_kuku/features/auth/data/datasources/auth_local_data_source.dart';
import 'package:lea_kuku/features/flock/data/flock_local_data_source.dart';
import 'package:lea_kuku/features/flock/data/flock_model.dart';
import 'package:lea_kuku/features/auth/data/models/user_model.dart';
import 'package:lea_kuku/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:lea_kuku/features/flock/data/flock_repository_impl.dart';
import 'package:lea_kuku/features/auth/domain/repositories/auth_repository.dart';
import 'package:lea_kuku/features/flock/domain/flock_repository.dart';
import 'package:lea_kuku/features/auth/domain/usecases/auth/login_user.dart';
import 'package:lea_kuku/features/auth/domain/usecases/auth/register_user.dart';
import 'package:lea_kuku/features/flock/domain/create_flock.dart';
import 'package:lea_kuku/features/flock/domain/get_flock.dart';

// --- Hive Boxes (Data Source Dependencies) ---
final userBoxProvider = FutureProvider<Box<UserModel>>((ref) async {
  return await Hive.openBox<UserModel>('userBox');
});

final flockBoxProvider = FutureProvider<Box<FlockModel>>((ref) async {
  return await Hive.openBox<FlockModel>('flockBox');
});

// --- Data Sources ---
final authLocalDataSourceProvider = Provider<AuthLocalDataSource>((ref) {
  final userBox = ref.watch(userBoxProvider).value;
  if (userBox == null) throw Exception('User Box not initialized');
  return AuthLocalDataSourceImpl(userBox: userBox);
});

final flockLocalDataSourceProvider = Provider<FlockLocalDataSource>((ref) {
  final flockBox = ref.watch(flockBoxProvider).value;
  if (flockBox == null) throw Exception('Flock Box not initialized');
  return FlockLocalDataSourceImpl(flockBox: flockBox);
});

// --- Repositories ---
final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepositoryImpl(
    localDataSource: ref.watch(authLocalDataSourceProvider),
  );
});

final flockRepositoryProvider = Provider<FlockRepository>((ref) {
  return FlockRepositoryImpl(
    localDataSource: ref.watch(flockLocalDataSourceProvider),
  );
});

// --- Use Cases ---
final loginUserProvider = Provider<LoginUser>((ref) {
  return LoginUser(ref.watch(authRepositoryProvider));
});

final registerUserProvider = Provider<RegisterUser>((ref) {
  return RegisterUser(ref.watch(authRepositoryProvider));
});

final createFlockProvider = Provider<CreateFlock>((ref) {
  return CreateFlock(ref.watch(flockRepositoryProvider));
});

final getFlockProvider = Provider<GetFlock>((ref) {
  return GetFlock(ref.watch(flockRepositoryProvider));
});