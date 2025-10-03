import 'package:flutter/material.dart';
import 'package:management_flutter_application/models/Project.dart';

import 'models/EditForm.dart';

class ContributionPage extends StatefulWidget {
  final List<Project> projects;
  final void Function(Project) onAddProject;

  const ContributionPage({Key? key, required this.projects, required this.onAddProject}) : super(key: key);

  @override
  State<ContributionPage> createState() => _ContributionPageState();
}

class _ContributionPageState extends State<ContributionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Contribuer')),
      body: ProjectForm(
        onSubmit: (project) {
          widget.onAddProject(project);
          Navigator.pop(context);
        },
      ),
    );
  }
}
