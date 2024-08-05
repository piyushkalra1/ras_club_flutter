import 'package:flutter/material.dart';
import 'package:ras_club_flutter/const/dashboard_cards.dart';
import 'package:screen_loader/screen_loader.dart';

import '../Booking/book_kingroom.dart';
import '../model/GetGameBookingModel.dart';
import 'accomodation_booking.dart';
import '../const/dashbord_stack_container.dart';

class GameBooking extends StatefulWidget {
 final GetGameBookingModel data;
 GameBooking({required this.data});

  @override
  State<GameBooking> createState() => _GameBookingState();
}

class _GameBookingState extends State<GameBooking> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Stack(
        children: [
          DashboaredStackContainer(tittle: 'Games Bookings',gradient: linergradientgame,),
          Positioned(
              top: 130,

              child: Container(
                height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.white
                ),
                child: ListView.builder(
                    itemCount: widget.data.bookings!.length,
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) {
                      return  Container(

                        padding: EdgeInsets.all(8),
                        margin: EdgeInsets.symmetric(horizontal: 12,vertical: 6),

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
                            Text('${widget.data.bookings![index].game}',style: TextStyle1),
                            Text('${widget.data.bookings![index].type}',style: TextStyle(fontSize: 15)),
                           SizedBox(height: 12,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Column(
                                  children: [
                                    Text('Month',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold)),

                                    Text('${widget.data.bookings![index].month}',style: TextStyle(fontSize: 13),)
                                  ],
                                ),
                                SizedBox(width: 10,),
                                Container(width: 2,height: 30,color: Colors.black45,),
                                SizedBox(width: 10,),
                                Column(
                                  children: [
                                    Text('Timeslot:',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold)),
                                    Text('${widget.data.bookings![index].timeSlot}',style: TextStyle(fontSize: 13),),
                                  ],
                                ),

                              ],
                            ),
                            SizedBox(height: 20,),
                            Center(child: Text('Booking Id :${widget.data.bookings![index].orderId}')),
                            Text('Date & Time of Booking ${widget.data.bookings![index].createdAt}',textAlign: TextAlign.center,),

                            SizedBox(height: 20,),



                          ],
                        ),
                      );
                    })
              ))
        ],
      ),
    );
  }
}
