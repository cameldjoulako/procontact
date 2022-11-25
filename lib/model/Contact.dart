class Contact {
  int? id;
  String? name;
  String? phone;
  String? email;

  contactMap() {
    var mapping = Map<String, dynamic>();
    mapping['id'] = id ?? null;
    mapping['name'] = name!;
    mapping['phone'] = phone!;
    mapping['email'] = email!;
    return mapping;
  }
}
