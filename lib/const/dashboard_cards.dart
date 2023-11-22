import 'package:flutter/material.dart';

import 'multicolor.dart';

class DashboardCards extends StatelessWidget {
  final ontap;
  final tittle;
  final subtittle;
  final image;
  final gradient;
  final colour;

  DashboardCards({required this.colour,required this.ontap,required this.tittle,required this.subtittle,required this.image, required this.gradient});
  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 200,
      padding: EdgeInsets.only(top: 14),
      margin: EdgeInsets.all(15),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: gradient),


      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [ SizedBox(width: 15,),
              CircleAvatar(
                  backgroundColor: colour,
                  radius: 30.0,
                  child:image,
              ),
              SizedBox(width: 15,),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children:  [
                    Text(tittle,style: TextStyle(fontSize: 24,color: Colors.white),),
                    Text(subtittle,style: TextStyle(color: Colors.white),),

                  ],
                ),
              ),

            ],
          ),
          Row(
            children: [
              Spacer(),
              InkWell(
                onTap: ontap,
                child: Container(

                  margin: EdgeInsets.all(15),
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      color: Colors.black54,
                      borderRadius: BorderRadius.circular(15)
                  ),
                  child: Row(
                    children: [
                      Text(
                        'Get Details ',style: TextStyle(color: Colors.white),
                      ),
                      Icon(Icons.arrow_forward,color: Colors.white,),
                    ],
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}



LinearGradient linergradientaccomodation =LinearGradient(colors: [
  hexStringToColor("248AA3"),
  // hexStringToColor("87CEEB"),
  hexStringToColor("87CEEB")
], begin: Alignment.topLeft, end: Alignment.topRight);

LinearGradient linergradienthall =LinearGradient(colors: [
  hexStringToColor("636363"),
  // hexStringToColor("87CEEB"),
  hexStringToColor("a2ab58")
], begin: Alignment.topLeft, end: Alignment.topRight);

LinearGradient linergradientgame =LinearGradient(colors: [
  hexStringToColor("3c1053"),
  // hexStringToColor("87CEEB"),
  hexStringToColor("ad5389")
], begin: Alignment.topLeft, end: Alignment.topRight);
LinearGradient linergradientgym =LinearGradient(colors: [
  hexStringToColor("414346"),
  // hexStringToColor("87CEEB"),
  hexStringToColor("5C6268")
], begin: Alignment.topLeft, end: Alignment.topRight);