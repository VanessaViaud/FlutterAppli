import 'package:flutter/foundation.dart';
import 'package:management_flutter_application/models/Project.dart';
import 'package:provider/provider.dart';

class ProjectProvider extends ChangeNotifier {
  List<Project> projects = [
    Project(
        'Projet Un', "C'est un premier projet", "en Cours", [], DateTime.now()),
    Project(
      'Projet Deux',
      "C'est un second projet",
      "en Cours",
      [],
      DateTime.now(),
    ),
    Project(
      'Projet Trois',
      "C'est un troisième projet",
      "en Cours",
      [],
      DateTime.now(),
    ),
  ];

  List<Project> get projects => _projects;

  void addProject(Project project) {
    _projects.add(project);
    notifyListeners();
  }

  void updateProject(Project project) {
    final index = _projects.indexWhere((p) => p.key == project.key);
  }
}