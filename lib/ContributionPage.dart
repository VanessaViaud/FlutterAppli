import 'package:flutter/material.dart';

class ContributionPage extends StatefulWidget {
  const ContributionPage({super.key});

  @override
  State<ContributionPage> createState() => _ContributionPageState();
}

class _ContributionPageState extends State<ContributionPage> {

  void _onSubmit() {
    if (_key.currentState!.validate()) {
      print("validation ok");
    }
}
  final _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Form(
        key: _key,
        child: ListView(
          padding: EdgeInsets.all(30),
          children: [
            TextFormField(
              decoration: InputDecoration(
                labelText: 'nom',
                hintText: 'Veuillez saisir un nom de projet',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return "Champ obligatoire";
                }
                if(!RegExp(r'^[A-Za-z0-9]+$').hasMatch(value)){
                  return "Veuillez saisir un nom sans espace ni caractères spéciaux";
                }
                return null;
              },
            ),
            SizedBox(height: 20),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'description',
                hintText: 'Décrivez votre projet',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black54,
                foregroundColor: Colors.white,
              ),
              onPressed: _onSubmit,
              child: Text('Enregistrer'),
            ),
          ],
        ),
      ),
    );
  }
}
