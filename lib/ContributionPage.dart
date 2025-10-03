import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:management_flutter_application/models/Project.dart';
import 'package:management_flutter_application/providers/ProjectProvider.dart';
import 'package:provider/provider.dart';

import 'models/EditForm.dart';

class ContributionPage extends StatefulWidget {
  final List<Project> projects;

  const ContributionPage({Key? key, required this.projects}) : super(key: key);

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
          Provider.of<ProjectProvider>(context, listen: false).addProject(project);
          context.pop();
        },
      ),
    );
  }
}
