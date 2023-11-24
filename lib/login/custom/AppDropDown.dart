import 'package:flutter/material.dart';

class AppDropdown<T> extends StatelessWidget {
  final List<T> dropdownList;
  final T dropdownValue;
  final Function(T?) onChanged;

  const AppDropdown(
      {super.key,
        required this.dropdownList,
        required this.dropdownValue,
        required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<T>(
        value: dropdownValue,
        isDense: true,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: 12),
            border: OutlineInputBorder()
        ),
        style: const TextStyle(fontSize: 18.0, color: Colors.black54),
        icon: const Icon(Icons.keyboard_arrow_down),
        items: dropdownList.map((T items) {
          return DropdownMenuItem(
            value: items,
            child: Text(items.toString()),
          );
        }).toList(),
        onChanged: onChanged);
  }
}
