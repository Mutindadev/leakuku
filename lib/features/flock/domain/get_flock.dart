import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:leakuku/core/error/failures.dart';
import 'package:leakuku/domain/entities/flock.dart';
import 'package:leakuku/domain/repositories/flock_repository.dart';

class GetFlock {
  final FlockRepository repository;

  GetFlock(this.repository);

  Future<Either<Failure, Flock>> call(String flockId) async {
    return await repository.getFlock(flockId);
  }
}
