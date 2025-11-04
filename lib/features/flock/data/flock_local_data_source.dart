import 'package:hive/hive.dart';
import 'package:leakuku/core/error/failures.dart';
import 'package:leakuku/features/flock/domain/flock_model.dart';

abstract class FlockLocalDataSource {
  Future<FlockModel> getFlock(String id);
  Future<List<FlockModel>> getAllFlocks();
  Future<void> saveFlock(FlockModel flock);
}

class FlockLocalDataSourceImpl implements FlockLocalDataSource {
  final Box<FlockModel> flockBox;

  FlockLocalDataSourceImpl({required this.flockBox});

  @override
  Future<FlockModel> getFlock(String id) async {
    try {
      final flock = flockBox.get(id);
      if (flock == null) {
        throw DataNotFoundFailure();
      }
      return flock;
    } catch (e) {
      throw CacheFailure();
    }
  }

  @override
  Future<List<FlockModel>> getAllFlocks() async {
    try {
      final flocks = flockBox.values.toList();
      if (flocks.isEmpty) {
        throw DataNotFoundFailure();
      }
      return flocks.toList();
    } catch (e) {
      throw CacheFailure();
    }
  }

  @override
  Future<void> saveFlock(FlockModel flock) async {
    try {
      await flockBox.put(flock.id, flock);
    } catch (e) {
      throw CacheFailure();
    }
  }
}
