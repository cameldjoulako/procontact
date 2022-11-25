import 'package:procontact/model/Contact.dart';
import 'package:procontact/services/contactService.dart';
import 'package:flutter/material.dart';

class EditContact extends StatefulWidget {
  final Contact contact;
  const EditContact({Key? key, required this.contact}) : super(key: key);

  @override
  State<EditContact> createState() => _EditContactState();
}

class _EditContactState extends State<EditContact> {
  var _contactNameController = TextEditingController();
  var _contactPhoneController = TextEditingController();
  var _contactEmailController = TextEditingController();
  bool _validateName = false;
  bool _validateContact = false;
  bool _validateDescription = false;
  var _contactService = ContactService();

  @override
  void initState() {
    setState(() {
      _contactNameController.text = widget.contact.name ?? '';
      _contactPhoneController.text = widget.contact.phone ?? '';
      _contactEmailController.text = widget.contact.email ?? '';
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("ProContact"),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Modifier contact',
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.teal,
                    fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 20.0,
              ),
              TextField(
                controller: _contactNameController,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  hintText: 'Entrer le nom',
                  labelText: 'Nom',
                  errorText: _validateName
                      ? 'Le champ nom ne doit pas être vide'
                      : null,
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              TextField(
                controller: _contactPhoneController,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  hintText: 'Enter le numéro de téléphone ',
                  labelText: 'Télephone',
                  errorText: _validateContact ? 'Télephone obligatoire' : null,
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              TextField(
                controller: _contactEmailController,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  hintText: 'Entrer adresse email',
                  labelText: 'E-mail',
                  errorText: _validateDescription ? 'Email obligatoire' : null,
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              Row(
                children: [
                  TextButton(
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.blue,
                      textStyle: const TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                      ),
                    ),
                    onPressed: () async {
                      setState(() {
                        _contactNameController.text.isEmpty
                            ? _validateName = true
                            : _validateName = false;
                        _contactPhoneController.text.isEmpty
                            ? _validateContact = true
                            : _validateContact = false;
                        _contactEmailController.text.isEmpty
                            ? _validateDescription = true
                            : _validateDescription = false;
                      });
                      if (_validateName == false &&
                          _validateContact == false &&
                          _validateDescription == false) {
                        // print("Good Data Can Save");
                        var _contact = Contact();
                        _contact.id = widget.contact.id;
                        _contact.name = _contactNameController.text;
                        _contact.phone = _contactPhoneController.text;
                        _contact.email = _contactEmailController.text;
                        var result =
                            await _contactService.UpdateContact(_contact);
                        Navigator.pop(context, result);
                      }
                    },
                    child: const Text('Enregistrer'),
                  ),
                  const SizedBox(
                    width: 10.0,
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.red,
                      textStyle: const TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                      ),
                    ),
                    onPressed: () {
                      _contactNameController.text = '';
                      _contactPhoneController.text = '';
                      _contactEmailController.text = '';
                    },
                    child: const Text('Effacer'),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
