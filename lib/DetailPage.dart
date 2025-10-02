import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:management_flutter_application/main.dart';
import 'package:management_flutter_application/models/Project.dart';

class DetailPage extends StatelessWidget {
  final Project project;

  const DetailPage({super.key, required this.project});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Détails'),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.mode_edit_outlined, color: Colors.white),
            onPressed: () {
              context.push('/edit', extra: ScreenArguments(project));
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(project.title),
            Text('Description : ' + project.desc),
            Text('Statut : ' + project.status),
            Text(
              project.dateTime != null
                  ? 'Date de début : ' + DateFormat('dd/MM/yyyy').format(project.dateTime!)
                  : 'Date de début non renseignée',
            ),
          ],
        ),
      ),
    );
  }
}
