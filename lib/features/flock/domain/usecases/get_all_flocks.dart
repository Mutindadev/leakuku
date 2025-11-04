import 'package:dartz/dartz.dart';
import 'package:leakuku/core/error/failures.dart';
import 'package:leakuku/domain/entities/flock.dart';
import 'package:leakuku/domain/repositories/flock_repository.dart';

class GetAllFlocks {
  final FlockRepository repository;

  GetAllFlocks(this.repository);

  Future<Either<Failure, List<Flock>>> call() async {
    return await repository.getAllFlocks();
  }
}
