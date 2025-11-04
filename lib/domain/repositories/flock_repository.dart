import 'package:dartz/dartz.dart';
import 'package:leakuku/core/error/failures.dart';
import 'package:leakuku/domain/entities/flock.dart';

abstract class FlockRepository {
  Future<Either<Failure, Flock>> createFlock(Flock flock);
  Future<Either<Failure, Flock>> getFlock(String flockId);
  Future<Either<Failure, List<Flock>>> getAllFlocks();
}
