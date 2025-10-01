import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'ContributionPage.dart';
import 'models/Project.dart';

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
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        scaffoldBackgroundColor: Colors.grey.shade400,
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
    Project('Projet Un', "C'est un premier projet"),
    Project('Projet Deux', "C'est un second projet"),
    Project('Projet Trois', "C'est un troisième projet"),
    Project('Projet Quatre', "C'est un quatrième projet"),
    Project('Projet Cinq', "C'est un cinquième projet"),
    Project('Projet Six', "C'est un sixième projet"),
  ];

  int _selectedIndex = 0;
  late int projectNumber = projects.length + 1;

  void _incrementProjects() {
    var P = Project('New Project', 'Project au clic n° $projectNumber');
    setState(() {
      projectNumber++;
      projects.add(P);
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
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: _selectedIndex == 0
          ? Column(
              children: <Widget>[
                ListView.builder(
                  shrinkWrap: true,
                  padding: EdgeInsets.all(15),
                  itemCount: projects.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      clipBehavior: Clip.antiAlias,
                      elevation: 4,
                      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
                          subtitle: Text(
                            projects[index].desc,
                            style: TextStyle(color: Colors.white70),
                          ),

                          trailing: Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.white54,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            )
          : const ContributionPage(),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementProjects,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
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
