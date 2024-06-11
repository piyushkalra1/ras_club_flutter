
import 'package:flutter/material.dart';
import 'package:ras_club_flutter/model/GetGymBooking.dart';

import '../Booking/book_kingroom.dart';
import '../const/dashboard_cards.dart';
import '../const/dashbord_stack_container.dart';

class GymDashboard extends StatefulWidget {
  final GetGymBookingModel data;
   GymDashboard({required this.data});

  @override
  State<GymDashboard> createState() => _GymDashboardState();
}

class _GymDashboardState extends State<GymDashboard> {
  @override



  Widget build(BuildContext context) {
    return  Scaffold(



      body: Stack(
        children: [
          DashboaredStackContainer(tittle: 'Gym Bookings',gradient: linergradientgym,),
          Positioned(
              top: 130,

              child: InkWell(
                onTap:(){},

                child: Container(
                  // height: 100,width: 100,
                  height: MediaQuery.of(context).size.height
                  , width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.white,

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
                              Text('Gym',style: TextStyle1),
                              Text('${widget.data.bookings![index].duration}',style: TextStyle(fontSize: 15)),
                              SizedBox(height: 12,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Column(
                                    children: [
                                      Text('Personal Trainer',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold)),

                                      Text('${widget.data.bookings![index].pTType}',style: TextStyle(fontSize: 13),)
                                    ],
                                  ),
                                  SizedBox(width: 10,),
                                  Container(width: 2,height: 30,color: Colors.black45,),
                                  SizedBox(width: 10,),
                                  Column(
                                    children: [
                                      Text('P.Trainer Duration:',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold)),
                                      Text('${widget.data.bookings![index].pTDuration}',style: TextStyle(fontSize: 13),),
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
                                            Text('Amount'),
                                            Text('${widget.data.bookings![index].amount}'),
                                          ],
                                        ),
                                        Column(
                                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                                          children: [
                                            Text('GST'),
                                            Text('${widget.data.bookings![index].gST}'),
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
                              ),



                            ],
                          ),
                        );
                      })
                ),
              )),

        ],
      ),
    );
  }
}
