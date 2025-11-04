import 'package:hive/hive.dart';
import 'package:leakuku/domain/entities/flock.dart';

part 'flock_model.g.dart'; // Generated file by hive_generator

@HiveType(typeId: 1)
class FlockModel extends Flock {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String farmerId;
  @HiveField(2)
  final String location;
  @HiveField(3)
  final String chickenType;
  @HiveField(4)
  final DateTime startDate;
  @HiveField(5)
  final int batchSize;

  const FlockModel({
    required this.id,
    required this.farmerId,
    required this.location,
    required this.chickenType,
    required this.startDate,
    required this.batchSize,
  }) : super(
          id: id,
          farmerId: farmerId,
          location: location,
          chickenType: chickenType,
          startDate: startDate,
          batchSize: batchSize,
        );

  factory FlockModel.fromEntity(Flock entity) {
    return FlockModel(
      id: entity.id,
      farmerId: entity.farmerId,
      location: entity.location,
      chickenType: entity.chickenType,
      startDate: entity.startDate,
      batchSize: entity.batchSize,
    );
  }
}
