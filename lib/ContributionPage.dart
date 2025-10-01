import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

import 'models/Project.dart';

class ContributionPage extends StatefulWidget {
  final List<Project> projects;
  final void Function(Project) onAddProject;

  const ContributionPage({
    super.key,
    required this.projects,
    required this.onAddProject,
  });

  @override
  State<ContributionPage> createState() => _ContributionPageState();
}

enum Status { enCours, aVenir, termine }

class _ContributionPageState extends State<ContributionPage> {
  final _key = GlobalKey<FormState>();

  var _nom = TextEditingController();
  var _description = TextEditingController();
  Status? _dropDownValue;
  DateTime? selectedDate;

  late TextEditingController _dateController;

  @override
  void initState() {
    super.initState();
    _dateController = TextEditingController();
  }

  @override
  void dispose() {
    _dateController.dispose();
    _nom.dispose();
    _description.dispose();
    super.dispose();
  }

  void _onSubmit() {
    if (_key.currentState!.validate()) {
      _key.currentState!.save();
      Project newProject = Project(
        _nom.text,
        _description.text,
        _dropDownValue != null ? _dropDownValue.toString().split('.').last : "en Cours",
        selectedDate,
      );
      widget.onAddProject(newProject);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Form(
        key: _key,
        child: ListView(
          padding: EdgeInsets.all(30),
          children: [
            TextFormField(
              controller: _nom,
              decoration: InputDecoration(
                labelText: 'nom',
                hintText: 'Veuillez saisir un nom de projet',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Champ obligatoire";
                }
                if (!RegExp(r'^[A-Za-z0-9]+$').hasMatch(value)) {
                  return "Veuillez saisir un nom sans espace ni caractères spéciaux";
                }
                return null;
              },
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: _description,
              decoration: InputDecoration(
                labelText: 'description',
                hintText: 'Décrivez votre projet',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.multiline,
              minLines: 4,
              maxLines: 8,
            ),
            SizedBox(height: 20),

            DropdownButton(
              underline: Container(height: 1, color: Colors.black54),
              value: _dropDownValue,
              items: const [
                DropdownMenuItem(
                  value: Status.enCours,
                  child: Text('    en cours'),
                ),
                DropdownMenuItem(
                  value: Status.aVenir,
                  child: Text('    à venir'),
                ),
                DropdownMenuItem(
                  value: Status.termine,
                  child: Text('    terminé'),
                ),
              ],
              onChanged: (value) {
                setState(() {
                  print(_dropDownValue);
                  _dropDownValue = value;
                });
              },
            ),
            SizedBox(height: 20),
            TextFormField(
              readOnly: true,
              decoration: InputDecoration(
                labelText: 'Date de début',
                suffixIcon: Icon(Icons.calendar_today),
              ),
              controller: _dateController,
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: selectedDate ?? DateTime.now(),
                  firstDate: DateTime.now(),
                  lastDate: DateTime(2030, 12, 31),
                );
                if (pickedDate != null) {
                  setState(() {
                    selectedDate = pickedDate;
                    _dateController.text = DateFormat('dd/MM/yyyy').format(pickedDate);
                  });
                }
              },
            ),

            SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.indigo.shade400,
                foregroundColor: Colors.white,
              ),
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    action: SnackBarAction(
                      label: "Confirmer",
                      onPressed: _onSubmit,
                    ),
                    content: Text('Vous êtes sûr ?'),
                    padding: EdgeInsets.all(10),
                    behavior: SnackBarBehavior.floating,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                );
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(FontAwesomeIcons.paperPlane),
                  SizedBox(width: 20),
                  Text('Enregistrer'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
