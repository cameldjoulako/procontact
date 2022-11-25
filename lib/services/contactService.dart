// ignore_for_file: file_names

import 'package:procontact/database/repository.dart';
import 'package:procontact/model/Contact.dart';

class ContactService {
  late Repository _repository;
  ContactService() {
    _repository = Repository();
  }

  //Enregistrer un Contact
  saveContact(Contact contact) async {
    return await _repository.insertContact('contacts', contact.contactMap());
  }

  //Recuperer tous les Contacts
  readAllContacts() async {
    return await _repository.readContact('contacts');
  }

  //Edit Contact
  updateContact(Contact contact) async {
    return await _repository.updateContact('contacts', contact.contactMap());
  }

  deleteContact(contactId) async {
    return await _repository.deleteContactById('contacts', contactId);
  }
}
