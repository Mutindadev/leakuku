import 'package:dartz/dartz.dart';
import 'package:leakuku/core/error/failures.dart';
import 'package:leakuku/domain/entities/flock.dart';
import 'package:leakuku/domain/repositories/flock_repository.dart';

class UpdateFlock {
  final FlockRepository repository;

  UpdateFlock(this.repository);

  Future<Either<Failure, Flock>> call(String flockId) async {
    return await repository.updateFlock(flockId);
  }
}
