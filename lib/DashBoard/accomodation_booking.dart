import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
import 'package:http/http.dart';
import 'package:ras_club_flutter/Booking/book_kingroom.dart';
import 'package:ras_club_flutter/const/dashboard_cards.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../const/dashbord_stack_container.dart';
import '../const/constants.dart';
import 'model/GetRoomBookingModel.dart';

class Accomodation extends StatefulWidget {

  final GetRoomBookingModel data;
  Accomodation({required this.data});

  @override
  State<Accomodation> createState() => _AccomodationState();
}

class _AccomodationState extends State<Accomodation> {
  @override



  Widget build(BuildContext context) {
    // print(widget.data.bookings!.length);

    // print(widget.data);
    return  Scaffold(



      body: Stack(
        children: [
          DashboaredStackContainer(tittle: 'Accomodation Bookings',gradient: linergradientaccomodation,),
          Positioned(
            top: 130,

              child: InkWell(
                onTap:(){},

                child: Container(
                  height: MediaQuery.of(context).size.height, width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Colors.white,

            ),
                  child:ListView.builder(
                      itemCount: widget.data.bookings!.length,
                      itemBuilder: (BuildContext context, int index) {
                        return  Container(

                          padding: EdgeInsets.all(8),
                          margin: EdgeInsets.all(12),

                          decoration: BoxDecoration(

                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                  width: 2,
                                  color: Colors.black12
                              )
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [

                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 4),
                                  child: Row(
                                    children: [
                                      Text('${widget.data.bookings![index].roomType}',style: TextStyle1,),
                                      Spacer(),
                                      Text('${widget.data.bookings![index].status}'),
                                      if(widget.data.bookings![index].status== 'Expired')...{
                                        Icon(Icons.circle,color: Colors.red,size: 12,)
                                      }else
                                      Icon(Icons.circle,color: Colors.green,size: 12,)
                                    ],
                                  ),
                                ),

                                
                              
                              Padding(
                                padding: const EdgeInsets.only(left: 8),
                                child: Text("${widget.data.bookings![index].bookingFor}"),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Column(
                                    children: [
                                      Text('Check-in:',style: TextStyle1),
                                      Text('${widget.data.bookings![index].checkin}',style: TextStyle(fontSize: 15),)
                                    ],
                                  ),
                                  SizedBox(width: 10,),
                                  Container(width: 2,height: 30,color: Colors.black45,),
                                  SizedBox(width: 10,),
                                  Column(
                                    children: [
                                      Text('Check-out:',style: TextStyle1),
                                      Text('${widget.data.bookings![index].checkout}',style: TextStyle(fontSize: 15),),
                                    ],
                                  ),

                                ],
                              ),
                              SizedBox(height: 20,),
                              Center(child: Text('Booking Id :${widget.data.bookings![index].orderId}')),
                              Text('Date & Time of Booking ${widget.data.bookings![index].createdAt}',textAlign: TextAlign.center,),

                              SizedBox(height: 20,),

                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      color: Colors.blueGrey.shade100
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: [
                                        Column(
                                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                                          children: [
                                            Text('Total Fair'),
                                            Text('${widget.data.bookings![index].totalFair}'),
                                          ],
                                        ),
                                        Column(
                                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                                          children: [
                                            Text('GsT'),
                                            Text('${widget.data.bookings![index].gst}'),
                                          ],
                                        ),
                                        Column(
                                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                                          children: [
                                            Text('Grand Total '),
                                            Text('${widget.data.bookings![index].grandTotal}'),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        );
                      })




          ),
              ))
        ],
      ),
    );
  }
}

