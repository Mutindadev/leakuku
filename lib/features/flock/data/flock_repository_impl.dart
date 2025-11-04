import 'package:dartz/dartz.dart';
import 'package:leakuku/core/error/failures.dart';
import 'package:leakuku/features/flock/data/flock_local_data_source.dart';
import 'package:leakuku/features/flock/domain/flock_model.dart';
import 'package:leakuku/domain/entities/flock.dart';
import 'package:leakuku/domain/repositories/flock_repository.dart';

class FlockRepositoryImpl implements FlockRepository {
  final FlockLocalDataSource localDataSource;

  FlockRepositoryImpl({required this.localDataSource});

  @override
  Future<Either<Failure, Flock>> createFlock(Flock flock) async {
    try {
      final flockModel = FlockModel.fromEntity(flock);
      await localDataSource.saveFlock(flockModel);
      return Right(flock);
    } on CacheFailure {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, Flock>> getFlock(String flockId) async {
    try {
      final flockModel = await localDataSource.getFlock(flockId);
      return Right(flockModel);
    } on DataNotFoundFailure {
      return Left(DataNotFoundFailure());
    } on CacheFailure {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, List<Flock>>> getAllFlocks() async {
    try {
      final flockModels = await localDataSource.getAllFlocks();
      return Right(flockModels);
    } on CacheFailure {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, void>> deleteFlock(String flockId) async {
    try {
      await localDataSource.deleteFlock(flockId);
      return const Right(null);
    } on DataNotFoundFailure {
      return Left(DataNotFoundFailure());
    } on CacheFailure {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, Flock>> updateFlock(String flockId) async {
    try {
      final flockModel = await localDataSource.getFlock(flockId);
      await localDataSource.updateFlock(flockModel);
      return Right(flockModel);
    } on DataNotFoundFailure {
      return Left(DataNotFoundFailure());
    } on CacheFailure {
      return Left(CacheFailure());
    }
  }
}
