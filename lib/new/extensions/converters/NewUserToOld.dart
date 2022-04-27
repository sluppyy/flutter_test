import 'package:startup_namer/legacy/User.dart' as legacy;
import 'package:startup_namer/new/controller/ProfileController.dart';
import 'package:startup_namer/new/data/User.dart';

extension NewToOld on User {
  legacy.User toUser() => legacy.User(
    email: email,
    name: name,
    phoneNumber: phoneNumber,
    id: id,
    bearer: bearer,
    about: about,
    profileSrc: profileSrc
  );
}

extension OldToNew on legacy.User {
  User toUser() => User(
      email: email,
      name: name,
      phoneNumber: phoneNumber,
      id: id,
      bearer: bearer,
      about: about,
      profileSrc: profileSrc
  );
}

extension SaveOldAsNew on ProfileController {
  void saveOldUser(legacy.User legacyUser) => saveUser(legacyUser.toUser());
}