import 'package:flutter/material.dart';
import 'package:ras_club_flutter/section2/FoodCategories.dart';

import 'FoodListCategori.dart';

class TableNo extends StatelessWidget {
  const TableNo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(backgroundColor: Colors.white12,
        title: Text('Choose Table Number',style:Tablenotextstyle,),
      ),
      body: GridView.count(
        primary: false,
        padding: const EdgeInsets.all(20),
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
        crossAxisCount: 6,
        children: <Widget>[
          Tablenumber(number: '1',member: 3,),
          Tablenumber(number: '2',member: 4,),
          Tablenumber(number: '3',member: 2,),
          Tablenumber(number: '4',member: 1,),
          Tablenumber(number: '5', member: 6,),
          Tablenumber(number: '6',member: 2,),
          Tablenumber(number: '7',member: 2,),
          Tablenumber(number: '8',member: 2,),
          Tablenumber(number: '9',member: 2,),
          Tablenumber(number: '10',member: 2,),
          Tablenumber(number: '11',member: 2,),
          Tablenumber(number: '12',member: 2,),
          Tablenumber(number: '13',member: 2,),
          Tablenumber(number: '14',member: 2,),
          Tablenumber(number: '15',member: 2,),
          Tablenumber(number: '16',member: 2,),
          Tablenumber(number: '17',member: 2,),
          Tablenumber(number: '18',member: 2,),
          Tablenumber(number: '19',member: 24,),
          Tablenumber(number: '20',member: 5,),
        ],
      ),
    );
  }
}

class Tablenumber extends StatelessWidget {
  final String number;
  final int member;
  const Tablenumber({
   required this.number,required this.member
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>FoodCategoryList()));
      },
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration
          (borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.blueGrey,width: 3)
        ),
        child: Column(
          children: [
            Row(children: [
              Spacer(),
              Text('$member\n Person',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18,color: Colors.blueGrey),textAlign: TextAlign.center,),
            ],),
            SizedBox(height: 15,),
            Center(child: Text('T-$number',textAlign: TextAlign.center,style: Tablenotextstyle,),),
          ],
        )
      ),
    );
  }
}
const Tablenotextstyle = TextStyle(
    fontWeight: FontWeight.bold,fontSize: 28,color: Colors.blueGrey
);