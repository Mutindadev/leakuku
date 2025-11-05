import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:leakuku/core/error/failures.dart';
import 'package:leakuku/domain/entities/flock.dart';
import 'package:leakuku/domain/repositories/flock_repository.dart';

class CreateFlock {
  final FlockRepository repository;

  CreateFlock(this.repository);

  Future<Either<Failure, Flock>> call(FlockParams params) async {
    final newFlock = Flock(
      // A real app would generate a unique ID here
      id: params.farmerId + params.startDate.toIso8601String(),
      farmerId: params.farmerId,
      location: params.location,
      chickenType: params.chickenType,
      startDate: params.startDate,
      batchSize: params.batchSize,
    );
    return await repository.createFlock(newFlock);
  }
}

class FlockParams extends Equatable {
  final String farmerId;
  final String location;
  final String chickenType;
  final DateTime startDate;
  final int batchSize;

  const FlockParams({
    required this.farmerId,
    required this.location,
    required this.chickenType,
    required this.startDate,
    required this.batchSize,
  });

  @override
  List<Object> get props => [farmerId, location, chickenType, startDate, batchSize];
}
