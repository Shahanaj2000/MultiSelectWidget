import 'package:flutter/material.dart';

import 'MultiSelect.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //List for String
  List<String> _selectItems = [];

  //Method
  void _showMultiSelect() async {
    //! A list of selectable Items
    //these items can be hard - coded or dynamically fetched from db or APIs
    final List<String> Items = [
      "Flutter",
      "Node Js",
      "React",
      "Python",
      "DotNet",
      "GoLang",
    ];

    final List<String>? results = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return MultiSelect(items: Items);
      },
    );

    //Update UI
    if (results != null) {
      setState(() {
        _selectItems = results;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("MultiSelect"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ElevatedButton(
              onPressed: () {
                _showMultiSelect();
              },
              child: const Text("Select Your Favrite topic"),
            ),

            const Divider(
              height: 30,
            ),
            //To display the selectedItems
            Wrap(
              children: _selectItems
                .map((e) => Chip(
                  label: Text(e))
                )
                  .toList(),
            )
          ],
        ),
      ),
    );
  }
}