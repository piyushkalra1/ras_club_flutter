import 'package:flutter/material.dart';

class TabWidget extends StatelessWidget {
  const TabWidget({
    Key? key,
    required this.text,
    required this.isFavorite,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) =>
      OutlinedButton(
          style: TextButton.styleFrom(
            backgroundColor: isFavorite?Colors.blueGrey :Colors.white12,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.horizontal(left: Radius.circular(20),right: Radius.circular(20),)
            ),
          ),
          onPressed: onPressed,
          child: Text(text,style: TextStyle(color:isFavorite?Colors.white: Colors.black,fontWeight: FontWeight.w400),));

  final String text;
  final bool isFavorite;
  final VoidCallback onPressed;

}