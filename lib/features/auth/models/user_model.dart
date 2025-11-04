import 'package:hive/hive.dart';
import 'package:lea_kuku/features/auth/domain/user_entity.dart';

part 'user_model.g.dart'; // Generated file by hive_generator

@HiveType(typeId: 0)
class UserModel extends User {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final String email;
  @HiveField(3)
  final String role; // 'Farmer' or 'Admin'

  const UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
  }) : super(id: id, name: name, email: email, role: role);

  factory UserModel.fromEntity(User entity) {
    return UserModel(
      id: entity.id,
      name: entity.name,
      email: entity.email,
      role: entity.role,
    );
  }
}
