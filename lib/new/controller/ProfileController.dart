
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:startup_namer/new/data/AuthProblem.dart';
import 'package:startup_namer/new/data/User.dart';
import 'package:startup_namer/new/repository/ProfileRepository.dart';


class ProfileController extends ValueNotifier<User?> {
  final ProfileRepository _repository;
  final ValueNotifier<AuthProblem?> authProblems = ValueNotifier(null);

  ProfileController(User? value, this._repository) : super(value);

  User? get user => value;

  void updateUser() async {
    if (super.value != null) {
      super.value = await _repository.getUser(bearer: super.value!.bearer);
      authProblems.value = null;
    } else {
      authProblems.value = AuthProblem.needAuth; //TODO("set needAuth problem in any case")
      if (authProblems.value == AuthProblem.needAuth) {
        authProblems.notifyListeners();
      }
    }
  }

  void saveUser(User user) async {
    if (await _repository.save(user)) {
      updateUser();
    }
  }

  void signUp({
    required String email,
    required String password,
    required String username
  }) async {
    super.value = await _repository.signUp(
        username: username,
        email: email,
        password: password);

    authProblems.value = value == null
        ? AuthProblem.needAuth
        : null; //TODO("set needAuth problem in any case")
  }

  void logIn({required String username, required String password}) async {
    super.value = await _repository.logIn(
        username: username,
        password: password);

    authProblems.value = value == null
        ? AuthProblem.needAuth
        : null; //TODO("set needAuth problem in any case")
  }
}