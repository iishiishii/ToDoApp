import '../resources/repository.dart';
import 'package:rxdart/rxdart.dart';
import 'package:todoapp/models/classes/user.dart';
import 'package:todoapp/models/classes/task.dart';

class UserBloc {
  final _repository = Repository();
  final _userGetter = PublishSubject<User>();

  Observable<User> get getUser => _userGetter.stream;

  registerUser(String username, String lastname, String firstname,
      String password, String email) async {
    User user = await _repository.registerUser(
        username, firstname, lastname, password, email);
    _userGetter.sink.add(user);
  }

  signinUser(String username, String password, String apiKey) async {
    User user = await _repository.signinUser(username, password, apiKey);
    _userGetter.sink.add(user);
  }

  dispose() {
    _userGetter.close();
  }
}

class TaskBloc {
  final _repository = Repository();
  final _taskSubject = BehaviorSubject<List<Task>>();
  String apiKey;

  var _tasks = <Task>[];

  TaskBloc(String apiKey) {
    this.apiKey = apiKey;
    _updateTask(apiKey).then((_) {
      _taskSubject.add(_tasks);
    });
  }

  Stream<List<Task>> get getTasks => _taskSubject.stream;

  Future<List<Task>> _updateTask(String apiKey) async {
    return await _repository.getUserTask(apiKey);
  }

  // dispose() {
  //   _taskSubject.close();
  // }
}

final userBloc = UserBloc();
