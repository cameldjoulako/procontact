// ignore_for_file: file_names

import 'package:procontact/model/Contact.dart';
import 'package:procontact/services/contactService.dart';
import 'package:flutter/material.dart';

class AddContact extends StatefulWidget {
  const AddContact({Key? key}) : super(key: key);

  @override
  State<AddContact> createState() => _AddContactState();
}

class _AddContactState extends State<AddContact> {
  final _contactNameController = TextEditingController();
  final _contactPhoneController = TextEditingController();
  final _contactEmailController = TextEditingController();
  bool _validateName = false;
  bool _validatePhone = false;
  bool _validateEmail = false;
  final _contactService = ContactService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("ProContact"),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Center(
                child: Text(
                  'Ajouter un contact',
                  style: TextStyle(
                      fontSize: 23,
                      color: Colors.black,
                      fontWeight: FontWeight.w500),
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              TextField(
                controller: _contactNameController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  hintText: 'Entrer le nom',
                  labelText: 'Nom',
                  prefixIcon: const Icon(Icons.person_sharp),
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
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  hintText: 'Entrer le numéro',
                  labelText: 'Téléphone',
                  prefixIcon: const Icon(Icons.phone),
                  errorText: _validatePhone
                      ? 'Le champ Téléphone ne doit pas être vide'
                      : null,
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              TextField(
                controller: _contactEmailController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  hintText: 'Entrer adresse Email',
                  labelText: 'Email',
                  prefixIcon: const Icon(Icons.mail),
                  errorText: _validateEmail
                      ? 'Le champ Email ne doit pas être vide'
                      : null,
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TextButton(
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.blue,
                      textStyle: const TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                    onPressed: () async {
                      setState(() {
                        _contactNameController.text.isEmpty
                            ? _validateName = true
                            : _validateName = false;
                        _contactPhoneController.text.isEmpty
                            ? _validatePhone = true
                            : _validatePhone = false;
                        _contactEmailController.text.isEmpty
                            ? _validateEmail = true
                            : _validateEmail = false;
                      });
                      if (_validateName == false &&
                          _validatePhone == false &&
                          _validateEmail == false) {
                        var contact = Contact();
                        contact.name = _contactNameController.text;
                        contact.phone = _contactPhoneController.text;
                        contact.email = _contactEmailController.text;
                        var result = await _contactService.saveContact(contact);
                        // ignore: use_build_context_synchronously
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
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                    onPressed: () {
                      _contactNameController.text = '';
                      _contactPhoneController.text = '';
                      _contactEmailController.text = '';
                    },
                    child: const Text('Effacer'),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
