
import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';
import 'package:lingopanda/core/common/models/user.dart';
import 'package:lingopanda/core/error/failures.dart';
import 'package:lingopanda/features/auth/domain/repository/auth_repository.dart';

class SignupProvider with ChangeNotifier {
  bool isLoading = false;
  final AuthRepository _authRepository;

  SignupProvider(this._authRepository);

    Future<Either<Failure, UserModel>> signUp(String email, String name, String password) async {
    setLoading(true);
    return await _authRepository.signUp(email, name, password);
  }

  setLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }
}
