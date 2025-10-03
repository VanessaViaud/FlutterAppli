import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'Project.dart';

enum Status { enCours, aVenir, termine }

class ProjectForm extends StatefulWidget {
  final Project? initialProject;
  final void Function(Project) onSubmit;

  const ProjectForm({
    Key? key,
    this.initialProject,
    required this.onSubmit,
  }) : super(key: key);

  @override
  State<ProjectForm> createState() => _ProjectFormState();
}

class _ProjectFormState extends State<ProjectForm> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _nomController;
  late TextEditingController _descriptionController;
  Status? _status;
  DateTime? _selectedDate;
  late TextEditingController _dateController;

  @override
  void initState() {
    super.initState();
    _nomController = TextEditingController(text: widget.initialProject?.title ?? '');
    _descriptionController = TextEditingController(text: widget.initialProject?.desc ?? '');
    _dateController = TextEditingController(
      text: widget.initialProject?.dateTime != null
          ? DateFormat('dd/MM/yyyy').format(widget.initialProject!.dateTime!)
          : '',
    );

    if (widget.initialProject != null) {
      switch (widget.initialProject!.status) {
        case 'enCours':
          _status = Status.enCours;
          break;
        case 'aVenir':
          _status = Status.aVenir;
          break;
        case 'termine':
          _status = Status.termine;
          break;
        default:
          _status = Status.enCours;
      }
      _selectedDate = widget.initialProject!.dateTime;
    } else {
      _status = null;
      _selectedDate = null;
    }
  }

  @override
  void dispose() {
    _nomController.dispose();
    _descriptionController.dispose();
    _dateController.dispose();
    super.dispose();
  }

  void _handleSubmit() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      final newProject = Project(
        _nomController.text,
        _descriptionController.text,
        _status != null ? _status.toString().split('.').last : 'enCours',
        [],
        _selectedDate,
      );
      widget.onSubmit(newProject);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: ListView(
        padding: const EdgeInsets.all(30),
        shrinkWrap: true,
        children: [
          TextFormField(
            controller: _nomController,
            decoration: const InputDecoration(
              labelText: 'Nom',
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
          const SizedBox(height: 20),
          TextFormField(
            controller: _descriptionController,
            decoration: const InputDecoration(
              labelText: 'Description',
              hintText: 'Décrivez votre projet',
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.multiline,
            minLines: 4,
            maxLines: 8,
          ),
          const SizedBox(height: 20),
          DropdownButton<Status>(
            underline: Container(height: 1, color: Colors.black54),
            value: _status,
            items: const [
              DropdownMenuItem(
                value: Status.enCours,
                child: Text('En cours'),
              ),
              DropdownMenuItem(
                value: Status.aVenir,
                child: Text('À venir'),
              ),
              DropdownMenuItem(
                value: Status.termine,
                child: Text('Terminé'),
              ),
            ],
            onChanged: (value) {
              setState(() {
                _status = value;
              });
            },
          ),
          const SizedBox(height: 20),
          TextFormField(
            readOnly: true,
            controller: _dateController,
            decoration: const InputDecoration(
              labelText: 'Date de début',
              suffixIcon: Icon(Icons.calendar_today),
            ),
            onTap: () async {
              DateTime initialDate = _selectedDate ?? DateTime.now();
              DateTime? pickedDate = await showDatePicker(
                context: context,
                initialDate: initialDate,
                firstDate: DateTime.now(),
                lastDate: DateTime(2030, 12, 31),
              );
              if (pickedDate != null) {
                setState(() {
                  _selectedDate = pickedDate;
                  _dateController.text = DateFormat('dd/MM/yyyy').format(pickedDate);
                });
              }
            },
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text('Vous êtes sûr ?'),
                  action: SnackBarAction(
                    label: 'Confirmer',
                    onPressed: _handleSubmit,
                  ),
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.indigo.shade400,
              foregroundColor: Colors.white,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(Icons.send),
                SizedBox(width: 20),
                Text('Enregistrer'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
