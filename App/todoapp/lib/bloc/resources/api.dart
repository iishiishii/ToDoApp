import 'dart:async';
import 'package:http/http.dart' show Client;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todoapp/models/classes/task.dart';
import 'dart:convert';
import 'package:todoapp/models/classes/user.dart';

class ApiProvider {
  Client client = Client();
  final _apiKey = 'your_api_key';

  Future<User> registerUser(String username, String lastname, String firstname,
      String password, String email) async {
    print("entered");
    final response = await client.post("http://10.0.2.2:5000/api/register",
        body: jsonEncode({
          "email": email,
          "username": username,
          "password": password,
          "firstname": firstname,
          "lastname": lastname
        }));

    final Map result = json.decode(response.body);
    if (response.statusCode == 201) {
      // If the call to the server was successful, parse the JSON
      await saveApiKey(result["data"]["api_key"]);
      return User.fromJson(result["data"]);
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load post');
    }
  }

  Future signinUser(String username, String password, String apiKey) async {
    print("entered0");
    final response = await client.post("http://10.0.2.2:5000/api/signin",
        headers: {'Authorization': apiKey},
        body: jsonEncode({
          "username": username,
          "password": password,
        }));

    final Map result = json.decode(response.body);
    if (response.statusCode == 201) {
      // If the call to the server was successful, parse the JSON
      await saveApiKey(result["data"]["api_key"]);
      //return User.fromJson(result['data']);
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load post');
    }
  }

  Future<List<Task>> getUserTask(String apiKey) async {
    print("entered1");
    final response = await client.get(
      "http://10.0.2.2:5000/api/tasks",
      headers: {'Authorization': apiKey},
    );
    print("entered2");
    final Map result = json.decode(response.body);
    if (response.statusCode == 201) {
      // If the call to the server was successful, parse the JSON
      //await saveApiKey(result["data"]["api_key"]);
      List<Task> task = [];
      for (Map json_ in result['data']) {
        try {
          task.add(Task.fromJson(json_));
        } catch (Exception) {
          print(Exception);
        }
      }
      for (Task _task in task) {
        print(_task.taskId);
      }
      return task;
      //return User.fromJson(result['data']);
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load tasks');
    }
  }

  saveApiKey(String api_key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('API_Token', api_key);
  }
}
