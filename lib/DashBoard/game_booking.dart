import 'package:flutter/material.dart';
import 'package:ras_club_flutter/const/dashboard_cards.dart';
import 'package:screen_loader/screen_loader.dart';

import 'accomodation_booking.dart';
import '../const/dashbord_stack_container.dart';

class GameBooking extends StatefulWidget {
 final data;
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
          DashboaredStackContainer(tittle: 'Games and Other Bookings',gradient: linergradientgame,),
          Positioned(
              top: 150,

              child: Container(
                height: MediaQuery.of(context).size.height, width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.white
                ),
                child: Text(""),
              ))
        ],
      ),
    );
  }
}
