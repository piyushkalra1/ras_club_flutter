import 'package:flutter/material.dart';
import 'package:ras_club_flutter/const/pink_button.dart';

import 'static_text.dart';

class ApiListviewHorizontal extends StatelessWidget {

  final thumbnail;
  final tittle;
  final text1;
  final text2;
  final rate;
  final ontap;
  ApiListviewHorizontal({required this.ontap,required this.rate,required this.thumbnail,required this.tittle,required this.text1,required this.text2});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      margin: EdgeInsets.all(12),
      height: 690,
      child: Material(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18)
        ),
        color: Colors.white,
        elevation: 6,
        child: Column(
          children: [
            Container(

              height: 170,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(18),
                    topLeft: Radius.circular(18),
                  ),
                  image: DecorationImage(
                      image: thumbnail,fit: BoxFit.fill
                  )
              ),
            ),
            SizedBox(height: 10,),
            Center(child: Text(tittle,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),),
            SizedBox(height: 20,),

            StaticText(text: text1,),
            StaticText(text: 'Air Conditioning'),
            StaticText(text: 'Television'),
            StaticText(text: 'Complementry Breakfast'),
            StaticText(text: 'Safe Locker'),
            StaticText(text: 'Study Table and Chair'),
            StaticText(text: 'Wi-fi Access'),
            StaticText(text: 'Telephone'),
            StaticText(text: 'Slipper and Runner'),
            StaticText(text: 'Hair Dryer'),
            StaticText(text: 'Coffee Table and Chair'),
            StaticText(text: 'Hot Water'),
            StaticText(text: 'Tea and Coffee Maker'),
            StaticText(text: 'Mineral Water'),
            StaticText(text: text2),
            StaticText(text: 'Shaving Kit(if required)'),
            SizedBox(height: 40,),
            Text('₹ ${rate}',style: TextStyle(fontSize: 20,color: Colors.black45),),
            PinkButton(text: 'Continue',ontap: ontap,),
          ],
        ),
      ),
    );
  }
}