import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:management_flutter_application/main.dart';
import 'package:management_flutter_application/models/Project.dart';

import 'models/Task.dart';

class DetailPage extends StatefulWidget {
  final Project project;

  const DetailPage({super.key, required this.project});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  List<Task> tasks = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    apiCall();
  }

  Future<void> apiCall() async {
    setState(() {
      isLoading = true;
    });

    var response = await http.get(
      Uri.parse('https://jsonplaceholder.typicode.com/users/1/todos'),
    );

    if (response.statusCode == 200) {
      var jsonList = jsonDecode(response.body) as List;
      setState(() {
        tasks = jsonList.take(6).map((data) => Task.fromJson(data)).toList();
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
      });

      print('Erreur lors de la récupération des tâches');
    }
  }

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
              context.push('/edit', extra: ScreenArguments(widget.project));
            },
          ),
        ],
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.project.title,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text('Description : ' + widget.project.desc),
                  const SizedBox(height: 8),
                  Text('Statut : ' + widget.project.status),
                  const SizedBox(height: 8),
                  Text(
                    widget.project.dateTime != null
                        ? 'Date de début : ' +
                              DateFormat(
                                'dd/MM/yyyy',
                              ).format(widget.project.dateTime!)
                        : 'Date de début non renseignée',
                  ),
                  const SizedBox(height: 20),
                  Divider(),
                  Expanded(
                    child: ListView.builder(
                      itemCount: tasks.length,
                      itemBuilder: (context, index) {
                        final task = tasks[index];
                        return Card(
                          child: ListTile(
                            title: Text(
                              task.title,
                              style: TextStyle(
                                decoration: task.completed
                                    ? TextDecoration.lineThrough
                                    : TextDecoration.none,
                              ),
                            ),
                            subtitle: Text(
                              task.completed ? "Tâche complétée" : "Tâche à faire",
                            ),
                            leading: Icon(
                              task.completed ? Icons.check_circle : Icons.circle_outlined,
                              color: task.completed ? Colors.green : Colors.grey,
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: Icon(
                                    task.completed ? Icons.undo : Icons.check,
                                    color: task.completed ? Colors.orange : Colors.green,
                                  ),
                                  tooltip: task.completed ? "Restaurer" : "Clore",
                                  onPressed: () {
                                    setState(() {
                                      task.completed = !task.completed;
                                    });
                                  },
                                ),
                                IconButton(
                                  icon: Icon(Icons.delete, color: Colors.red),
                                  tooltip: "Supprimer",
                                  onPressed: () {
                                    setState(() {
                                      tasks.removeAt(index);
                                    });
                                  },
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),

                ],
              ),
            ),
    );
  }
}
