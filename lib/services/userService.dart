import 'dart:async';

import 'package:procontact/db/repository.dart';
import 'package:procontact/model/Contact.dart';

class ContactService {
  late Repository _repository;
  ContactService() {
    _repository = Repository();
  }
  //Save Contact
  SaveContact(Contact user) async {
    return await _repository.insertData('users', user.contactMap());
  }

  //Read All Contacts
  readAllContacts() async {
    return await _repository.readData('users');
  }

  //Edit Contact
  UpdateContact(Contact user) async {
    return await _repository.updateData('users', user.contactMap());
  }

  deleteContact(userId) async {
    return await _repository.deleteDataById('users', userId);
  }
}
