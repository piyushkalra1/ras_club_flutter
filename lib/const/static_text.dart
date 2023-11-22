import 'package:flutter/material.dart';

class StaticText extends StatelessWidget {

  final text;
  StaticText({required this.text});
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(width: 10,),
        Icon(Icons.circle,size: 9,color: Colors.black45,),
        SizedBox(width: 10,),
        Text(text,style: TextStyle(color: Colors.black45),),
      ],
    );
  }
}