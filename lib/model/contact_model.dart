class Contact {
  int id;
  String name;
  String phone;
  String email;

  Contact({
    required this.id,
    required this.name,
    required this.phone,
    required,
    required this.email,
  });

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "phone": phone,
        "email": email,
      };

  factory Contact.fromMap(Map<String, dynamic> map) => Contact(
      id: map['id'],
      name: map['name'],
      phone: map['phone'],
      email: map['email']);
}
