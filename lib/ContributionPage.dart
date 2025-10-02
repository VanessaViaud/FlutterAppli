import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

import 'models/EditForm.dart';
import 'models/Project.dart';

class ContributionPage extends StatefulWidget {
  final List<Project> projects;
  final void Function(Project) onAddProject;

  const ContributionPage({
    super.key,
    required this.projects,
    required this.onAddProject,
  });

  @override
  State<ContributionPage> createState() => _ContributionPageState();
}

enum Status { enCours, aVenir, termine }

class _ContributionPageState extends State<ContributionPage> {
  final _key = GlobalKey<FormState>();

  var _nom = TextEditingController();
  var _description = TextEditingController();
  Status? _dropDownValue;
  DateTime? selectedDate;

  late TextEditingController _dateController;

  @override
  void initState() {
    super.initState();
    _dateController = TextEditingController();
  }

  @override
  void dispose() {
    _dateController.dispose();
    _nom.dispose();
    _description.dispose();
    super.dispose();
  }

  void _onSubmit() {
    if (_key.currentState!.validate()) {
      _key.currentState!.save();
      Project newProject = Project(
        _nom.text,
        _description.text,
        _dropDownValue != null ? _dropDownValue.toString().split('.').last : "en Cours",
        selectedDate,
      );
      widget.onAddProject(newProject);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ProjectForm(onSubmit: (Project p1) {  },);
  }
}
