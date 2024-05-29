import 'package:flutter/material.dart';

class TvWiBreakfast extends StatelessWidget {

  final icon;
  final text;

  TvWiBreakfast({required this.text,required this.icon});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Card(
        color: Colors.white70,
        elevation: 4,
        borderOnForeground: true,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15)
        ),
        child: Container(
          margin: EdgeInsets.all(10),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(icon,color: Colors.black45,size: 35,),
                SizedBox(height: 6,),
                Text(text,style: TextStyle(color: Colors.black45,fontSize: 16),textAlign: TextAlign.center,),
              ],
            ),
          ),
        ),
      ),
    );
  }
}