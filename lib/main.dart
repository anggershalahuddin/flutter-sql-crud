// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_application_1_sql_crud/contact_detail.dart';
import 'package:flutter_application_1_sql_crud/dataaccess/contact_dataaccess.dart';
import 'package:flutter_application_1_sql_crud/model/contact_model.dart';
import 'package:get/get.dart';

void main(List<String> args) {
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  MainApp({super.key});
  List<Contact> list = <Contact>[].obs;
  ContactDataAcess dataAcess = ContactDataAcess();

  getData() async {
    var data = await dataAcess.getAll();
    list.clear();
    list.addAll(data);
  }

  onDelete(int id) async {
    bool confirm = await Get.dialog(AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text("Apakah anda yakin?"),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                  style:
                      ElevatedButton.styleFrom(backgroundColor: Colors.black12),
                  onPressed: () {
                    Get.back(result: false);
                  },
                  child: Text("NO")),
              SizedBox(
                width: 10,
              ),
              ElevatedButton(
                  onPressed: () {
                    Get.back(result: true);
                  },
                  child: Text("Yes"))
            ],
          )
        ],
      ),
    ));

    if (confirm) {
      await dataAcess.delete(id);
      getData();
    }
  }

  @override
  Widget build(BuildContext context) {
    getData();
    return GetMaterialApp(
      title: 'SQLite CRUD',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('SQLite CRUD'),
        ),
        body: Obx(() => ListView.separated(
              itemCount: list.length,
              separatorBuilder: (context, index) => Container(
                margin: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                color: Colors.black26,
                height: 1,
              ),
              itemBuilder: (context, index) => Container(
                margin: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.person,
                          size: 32,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              list[index].name.toString(),
                              style: TextStyle(fontSize: 20),
                            ),
                            SizedBox(
                              height: 6,
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.phone_android,
                                  color: Colors.black54,
                                  size: 15,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  list[index].phone.toString(),
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 12),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 4,
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.mail,
                                  color: Colors.black54,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  list[index].email.toString(),
                                  style: TextStyle(
                                      color: Colors.black54, fontSize: 12),
                                )
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                    IconButton(
                        onPressed: () {
                          onDelete(list[index].id);
                        },
                        icon: Icon(
                          Icons.delete,
                          color: Colors.red,
                        ))
                  ],
                ),
              ),
            )),
        floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingActionButton(
              onPressed: () async {
                await Get.to(ContactDetail());
                getData();
              },
              child: Icon(Icons.add),
            )
          ],
        ),
      ),
    );
  }
}
