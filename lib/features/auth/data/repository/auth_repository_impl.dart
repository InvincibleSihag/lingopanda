import 'package:firebase_auth/firebase_auth.dart';
import 'package:fpdart/fpdart.dart';
import 'package:lingopanda/core/common/models/user.dart';
import 'package:lingopanda/core/error/failures.dart';
import 'package:lingopanda/features/auth/domain/repository/auth_repository.dart';
import 'package:lingopanda/features/auth/data/datasources/auth_local_datasource.dart';
import 'package:lingopanda/features/auth/data/datasources/auth_remote_datasource.dart';

class AuthRepositoryImpl implements AuthRepository {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final AuthRemoteDataSource _remoteDataSource;
  final AuthLocalDataSource _localDataSource;

  AuthRepositoryImpl(this._remoteDataSource, this._localDataSource);

  @override
  Future<Either<Failure, UserModel>> signIn(String email, String password) async {
    try {
      final userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      final userModel = UserModel(
          id: userCredential.user!.uid,
          email: email,
          name: userCredential.user!.displayName ?? "User");
      return Right(userModel);
    } on FirebaseAuthException catch (e) {
      return Left(Failure(e.message ?? "An error occurred"));
    }
  }

  @override
  UserModel? getCurrentUser() {
    final user = _auth.currentUser;
    if (user != null) {
      return UserModel(
          id: user.uid,
          email: user.email ?? "",
          name: user.displayName ?? "");
    }
    return null;
  }

  @override
  Future<void> signOut() async {
    await _auth.signOut();
  }

  @override
  Future<Either<Failure, UserModel>> signUp(String email, String name, String password) async {
    try {
      final userCredential = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      await userCredential.user!.updateDisplayName(name);
      final user = UserModel(id: userCredential.user!.uid, email: email, name: name);
      await _remoteDataSource.saveUser(user);
      await _localDataSource.saveUser(user);
      return Right(user);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }
}
