import 'package:flutter/material.dart';

class PinkButton extends StatelessWidget {
  final ontap;
  final text;
  PinkButton({required this.ontap,required this.text});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: Container(
        margin: EdgeInsets.only(left: 10,top: 15,right: 10,),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.pink,
        ),
        padding: EdgeInsets.symmetric(vertical: 12),

        child:  Center(
          child: Text(text,style: TextStyle(
              color: Colors.white,fontWeight: FontWeight.bold,fontSize: 16
          ),),
        ),
      ),
    );
  }
}