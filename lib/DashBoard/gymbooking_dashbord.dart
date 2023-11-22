
import 'package:flutter/material.dart';

import '../const/dashboard_cards.dart';
import '../const/dashbord_stack_container.dart';

class GymDashboard extends StatefulWidget {
  final data;
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
          DashboaredStackContainer(tittle: 'Gym and Spa Bookings',gradient: linergradientgym,),
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
                  child: Text(""),
                ),
              )),

        ],
      ),
    );
  }
}
