import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';
import 'package:lingopanda/core/error/failures.dart';

import 'package:lingopanda/features/auth/domain/repository/auth_repository.dart';
import '../../../../core/common/models/user.dart';

class LoginProvider with ChangeNotifier {
  final AuthRepository _authRepository;

  LoginProvider(this._authRepository);

  Future<Either<Failure, UserModel>> signIn(String email, String password) async {
    return await _authRepository.signIn(email, password);
  }

  UserModel? getCurrentUser() {
    return _authRepository.getCurrentUser();
  }

  Future<void> signOut() async {
    await _authRepository.signOut();
  }

}
