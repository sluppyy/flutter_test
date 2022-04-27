import 'dart:convert';

import 'package:http/http.dart';
import 'package:startup_namer/new/data/User.dart';

import '../../legacy/AuthPage.dart';
import '../data/GlobalVariables.dart';

class ProfileRepository {
  Future<User?> logIn({required String username, required String password}) async {
    final response = await post(
        Uri.parse("$server/api/auth/local"),
        headers: headers,
        body: jsonEncode({
          "identifier": username,
          "password": password
        })
    );

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      final user = User.fromJson(json["user"], jwt: json["jwt"]);
      return user;
    }
    return null;
  }

  Future<User?> signUp({required String username, required String email, required String password}) async {
    final response = await post(
        Uri.parse("$server/api/auth/local/register"),
        headers: headers,
        body: jsonEncode({
          "email": email,
          "username": username,
          "password": password
        })
    );

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      final user = User.fromJson(json["user"], jwt: json["jwt"]);
      return user;
    }
    return null;
  }

  Future<bool> save(User user) async {
    final response = await put(
        Uri.parse("$server/api/users/${user.id}"),
        headers: {
          "Authorization": "Bearer ${user.bearer}"
        },
        body: {
          "username": user.name,
          "email": user.email,
          "phone": user.phoneNumber,
          "about": user.about
        }
    );

    return response.statusCode == 200;
  }

  Future<User?> getUser({required String bearer}) async {
    final response = await get(
        Uri.parse("$server/api/users/me"),
        headers: {
          "Authorization": "Bearer $bearer"
        }
    );

    if (response.statusCode != 200) return null;

    final json = jsonDecode(response.body);
    return User.fromJson(json, jwt: bearer);
  }
}