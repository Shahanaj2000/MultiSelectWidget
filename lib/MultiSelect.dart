import 'package:flutter/material.dart';

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