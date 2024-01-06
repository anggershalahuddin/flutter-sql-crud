import 'package:flutter/material.dart';
import 'package:flutter_application_1_sql_crud/dataaccess/contact_dataaccess.dart';
import 'package:flutter_application_1_sql_crud/model/contact_model.dart';
import 'package:get/get.dart';

class ContactDetail extends StatelessWidget {
  ContactDetail({super.key});
  ContactDataAcess dataAcess = ContactDataAcess();
  final _formKey = GlobalKey<FormState>();
  final Map<String, dynamic> formData = {
    "id": 0,
    "name": "",
    "phone": "",
    "email": ""
  };

  void onSave() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      print(formData);
      await dataAcess.insert(Contact.fromMap(formData));
      Get.back();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contac Detail'),
      ),
      body: ListView(
        children: [
          Container(
            margin: EdgeInsets.all(24),
            child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    SizedBox(
                      child: TextFormField(
                        decoration: InputDecoration(labelText: 'ID'),
                        enabled: false,
                      ),
                    ),
                    SizedBox(
                      child: TextFormField(
                        decoration: InputDecoration(labelText: 'Name'),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please input a name";
                          }
                        },
                        onSaved: (newValue) {
                          formData["name"] = newValue;
                        },
                      ),
                    ),
                    SizedBox(
                      child: TextFormField(
                        decoration: InputDecoration(labelText: 'Phone'),
                        keyboardType: TextInputType.phone,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please input a phone number";
                          }
                        },
                        onSaved: (newValue) {
                          formData["phone"] = newValue;
                        },
                      ),
                    ),
                    SizedBox(
                      child: TextFormField(
                        decoration: InputDecoration(labelText: 'Email'),
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please input a email";
                          }
                          final bool valid = RegExp(
                                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                              .hasMatch(value);
                          if (!valid) {
                            return "Please input a valid email";
                          }
                          ;
                        },
                        onSaved: (newValue) {
                          formData["email"] = newValue;
                        },
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                        height: 40,
                        width: double.infinity,
                        child: ElevatedButton(
                            onPressed: onSave, child: Text('Save')))
                  ],
                )),
          )
        ],
      ),
    );
  }
}
