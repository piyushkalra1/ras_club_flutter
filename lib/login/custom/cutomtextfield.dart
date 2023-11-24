import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  EdgeInsets padding;
  final String hint;
  IconData? suffixIcon;
  bool enabled ;
  final validation;
  List<TextInputFormatter> inputFormatters;
  TextInputType textInputType;
  TextCapitalization textCapitalization;
  TextInputAction textInputAction;
  bool readOnly;
  VoidCallback? onTap;
  CustomTextField({Key? key, required this.validation,required this.controller,this.padding = const EdgeInsets.symmetric(vertical: 8, horizontal: 12), required this.hint, this.suffixIcon = null, this.enabled = true, this.inputFormatters = const [], this.textInputType = TextInputType.text, this.textCapitalization = TextCapitalization.none, this.textInputAction = TextInputAction.next, this.readOnly = false, this.onTap = null}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: TextFormField(
        controller: controller,
        textInputAction: textInputAction,
        textCapitalization: textCapitalization,
        inputFormatters: inputFormatters,
        keyboardType: textInputType,
        readOnly: readOnly,
        onTap: onTap,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          floatingLabelBehavior: FloatingLabelBehavior.auto,
          hintText: hint,
          labelText: hint,
          filled: true,
          enabled: enabled,
          suffixIcon: suffixIcon == null ? null : Icon(suffixIcon, color: Colors.blue,),
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(
              vertical: 18, horizontal: 16),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.blue, width: 2),
            borderRadius: BorderRadius.circular(8.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.black54, width: 1.2),
            borderRadius: BorderRadius.circular(8.0),
          ),
          disabledBorder:  OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.black54, width: 1.2),
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
        validator: validation,
        // The validator receives the text that the user has entered.
      ),
    );
  }
}


