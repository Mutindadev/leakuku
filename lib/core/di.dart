import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';

// Data Sources
import 'package:leakuku/features/auth/data/auth_local_data_source.dart';
import 'package:leakuku/features/flock/data/flock_local_data_source.dart';

// Repositories
import 'package:leakuku/domain/repositories/auth_repository.dart';
import 'package:leakuku/domain/repositories/flock_repository.dart';
import 'package:leakuku/features/auth/data/auth_repository_impl.dart';
import 'package:leakuku/features/flock/data/flock_repository_impl.dart';

// Models
import 'package:leakuku/features/auth/domain/models/user_model.dart';
import 'package:leakuku/features/flock/domain/create_flock.dart';
import 'package:leakuku/features/flock/domain/flock_model.dart';
import 'package:leakuku/features/flock/domain/get_flock.dart';
import 'package:leakuku/features/flock/domain/models/flock_model.dart';

// Use Cases
import 'package:leakuku/features/auth/domain/usecases/login_user.dart';
import 'package:leakuku/features/auth/domain/usecases/register_user.dart';
import 'package:leakuku/features/flock/domain/usecases/create_flock.dart';
import 'package:leakuku/features/flock/domain/usecases/get_all_flocks.dart';
import 'package:leakuku/features/flock/domain/usecases/update_flock.dart';
import 'package:leakuku/features/flock/domain/usecases/delete_flock.dart';

// === Hive Boxes ===

// Provide the User box
final userBoxProvider = FutureProvider<Box<UserModel>>((ref) async {
  return await Hive.openBox<UserModel>('userBox');
});

// Provide the Flock box
final flockBoxProvider = FutureProvider<Box<FlockModel>>((ref) async {
  return await Hive.openBox<FlockModel>('flockBox');
});

// === Local Data Sources ===

// Auth local data source provider
final authLocalDataSourceProvider = Provider<AuthLocalDataSource>((ref) {
  final userBox = ref.watch(userBoxProvider).value;
  if (userBox == null) throw Exception('User Box not initialized');
  return AuthLocalDataSourceImpl(userBox: userBox);
});

// Flock local data source provider
final flockLocalDataSourceProvider = Provider<FlockLocalDataSource>((ref) {
  final flockBox = ref.watch(flockBoxProvider).value;
  if (flockBox == null) throw Exception('Flock Box not initialized');
  return FlockLocalDataSourceImpl(flockBox: flockBox);
});

// === Repositories ===

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final localDataSource = ref.watch(authLocalDataSourceProvider);
  return AuthRepositoryImpl(localDataSource: localDataSource);
});

final flockRepositoryProvider = Provider<FlockRepository>((ref) {
  final localDataSource = ref.watch(flockLocalDataSourceProvider);
  return FlockRepositoryImpl(localDataSource: localDataSource);
});

// === Use Cases ===

// Auth Use Cases
final registerUserProvider = Provider<RegisterUser>((ref) {
  final repo = ref.watch(authRepositoryProvider);
  return RegisterUser(repo);
});

final loginUserProvider = Provider<LoginUser>((ref) {
  final repo = ref.watch(authRepositoryProvider);
  return LoginUser(repo);
});

// Flock Use Cases
final createFlockProvider = Provider<CreateFlock>((ref) {
  final repo = ref.watch(flockRepositoryProvider);
  return CreateFlock(repo);
});

final getFlocksProvider = Provider<GetAllFlocks>((ref) {
  final repo = ref.watch(flockRepositoryProvider);
  return GetAllFlocks(repo);
});

final getFlockProvider = Provider<GetFlock>((ref) {
  final repo = ref.watch(flockRepositoryProvider);
  return GetFlock(repo);
});

final updateFlockProvider = Provider<UpdateFlock>((ref) {
  final repo = ref.watch(flockRepositoryProvider);
  return UpdateFlock(repo);
});

final deleteFlockProvider = Provider<DeleteFlock>((ref) {
  final repo = ref.watch(flockRepositoryProvider);
  return DeleteFlock(repo);
});
