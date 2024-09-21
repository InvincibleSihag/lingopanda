import 'package:fpdart/fpdart.dart';
import 'package:lingopanda/core/common/models/user.dart';
import 'package:lingopanda/core/error/failures.dart';

abstract class AuthRepository {
  Future<Either<Failure, UserModel>> signIn(String email, String password);
  Future<Either<Failure, UserModel>> signUp(
      String name, String email, String password);
  Future<void> signOut();
  UserModel? getCurrentUser();
}
