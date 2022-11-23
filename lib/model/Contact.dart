class Contact {
  int? id;
  String? name;
  String? contact;
  String? description;

  contactMap() {
    var mapping = Map<String, dynamic>();
    mapping['id'] = id ?? null;
    mapping['name'] = name!;
    mapping['contact'] = contact!;
    mapping['description'] = description!;
    return mapping;
  }
}
