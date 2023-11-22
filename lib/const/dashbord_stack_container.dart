import 'package:flutter/material.dart';

class DashboaredStackContainer extends StatelessWidget {

  final tittle;
  final gradient;

  DashboaredStackContainer({required this.tittle, required this.gradient});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(15,10, 5, 10),
        decoration: BoxDecoration(
            gradient: gradient),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20,),

            InkWell(
              onTap: (){Navigator.pop(context);},
              child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  height: 30,
                  child: Image(image: AssetImage('assets/images/back.png'))),
            ),
            SizedBox(height: 10,),
            Text(tittle,style: TextStyle(fontSize: 28,color: Colors.white),)
          ],
        )
    );
  }
}