import 'package:hive_flutter/hive_flutter.dart';
import 'package:lingopanda/core/common/models/user.dart';
import 'package:lingopanda/core/constants/constants.dart';

abstract class AuthLocalDataSource {
  Future<void> saveUser(UserModel user);
  Future<UserModel> getUser();
  Future<void> deleteUser();
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final Box<UserModel> userBox = Hive.box<UserModel>(HiveConstants.userBox);

  @override
  Future<void> saveUser(UserModel user) async {
    await userBox.put('user', user);
  }

  @override
  Future<void> deleteUser() async {
    await userBox.delete('user');
  }

  @override
  Future<UserModel> getUser() async {
    return userBox.get('user')!;
  }
}
