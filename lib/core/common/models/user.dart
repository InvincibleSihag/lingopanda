import 'package:hive_flutter/hive_flutter.dart';

part 'user_model_adapter.g.dart';

@HiveType(typeId: 0)
class UserModel {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String email;
  @HiveField(2)
  final String name;

  UserModel({required this.id, required this.email, required this.name});

  Map<String, dynamic> toJson() => {
    'id': id,
    'email': email,
    'name': name,
  };
}
