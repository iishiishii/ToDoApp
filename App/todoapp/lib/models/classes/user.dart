import 'package:flutter/rendering.dart';

class User {
  String username;
  String lastname;
  String firstname;
  String email;
  String password;
  int id;
  String api_key;

  User(this.username, this.lastname, this.firstname, this.email, this.api_key,
      this.id, this.password);

  factory User.fromJson(Map<String, dynamic> parsedJson) {
    return User(
        parsedJson['username'],
        parsedJson['lastname'],
        parsedJson['firstname'],
        parsedJson['email'],
        parsedJson['password'],
        parsedJson['id'],
        parsedJson['api_key']);
  }
}
