//faire une classe avec 2 attributs privés title et desc donc faire des getters et setter

import 'package:management_flutter_application/main.dart';
import 'package:management_flutter_application/models/Task.dart';

class Project {
  String _title;
  String _desc;
  DateTime? _dateTime;
  String _status;
  List<Task> _tasks = [];

  Project(this._title, this._desc,  this._status, this._tasks, [this._dateTime]);

  String get title => _title;

  String get desc => _desc;

  DateTime? get dateTime => _dateTime;

  String get status => _status;

  set title(String value) => _title = value;

  set desc(String value) => _desc = value;

  set dateTime(DateTime value) => _dateTime = value;

  set status(String value) => _status = value;

  List<Task> get tasks => _tasks;

  set tasks(List<Task> value) {
    _tasks = value;
  }
}
