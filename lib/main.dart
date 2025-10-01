import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'DetailPage.dart';
import 'ContributionPage.dart';
import 'models/Project.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo.shade400),
        scaffoldBackgroundColor: Colors.grey.shade300,
        appBarTheme: AppBarTheme(
          foregroundColor: Colors.white,
          backgroundColor: Colors.indigo.shade700,
          shadowColor: Colors.black,
          elevation: 5,
        ),
      ),
      home: const MyHomePage(title: 'Mes projets'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Project> projects = [
    Project('Projet Un', "C'est un premier projet", "en Cours", DateTime.now()),
    Project(
      'Projet Deux',
      "C'est un second projet",
      "en Cours",
      DateTime.now(),
    ),
    Project(
      'Projet Trois',
      "C'est un troisième projet",
      "en Cours",
      DateTime.now(),
    ),
  ];

  int _selectedIndex = 0;
  late int projectNumber = projects.length + 1;

  void _incrementProjects() {
    setState(() {
      projectNumber++;
      projects.add(
        Project(
          'New Project',
          'Project au clic n° $projectNumber',
          "A venir",
          DateTime.now(),
        ),
      );
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(FontAwesomeIcons.rocket, color: Colors.white),
        title: _selectedIndex == 0 ? Text(widget.title) : Text("Contribuer"),
        centerTitle: true,
      ),
      body: _selectedIndex == 0
          ? Column(
              children: <Widget>[
                Expanded(
                  child: ListView.builder(
                    // shrinkWrap: true,
                    padding: EdgeInsets.all(15),
                    itemCount: projects.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        clipBehavior: Clip.antiAlias,
                        elevation: 4,
                        margin: EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        child: Container(
                          decoration: BoxDecoration(color: Colors.black87),
                          child: ListTile(
                            leading: Icon(
                              Icons.folder_outlined,
                              color: Colors.indigo,
                            ),
                            title: Text(
                              projects[index].title,
                              style: TextStyle(color: Colors.white),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  projects[index].desc,
                                  style: TextStyle(color: Colors.white70),
                                ),
                                Text(
                                  projects[index].dateTime != null
                                      ? DateFormat(
                                          'dd/MM/yyyy',
                                        ).format(projects[index].dateTime!)
                                      : 'Date non renseignée',
                                  style: TextStyle(color: Colors.white70),
                                ),
                                Text(
                                  projects[index].status,
                                  style: TextStyle(color: Colors.white70),
                                ),
                              ],
                            ),
                            // trailing: IconButton(
                            //   onPressed: DetailPageState(),
                            //   icon: Icon(
                            //     Icons.arrow_forward_ios,
                            //     color: Colors.white54,
                            //   ),
                            trailing: Icon(
                              Icons.arrow_forward_ios,
                              color: Colors.white54,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            )
          : ContributionPage(
              projects: projects,
              onAddProject: (Project project) {
                setState(() {
                  projects.add(project);
                  _selectedIndex = 0;
                });
              },
            ),

      floatingActionButton: FloatingActionButton(
        onPressed: _incrementProjects,
        tooltip: 'Increment',
        backgroundColor: Colors.indigo,
        child: const Icon(Icons.add, color: Colors.white),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black87,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey.shade600,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.folder_copy_outlined),
            label: 'Projets',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_circle_outline),
            label: 'Contribuer',
          ),
        ],
      ),
    );
  }
}
