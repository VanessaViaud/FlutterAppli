import 'package:flutter/material.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({super.key});

  @override
  State<StatefulWidget> createState() => _DetailPageState();
  }

class _DetailPageState extends State<DetailPage> {

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        "Ceci est une page de détail d'un projet -- à compléter",
        style: TextStyle(fontSize: 20, color: Colors.indigo),
      ),
    );
  }
}
