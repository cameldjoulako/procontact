// ignore_for_file: file_names

class Contact {
  int? id;
  String? name;
  String? phone;
  String? email;

  contactMap() {
    // ignore: prefer_collection_literals
    var mapping = Map<String, dynamic>();
    mapping['id'] = id;
    mapping['name'] = name!;
    mapping['phone'] = phone!;
    mapping['email'] = email!;
    return mapping;
  }
}
