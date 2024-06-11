import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart';
import 'package:ras_club_flutter/DashBoard/accomodation_booking.dart';
import 'package:ras_club_flutter/DashBoard/game_booking.dart';
import 'package:ras_club_flutter/DashBoard/hall_booking.dart';
import 'package:ras_club_flutter/model/DashboardsModel.dart';
import 'package:ras_club_flutter/model/GetGameBookingModel.dart';
import 'package:ras_club_flutter/model/GetGymBooking.dart';
import 'package:screen_loader/screen_loader.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../DashBoard/gymbooking_dashbord.dart';
import '../DashBoard/model/GetHallBookingModel.dart';
import '../DashBoard/model/GetRoomBookingModel.dart';
import '../facilitydetails/photo_gallery.dart';
import 'constants.dart';
import 'dashboard_cards.dart';
import 'package:http/http.dart'as http;

import 'dialogueerror.dart';



class Dashbordtab extends StatefulWidget {
  const Dashbordtab({Key? key}) : super(key: key);

  @override
  State<Dashbordtab> createState() => _DashbordtabState();
}

class _DashbordtabState extends State<Dashbordtab> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getnamefunction();
  }

  getnamefunction()async{
    var sharepreference =await SharedPreferences.getInstance();
    name =sharepreference.getString(Constants.USER_NAME)!;
    photo = sharepreference.getString(Constants.Photo)??"";
    _bytesImage = Base64Decoder().convert(photo);
    setState(() {

    });
  }

  @override
  String name="";
  String photo="";
  var  _bytesImage ;
  late final navigate;


  Widget build(BuildContext context) {
    print("photo =>$photo");
    return SingleChildScrollView(
      child: Column(
        children: [
       Container(
              height: 220,
              // padding: EdgeInsets.all(15),
              width: double.infinity,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image:  AssetImage('assets/images/daahboard_background.png'),
                    fit: BoxFit.fill
                  )
              ),
              child: Row(
                // crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text('Welcome,\n ${name}',
                    style: TextStyle(fontSize: 25, color: Colors.white),),
                  Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(right: 8,top: 8,bottom: 8),
                    child: Container(
                      width: 150.0,
                      height: 150.0,

                        decoration: BoxDecoration(

                        image:photo=="" ?const DecorationImage(
                          image: AssetImage('assets/images/sample_user.png'),
                          fit: BoxFit.cover,
                        ): DecorationImage(image: MemoryImage(_bytesImage)),
                        borderRadius: BorderRadius.all(Radius.circular(75.0)),
                        border: Border.all(
                          color: Colors.white,
                          width: 4.0,
                        ),
                      ),
                    ),
                  ),

                ],
              )
          ),
          DashboardCards(colour: Color(0xff248AA3),
              tittle: 'Accomodation Bookings',
              subtittle: 'Get your all type of accomodation booking details from here',
              image: SvgPicture.asset('assets/images/ic_room.svg',color: Colors.white,),
              gradient: linergradientaccomodation,
              ontap: () {
                calldashbord(context, 1);
              }),

          DashboardCards(
            colour: Color(0xff636363),
            tittle: 'Hall Bookings',
            subtittle: 'Get your banquet hall, party hall and conference hall booking details from here',
            ontap: () {
              calldashbord(context, 2);
            },
            image: SvgPicture.asset('assets/images/ic_hall.svg',color: Colors.white,),
            gradient: linergradienthall,),

          DashboardCards(
            colour: Color(0xff3c1053),
            tittle: 'Game  Bookings',
            subtittle: 'Get your banquet gym, spa, rooftop sports and swimming booking details fromhere.',
            ontap: () {
              CircularProgressIndicator();
              calldashbord(context, 3);
            },
            image: SvgPicture.asset('assets/images/ic_games.svg',color: Colors.white,),
            gradient: linergradientgame,),
          DashboardCards(colour: Color(0xff5C6268),
              tittle: 'Gym and Spa Bookings',
              subtittle: 'Get your gym, spa and swimming  booking details from here',
             image: SvgPicture.asset('assets/images/ic_baseline_fitness_center_24.svg',color: Colors.white,),
              gradient: linergradientgym,
              ontap: () {
                calldashbord(context, 4);
              }),


        ],
      ),
    );
  }

  void AccomodationDasboadApi() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var body = {


        "mobile": prefs.getString(Constants.MOBILE_NUMBER),
        // "mobile":"9829058388"
        "memberType": prefs.getString(Constants.MEMBER_Type),

        "deviceId": "4E8EB26C-9143-49ED-B415-B67EE16A9E2F",
        "refreshToken": "sgsghdsvdhjsd",
        "hardwareDetails": "",
        "name": prefs.getString(Constants.USER_NAME),
        "membership_no": prefs.getString(Constants.MEMVERSHIP_NO),
      };
      Response response = await http.post(
          Uri.parse('https://api.rasclub.org/getRoomBookings.php'),
          headers: {
            "Accept": "application/json",
            "User-Agent": "okhttp/3.10.0",
            "Content-Type": "application/json",
            "Authorization": "Bearer ${prefs.getString(Constants.SALT)}"
            // "Authorization": "Bearer 00bc840084ff65a18294c6ebfe22a7639cce2b73a6741ecb295aefdb924f26d0f63b21544b94edaa"
          },
          body: jsonEncode(body)
      );
      Future.delayed(Duration(seconds: 4), () {
        var data = jsonDecode(response.body);
        Loader.hide();
        if (response.statusCode == 200) {


          if(data['Message']=="Unauthorized User")
            showDialog(context: context, builder: (BuildContext bc) =>
                DialogError(errorMsg: '',));
        else{
            var dashboardmodel = GetRoomBookingModel.fromJson(data);

            setState(() {
              // bookinglist = data["booking"];
            });
            if(dashboardmodel.message=="Valid User")
              Navigator.push(context, MaterialPageRoute(
                  builder: (context) => Accomodation(data: dashboardmodel,)));
          }



        } else {
          print(response.statusCode.toString());
        }
      });


    } catch (e) {
      print(e.toString());
    }
  }

  void HallBookingDasboadApi() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var body = {

        // "mobile":"9829058388",
        // "memberType": "",
        // "deviceId": "3b2d117a3f20e852",
        // "refreshToken": "sgsghdsvdhjsd",
        // "hardwareDetails": "",
        // "name": "Shantanu Srivastava",
        // "membership_no": ""
        "mobile": prefs.getString(Constants.MOBILE_NUMBER),
        "memberType": prefs.getString(Constants.MEMBER_Type),
        "deviceId": "4E8EB26C-9143-49ED-B415-B67EE16A9E2F",
        "refreshToken": "sgsghdsvdhjsd",
        "hardwareDetails": "",
        "name": prefs.getString(Constants.USER_NAME),
        "membership_no": prefs.getString(Constants.MEMVERSHIP_NO),
      };
      Response response = await http.post(
          Uri.parse('https://api.rasclub.org/getHallBookings.php'),
          headers: {
            "Accept": "application/json",
            "User-Agent": "okhttp/3.10.0",
            "Content-Type": "application/json",
      // "Authorization": "Bearer 00bc840084ff65a18294c6ebfe22a7639cce2b73a6741ecb295aefdb924f26d0f63b21544b94edaa"

      "Authorization": "Bearer ${prefs.getString(Constants.SALT)}"
          },
          body: jsonEncode(body)
      );

      Future.delayed(Duration(seconds: 4), () {
        Loader.hide();
        if (response.statusCode == 200) {
          var data = jsonDecode(response.body);

          if(data['Message']=="Unauthorized User")
            showDialog(context: context, builder: (BuildContext bc) =>
                DialogError(errorMsg: '',));
          else
            {
              var dashboardmodel = GetHallBookingModel.fromJson(data);
              setState(() {});
              Navigator.push(context, MaterialPageRoute(builder: (context) => HallBooking(data: dashboardmodel)));
            }



        } else {
          print(response.statusCode.toString());
        }
      });


    } catch (e) {
      print(e.toString());
    }
  }

  void GameBookingDasboadApi() async {
    try {

      SharedPreferences prefs = await SharedPreferences.getInstance();


      var body = {
        "mobile": prefs.getString(Constants.MOBILE_NUMBER),
        "memberType": prefs.getString(Constants.MEMBER_Type),
        "deviceId": "4E8EB26C-9143-49ED-B415-B67EE16A9E2F",
        "refreshToken": "sgsghdsvdhjsd",
        "hardwareDetails": "",
        "name": prefs.getString(Constants.USER_NAME),
        "membership_no": prefs.getString(Constants.MEMVERSHIP_NO),
      };
      Response response = await http.post(
          Uri.parse('https://api.rasclub.org/getGameBookings.php'),
          headers: {
            "Accept": "application/json",
            "User-Agent": "okhttp/3.10.0",
            "Content-Type": "application/json",
            "Authorization": "Bearer ${prefs.getString(Constants.SALT)}"
          },
          body: jsonEncode(body)
      );
      Future.delayed(Duration(seconds: 2), () {
        Loader.hide();
        if (response.statusCode == 200) {
          var data = jsonDecode(response.body);

          if(data['Message']=="Unauthorized User")
            showDialog(context: context, builder: (BuildContext bc) =>
                DialogError(errorMsg: '',));

          else{
            var dashboardmodel = GetGameBookingModel.fromJson(data);

            setState(() {
            });
            Navigator.push(context, MaterialPageRoute(
                builder: (context) => GameBooking(data: dashboardmodel,)));
          }

        } else {
          // Navigator.push(context, MaterialPageRoute(
          //     builder: (context) => GameBooking(data: dashboardmodel,)));
          print("dalid");
        }
      });

    } catch (e) {
      print(e.toString());
    }
  }
  void GymandSpaDasboadApi() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var body = {
        "mobile": prefs.getString(Constants.MOBILE_NUMBER),
        "memberType": prefs.getString(Constants.MEMBER_Type),
        "deviceId": "4E8EB26C-9143-49ED-B415-B67EE16A9E2F",
        "refreshToken": "sgsghdsvdhjsd",
        "hardwareDetails": "",
        "name": prefs.getString(Constants.USER_NAME),
        "membership_no": prefs.getString(Constants.MEMVERSHIP_NO),
      };
      Response response = await http.post(
          Uri.parse('https://api.rasclub.org/getGymBookings.php'),
          headers: {
            "Accept": "application/json",
            "User-Agent": "okhttp/3.10.0",
            "Content-Type": "application/json",
            "Authorization": "Bearer ${prefs.getString(Constants.SALT)}"
          },
          body: jsonEncode(body)
      );
      Future.delayed(Duration(seconds: 2), () {
        Loader.hide();
        if (response.statusCode == 200) {
          var data = jsonDecode(response.body);
          if(data['Message']=="Unauthorized User")
            showDialog(context: context, builder: (BuildContext bc) =>
                DialogError(errorMsg: '',));
       else{
            var dashboardmodel = GetGymBookingModel.fromJson(data);
            print("data convert success");
            setState(() {
            });
            Navigator.push(context, MaterialPageRoute(
                builder: (context) => GymDashboard(data: dashboardmodel,)));
          }

        } else {
          print(body);
        }
      });

    } catch (e) {
      print(e.toString());
    }
  }


  void calldashbord(context, id) {
    if (id == 1) {
      loaderfunction();
      AccomodationDasboadApi();
    }
    else if (id == 2) {
      loaderfunction();
      HallBookingDasboadApi();
    } else if (id == 3) {
      loaderfunction();
      GameBookingDasboadApi();
    }
    else if(id==4){
      loaderfunction();
      GymandSpaDasboadApi();
    }
  }

  loaderfunction(){
    Loader.show(context,
        isAppbarOverlay: true,
        overlayFromTop: 100,
        progressIndicator: CircularProgressIndicator(),
        themeData: Theme.of(context)
            .copyWith(colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.black38)),
        overlayColor: Color(0x99E8EAF6));

  }

}

