import 'dart:developer';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key,
  });

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<ContactModel> contacts = [
    ContactModel("Binu", '9562650528', false),
    ContactModel("safa", "9746707384", false),
    ContactModel('amal', '789456123', false)
  ];

  List<ContactModel> selectedItem = [];

  void mulSelection(int index) {
    setState(() {
      contacts[index].isSelected = !contacts[index].isSelected;
      if (contacts[index].isSelected == true) {
        selectedItem.add(
          ContactModel(contacts[index].name, contacts[index].phone, true),
        );
        log(selectedItem[index].name.toString());
      } else if (contacts[index].isSelected == false) {
        selectedItem
            .removeWhere((element) => element.phone == contacts[index].phone);
        log(selectedItem[index].name.toString());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Multy selection"),
      ),
      body: Center(
          child: Column(
        children: [
          Flexible(
            child: ListView.builder(
              itemCount: contacts.length,
              itemBuilder: (context, index) {
                return contatItem(
                  contacts[index].name,
                  contacts[index].phone,
                  contacts[index].isSelected,
                  index,
                  () => mulSelection(index),
                );
              },
            ),
          ),
          Flexible(
            child: ListView.builder(
              itemCount: selectedItem.length,
              itemBuilder: (context, index) {
                return contatItem(
                  selectedItem[index].name,
                  selectedItem[index].phone,
                  selectedItem[index].isSelected,
                  index,
                  () => mulSelection(index),
                );
              },
            ),
          ),
        ],
      )),
    );
  }
}

Widget contatItem(
  String name,
  String phone,
  bool isSelected,
  int index,
  Function() selectData,
) {
  return ListTile(
      leading: const CircleAvatar(
        backgroundColor: Colors.green,
        child: Icon(
          Icons.person,
          color: Colors.white,
        ),
      ),
      title: Text(name),
      subtitle: Text(phone),
      trailing: isSelected
          ? Icon(
              Icons.check_circle,
              color: Colors.green[700],
            )
          : const Icon(
              Icons.check_circle_outline,
              color: Colors.green,
            ),
      onTap: () {
        selectData();
      });
}

class ContactModel {
  String name;
  String phone;
  bool isSelected;
  ContactModel(this.name, this.phone, this.isSelected);
}
