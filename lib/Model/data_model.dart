class Contacts {
  final int? id;
  final String lastname;
  final String firstname;
  final String phonenumbers;

  Contacts(
      {required this.id,
      required this.lastname,
      required this.firstname,
      required this.phonenumbers});

  factory Contacts.fromJson(Map<String, dynamic> json) {
    return Contacts(
        id: json['_id'],
        lastname: json['lastname'],
        firstname: json['firstname'],
        phonenumbers: json['phonenumbers']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.id;
    data['lastname'] = this.lastname;
    data['firstname'] = this.firstname;
    data['phonenumbers'] = this.phonenumbers;
    return data;
  }
}
