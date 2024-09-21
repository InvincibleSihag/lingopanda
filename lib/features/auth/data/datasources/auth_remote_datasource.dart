import 'package:firebase_cloud_firestore/firebase_cloud_firestore.dart';
import 'package:lingopanda/core/common/models/user.dart';

abstract class AuthRemoteDataSource {
  Future<UserModel> saveUser(UserModel user);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Future<UserModel> saveUser(UserModel user) async {
    await _firestore.collection('users').doc(user.id).set(user.toJson());
    return user;
  }
}

