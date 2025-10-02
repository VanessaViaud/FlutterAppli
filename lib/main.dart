import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:management_flutter_application/EditPage.dart';
import 'package:management_flutter_application/models/EditForm.dart';
import 'DetailPage.dart';
import 'ContributionPage.dart';
import 'models/Project.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(const MyApp());
}

class ScreenArguments {
  final Project project;

  ScreenArguments(this.project);
}

final GoRouter _router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const MyHomePage(),
    ),
    GoRoute(
      path: '/details',
      builder: (context, state) {
        final args = state.extra as ScreenArguments;
        return DetailPage(project: args.project);
      },
    ),
    GoRoute(
      path: '/edit',
      builder: (context, state) {
        final args = state.extra as ScreenArguments;
        return EditProjectPage(
          project: args.project,
          onUpdateProject: (updatedProject) {
            Navigator.of(context).pop(updatedProject);
          },
        );
      },
    ),
    GoRoute(
      path: '/add',
      builder: (context, state) {
        return ContributionPage(
          projects: [],
          onAddProject: (Project p1) {
            Navigator.of(context).pop(p1);
          },
        );
      },
    ),
  ],
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
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
      routerConfig: _router,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Project> projects = [
    Project('Projet Un', "C'est un premier projet", "en Cours", DateTime.now()),
    Project('Projet Deux', "C'est un second projet", "en Cours", DateTime.now()),
    Project('Projet Trois', "C'est un troisième projet", "en Cours", DateTime.now()),
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

  Future<void> _editProject(Project project, int index) async {
    final updatedProject = await context.push<Project>(
      '/edit',
      extra: ScreenArguments(project),
    );

    if (updatedProject != null) {
      setState(() {
        projects[index] = updatedProject;
      });
    }
  }

  Future<void> _addProject() async {
    final newProject = await context.push<Project>('/add');
    if (newProject != null) {
      setState(() {
        projects.add(newProject);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(FontAwesomeIcons.rocket, color: Colors.white),
        title: _selectedIndex == 0 ? const Text('Projets') : const Text("Contribuer"),
        centerTitle: true,
      ),
      body: _selectedIndex == 0
          ? ListView.builder(
        padding: const EdgeInsets.all(15),
        itemCount: projects.length,
        itemBuilder: (BuildContext context, int index) {
          final project = projects[index];
          return Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            clipBehavior: Clip.antiAlias,
            elevation: 4,
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Container(
              decoration: BoxDecoration(color: Colors.black87),
              child: ListTile(
                leading: const Icon(Icons.folder_outlined, color: Colors.indigo),
                title: Text(project.title, style: const TextStyle(color: Colors.white)),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(project.desc, style: const TextStyle(color: Colors.white70)),
                    Text(
                      project.dateTime != null
                          ? DateFormat('dd/MM/yyyy').format(project.dateTime!)
                          : 'Date non renseignée',
                      style: const TextStyle(color: Colors.white70),
                    ),
                    Text(project.status, style: const TextStyle(color: Colors.white70)),
                  ],
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      onPressed: () => _editProject(project, index),
                      icon: const Icon(Icons.edit, color: Colors.white54),
                    ),
                    IconButton(
                      onPressed: () {
                        context.push(
                          '/details',
                          extra: ScreenArguments(project),
                        );
                      },
                      icon: const Icon(Icons.arrow_forward_ios, color: Colors.white54),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      )
          : ContributionPage(
        projects: projects,
        onAddProject: (newProject) {
          setState(() {
            projects.add(newProject);
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
