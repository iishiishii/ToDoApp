import 'dart:async';
import 'api.dart';
import 'package:todoapp/models/classes/user.dart';

class Repository {
  final moviesApiProvider = ApiProvider();

  Future<User> registerUser(String username, String lastname, String firstname,
          String password, String email) =>
      moviesApiProvider.registerUser(
          username, firstname, lastname, password, email);

  Future<User> signinUser(String username, String password) =>
      moviesApiProvider.signinUser(username, password);
}
