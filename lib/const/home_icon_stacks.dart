import 'package:flutter/material.dart';

class HomeIconStacks extends StatelessWidget {
  final thumbnail;
  final tittle;
  final subtittle;



  HomeIconStacks({required this.thumbnail ,required this.tittle,required this.subtittle});
  @override
  Widget build(BuildContext context) {
    return Stack(

      children: [
        Container(
          width: MediaQuery.of(context).size.width,


          child:  Image(
            image: AssetImage(
                thumbnail,
            ),fit:BoxFit.fill,
          ),
        ),
        Positioned(
          top: 30,left: 20,
          child:   InkWell(
            onTap:(){
              Navigator.pop(context);
            },
            child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(6),
                ),
                height: 30,
                child: Image(image: AssetImage('assets/images/back.png'))),
          ),),
        Positioned(
            top:150,left: 20,
            child:   Text(tittle,style: TextStyle(color: Colors.white,fontSize: 29),)),

        Container(
          margin: EdgeInsets.only(top: 190),
            padding: EdgeInsets.symmetric(vertical: 25,horizontal: 16),
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: Colors.white
            ),
            child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Text(subtittle)),

        )
      ],
    );
  }
}