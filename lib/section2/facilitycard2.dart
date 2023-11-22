import 'package:flutter/material.dart';

import '../const/multicolor.dart';



class FacilityCards2 extends StatelessWidget {
  final tittle;
  final thumbnail;
  final ontap;

  FacilityCards2({required this.thumbnail,required this.tittle, required this.ontap});

  @override
  Widget build(BuildContext context) {
    return Container(

      color: Color(0XFFCDF0E2),
      padding: EdgeInsets.only(bottom: 8,left: 2,right: 2),
      child: InkWell(
        onTap: ontap,
        child: Card(
          clipBehavior: Clip.hardEdge,
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          elevation: 3,
          child: SizedBox(

            child: Stack(
              children: [
                Container(

                  height: 140,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [
                        // hexStringToColor("CB2B93"),
                        hexStringToColor("D275DC"),
                        hexStringToColor("E5EC42")
                      ], begin: Alignment.center,end: Alignment.bottomCenter )),
                ),
                Positioned(
                    top: 10,left: 10,right: 10,
                    child:SizedBox(
                      height: 600,
                      child: Column(
                        children: [
                          Expanded(
                            flex: 6,
                            child: Image.asset(thumbnail,fit: BoxFit.fill,width: double.infinity,),),
                          // SizedBox(height: 10,),
                          Expanded(
                              flex: 5,
                              child: Text(tittle,style: TextStyle(fontSize: 28,fontWeight: FontWeight.bold),)),
                          SizedBox(height: 10,)
                        ],
                      ),

                    ) )
              ],
            ),
          ),
        ),
      ),
    );
  }
}