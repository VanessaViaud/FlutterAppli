import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

class ContributionPage extends StatefulWidget {
  const ContributionPage({super.key});

  @override
  State<ContributionPage> createState() => _ContributionPageState();
}

enum Status { enCours, aVenir, termine }

class _ContributionPageState extends State<ContributionPage> {
  final _key = GlobalKey<FormState>();

  String? _nom;
  Status? _dropDownValue;
  DateTime? selectedDate;

  void _onSubmit() {
    if (_key.currentState!.validate()) {
      _key.currentState!.save();
      print("Validation ok, nom : $_nom");
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
              onSaved: (value) {
                _nom = value;
              },
            ),
            SizedBox(height: 20),
            TextFormField(
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
                DropdownMenuItem(value: Status.enCours, child: Text('    en cours')),
                DropdownMenuItem(value: Status.aVenir, child: Text('    à venir')),
                DropdownMenuItem(value: Status.termine, child: Text('    terminé')),
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
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: selectedDate ?? DateTime.now(),
                  firstDate: DateTime.now(),
                  lastDate: DateTime(2030, 12, 31),
                  initialEntryMode: DatePickerEntryMode.calendar,
                );
                if (pickedDate != null) {
                  setState(() {
                    selectedDate = pickedDate;
                  });
                }
              },
              controller: TextEditingController(
                text: selectedDate != null
                    ? DateFormat('dd/MM/yyyy').format(selectedDate!)
                    : '',
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.indigo.shade400,
                foregroundColor: Colors.white,
              ),
              onPressed: _onSubmit,
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
