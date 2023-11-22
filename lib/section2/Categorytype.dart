import 'package:flutter/material.dart';
import 'package:ras_club_flutter/section2/facilitycard2.dart';
import 'package:ras_club_flutter/section2/tableno.dart';

import '../const/facility_card.dart';

class CategoryType extends StatefulWidget {
  const CategoryType({Key? key}) : super(key: key);

  @override
  State<CategoryType> createState() => _CategoryTypeState();
}

class _CategoryTypeState extends State<CategoryType> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.white12,
        title: Text('Choose Order From',style:Tablenotextstyle,),
      ),
      body: SafeArea(
        child: GridView.count(
          childAspectRatio: 1,
          primary: false,
          // padding: const EdgeInsets.all(20),
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          crossAxisCount: 3,
          children: <Widget>[
            FacilityCards2(thumbnail: 'assets/images/img2.jpg',ontap: (){

              Navigator.push(context, MaterialPageRoute(builder: (context)=>TableNo()));
            },tittle: 'Accomodation',),
            FacilityCards2(thumbnail: 'assets/images/banquet_3.jpg',ontap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>TableNo()));
            },tittle: 'Banquet Hall',),

            FacilityCards2(thumbnail: 'assets/images/banquet_4.jpg',ontap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>TableNo()));

            },tittle: 'Party Hall',),
            FacilityCards2(thumbnail: 'assets/images/conference_3.jpg',ontap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>TableNo()));

            },tittle: 'Conference Hall',),
            FacilityCards2(thumbnail: 'assets/images/bar_21.jpg',ontap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>TableNo()));

            },tittle: 'Bar',),



          ],
        ),
      ),
    );
  }
}
