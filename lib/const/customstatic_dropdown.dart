import 'package:flutter/material.dart';
import 'package:flutter/material.dart';


class CustomStaticDropdown<T> extends StatefulWidget {
  final List<T> items;
  final Function(T?) onItemSelected;

  const CustomStaticDropdown({Key? key, required this.items, required this.onItemSelected}) : super(key: key);

  @override
  State<CustomStaticDropdown<T>> createState() => _CustomStaticDropdownState<T>();
}

class _CustomStaticDropdownState<T> extends State<CustomStaticDropdown<T>> {
  late T dropdownValue ;
  @override
  void initState() {
    print('object');
    dropdownValue = widget.items.first;

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return  InputDecorator(
      decoration: InputDecoration(contentPadding: EdgeInsets.all(15),
          border: OutlineInputBorder(borderRadius: const BorderRadius.all(Radius.circular(8.0)),)),
      child: DropdownButtonHideUnderline(
        child: DropdownButton(
          value: dropdownValue,
          isDense: true,
          isExpanded: false,
          icon: Container(),
          items: widget.items.map((T items) {
            return DropdownMenuItem(
              value: items,
              child: Text(items.toString()),
            );
          }).toList(),
          onChanged: (T? newValue) {
            setState(() {
              dropdownValue = newValue!;
            });
            widget.onItemSelected(newValue);
          },
        ),
      ),
    );
  }
}