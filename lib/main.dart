import 'package:procontact/model/Contact.dart';
import 'package:procontact/pages/editContact.dart';
import 'package:procontact/pages/addContact.dart';
import 'package:procontact/services/contactService.dart';
import 'package:flutter/material.dart';
import 'package:colorize_text_avatar/colorize_text_avatar.dart';

void main() {
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ProContacts',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late List<Contact> _contactList = <Contact>[];
  final _contactService = ContactService();

  getAllContactDetails() async {
    var contacts = await _contactService.readAllContacts();
    _contactList = <Contact>[];
    contacts.forEach((contact) {
      setState(() {
        var contactModel = Contact();
        contactModel.id = contact['id'];
        contactModel.name = contact['name'];
        contactModel.phone = contact['phone'];
        contactModel.email = contact['email'];
        _contactList.add(contactModel);
      });
    });
  }

  @override
  void initState() {
    getAllContactDetails();
    super.initState();
  }

  _showSuccessSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: const TextStyle(
            fontSize: 18,
          ),
        ),
        backgroundColor: Colors.blueAccent,
      ),
    );
  }

  _deleteFormDialog(BuildContext context, contactId) {
    return showDialog(
        context: context,
        builder: (param) {
          return AlertDialog(
            title: const Text(
              'Confirmer la suppression',
              style: TextStyle(color: Colors.black, fontSize: 20),
            ),
            actions: [
              TextButton(
                style: TextButton.styleFrom(
                    foregroundColor: Colors.white, backgroundColor: Colors.red),
                onPressed: () async {
                  var result = await _contactService.deleteContact(contactId);
                  if (result != null) {
                    // ignore: use_build_context_synchronously
                    Navigator.pop(context);
                    getAllContactDetails();
                    _showSuccessSnackBar('Contact supprimé avec succèss');
                  }
                },
                child: const Text('Ok'),
              ),
              TextButton(
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.blue,
                    textStyle: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Annuller'))
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.blue,
        title: const Text(
          "ProContact",
          style: TextStyle(
            fontSize: 25,
          ),
        ),
        leading: const IconButton(
          icon: Icon(
            Icons.menu,
            color: Colors.white,
            size: 30,
          ),
          onPressed: null,
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(
              Icons.person_add_alt,
              color: Colors.white,
              size: 30,
            ),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const AddContact())).then((data) {
                if (data != null) {
                  getAllContactDetails();
                  _showSuccessSnackBar('Contact ajouté avec succès');
                }
              });
            },
          ),
        ],
      ),
      body: ListView.builder(
          itemCount: _contactList.length,
          itemBuilder: (context, index) {
            return Card(
              child: ListTile(
                onTap: null,
                leading: Column(children: [
                  TextAvatar(
                    textColor: Colors.white,
                    shape: Shape.Circular,
                    text: _contactList[index].name ?? 'Driss As',
                    numberLetters: 2,
                    upperCase: true,
                  ),
                ]),
                title: Text(
                  _contactList[index].name ?? '',
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _contactList[index].phone ?? '',
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                      ),
                    ),
                    Text(
                      _contactList[index].email ?? '',
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EditContact(
                              contact: _contactList[index],
                            ),
                          ),
                        ).then((data) {
                          if (data != null) {
                            getAllContactDetails();
                            _showSuccessSnackBar(
                                'Contact mis à jour avec succès');
                          }
                        });
                      },
                      icon: const Icon(
                        Icons.edit,
                        color: Colors.blue,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        _deleteFormDialog(context, _contactList[index].id);
                      },
                      icon: const Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
