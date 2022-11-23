import 'dart:async';
import 'package:procontact/database/repository.dart';
import 'package:procontact/model/Contact.dart';

class ContactService {
  late Repository _repository;
  ContactService() {
    _repository = Repository();
  }
  //Save Contact
  SaveContact(Contact contact) async {
    return await _repository.insertContact('contacts', contact.contactMap());
  }

  //Read All Contacts
  readAllContacts() async {
    return await _repository.readData('contacts');
  }

  //Edit Contact
  UpdateContact(Contact contact) async {
    return await _repository.updateData('contacts', contact.contactMap());
  }

  deleteContact(userId) async {
    return await _repository.deleteDataById('contacts', userId);
  }
}
