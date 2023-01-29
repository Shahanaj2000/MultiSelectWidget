import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(primarySwatch: Colors.pink),
    home: const HomePage(),
  ));
}

//If we want to dispay the alert
class MultiSelect extends StatefulWidget {
  final List<String> items;

  const MultiSelect({super.key, required this.items});

  @override
  State<MultiSelect> createState() => _MultiSelectState();
}

class _MultiSelectState extends State<MultiSelect> {
  //This variable holds the selected Item
  final List<String> _selectedItems = [];

  //This fn is triggered when the checkBox is checked or unchecked
  void _itemChange(String itemValue, bool isSelected) {
    setState(() {
      if (isSelected) {
        _selectedItems.add(itemValue);
      } else {
        _selectedItems.remove(itemValue);
      }
    });
  }

  //This fn is called when the cancel button is pressed
  void _cancel() {
    Navigator.pop(context);
  }

  //This fn is called when the Submit  button is pressed
  void _submit() {
    Navigator.pop(context, _selectedItems);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Select Topics"),
      content: SingleChildScrollView(
        child: ListBody(
          children: widget.items
              .map((item) => CheckboxListTile(
                    value: _selectedItems.contains(item),
                    title: Text(item),
                    controlAffinity: ListTileControlAffinity.leading,
                    onChanged: (isCheched) => _itemChange(item, isCheched!),
                  ))
              .toList(),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            _cancel();
          },
          child: const Text("Cancel"),
        ),
        ElevatedButton(
            onPressed: () {
              _submit();
            },
            child: const Text("Submit")),
      ],
    );
  }
}

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
