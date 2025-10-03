import 'package:flutter/material.dart';
import 'package:management_flutter_application/models/EditForm.dart';
import 'package:management_flutter_application/models/Project.dart';
import 'package:management_flutter_application/providers/ProjectProvider.dart';
import 'package:provider/provider.dart';

class EditProjectPage extends StatelessWidget {
  final Project project;
  final void Function(Project) onUpdateProject;

  const EditProjectPage({Key? key, required this.project, required this.onUpdateProject}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Modifier le projet')),
      body: ProjectForm(
        initialProject: project,
        onSubmit: (updatedProject) {
          Provider.of<ProjectProvider>(context).updateProject(project);
        },
      ),
    );
  }
}
