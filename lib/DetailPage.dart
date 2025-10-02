import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'models/Project.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
            tooltip: 'Show Snackbar',
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('This is a snackbar')),
              );
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
                  ? 'Date de début : ' +
                        DateFormat('dd/MM/yyyy').format(project.dateTime!)
                  : 'Date de début non renseignée',
            ),
          ],
        ),
      ),
    );
  }
}
