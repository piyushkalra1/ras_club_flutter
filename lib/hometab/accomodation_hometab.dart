import 'dart:async';
import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:http/http.dart'as http;
import 'package:lottie/lottie.dart';

import 'package:ras_club_flutter/Booking/book_kingroom.dart';
import 'package:ras_club_flutter/Booking/book_twinbedroom.dart';
import 'package:ras_club_flutter/Booking/luxuryroom_booking.dart';
import 'package:ras_club_flutter/const/attentionDialogue.dart';
import 'package:ras_club_flutter/login/login_screen.dart';
import 'package:ras_club_flutter/model/RoomRateModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../const/apilistview_horizontal.dart';
import '../const/dialogueerror.dart';
import '../const/tv_wifi.dart';
import '../const/constants.dart';


final List<String> imgList = [
  'assets/images/luxurysuiteroom_1.jpg',
  'assets/images/luxurysuiteroom_2.jpg',
  'assets/images/luxurysuiteroom_3.jpg',
  'assets/images/luxurysuiteroom_4.jpg',
  'assets/images/twinbeddedroom_1.jpg',
  'assets/images/twinbeddedroom_2.jpg',
  'assets/images/twinbeddedroom_3.jpg',
'assets/images/twinbeddedroom_4.jpg',
  'assets/images/kingsizeroom_2.jpg',
  'assets/images/kingsizeroom_3.jpg',
  'assets/images/kingsizeroom_1.jpg',


];


class AccomodationHometab extends StatefulWidget {
  const AccomodationHometab({Key? key}) : super(key: key);

  @override
  State<AccomodationHometab> createState() => _AccomodationHometabState();
}

class _AccomodationHometabState extends State<AccomodationHometab> {

  String kingsizeroomprice="";
  String twinbeddedroomprice="";
  String luxurysuiteprice="";
  String message ="";


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    AccomodationApi();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: false,
        title:Text('Accomodation')
      ),

      body: ListView(
        children: [
          Container(
            margin: EdgeInsets.all(10),
            child: ClipRRect(
              borderRadius: BorderRadius.only(topRight:Radius.circular(18) ,topLeft: Radius.circular(18),
              bottomRight: Radius.circular(18),bottomLeft: Radius.circular(18)
              ),

              child: CarouselSlider(
                options: CarouselOptions(
                    height: 300.0,
                    autoPlay: true,
                    viewportFraction: 1,
                    onPageChanged: (index, reason) {
                      // setState(() {
                      //   incrementIndex();
                      // });
                    }),
                items: [0, 1, 2,3,4,5,6,7,8,9].map((i) {
                  return Builder(
                    builder: (BuildContext context) {
                      return
                        Image.asset(

                          imgList[i],
                          fit: BoxFit.fill,
                        );
                    },
                  );
                }).toList(),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('RAS Club brings to you a world full of dreams that is designed to complements the moments of life with the plush service suites. Offering a cache of 41 rooms and suites to guests of members at a very reasonable tariff. Be it ultra modern amenities, meticulously designed interior, grand architecture, designing of spaces or balance between art and functionality.'),
                SizedBox(height: 15,),
                Text("Here is what we have to offer",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
                SizedBox(height: 15,),
                Text('Get ready for classic and inspired life where opulence and comfort go hand in hand.'),
                SizedBox(height: 15,),
                Container(
                  height: 130,
                  child: Row(
                    children: [
                      TvWiBreakfast(icon: Icons.wifi,text: 'Wi-Fi',),
                      SizedBox(width: 10,),
                      TvWiBreakfast(icon: Icons.tv,text: 'Tv',),
                      SizedBox(width: 10,),
                      TvWiBreakfast(icon: Icons.free_breakfast,text: 'Breakfast',),
                    ],
                  ),
                  
                ),
                SizedBox(height: 20,),
                Text('Room Types',style: TextStyle(fontSize: 30/2,fontWeight: FontWeight.bold),),
                SizedBox(height: 10,),

                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      ApiListviewHorizontal(tittle: 'King Size Room',thumbnail: AssetImage(
                        'assets/images/kingsizeroom_3.jpg',
                      ), text1: '24-26 Sq.Mt. Area',text2: "Sofa and Table",
                        rate:"${kingsizeroomprice}", ontap:(){
                        if(message=="Unauthorized User"){
                          showDialog(context: context, builder: (BuildContext bc) =>
                              DialogError(errorMsg: '',));
                        }
                        else
                          showDialog(context: context, builder: (BuildContext bc) =>
                              DialogAttention(
                                ontap: ()async{
                                  Navigator.pop(context);
                                 await Navigator.push(context, MaterialPageRoute(builder: (context)=>BookKingRoom(roomtype: 'King Size Room',)));

                                },));
                        } , ),
                      ApiListviewHorizontal(tittle: 'Twin Bedded Room',thumbnail: AssetImage(
                        'assets/images/twinbeddedroom_1.jpg',
                      ),text1: '30-35 Sq.Mt. Area',text2: "Toiletries",
                        rate:twinbeddedroomprice, ontap: (){
                          if(message=="Unauthorized User"){

                            showDialog(context: context, builder: (BuildContext bc) =>
                                DialogError(errorMsg: '',));
                          }else
                            showDialog(context: context, builder: (BuildContext bc) =>
                                DialogAttention(
                                  ontap: ()async{
                                    Navigator.pop(context);
                                   await Navigator.push(context, MaterialPageRoute(builder: (context)=>BookTwinBed(roomtype: 'Twin Bedded Room',)));

                                  },));

                        },
                      ),
                      ApiListviewHorizontal(tittle: 'Luxury Suite',thumbnail: AssetImage(
                        'assets/images/luxurysuiteroom_5.jpg',
                      ),text1: '30-35 Sq.Mt. Area',text2: "Sofa and Table",
                        rate: luxurysuiteprice, ontap: (){
                          if(message=="Unauthorized User"){

                            showDialog(context: context, builder: (BuildContext bc) =>
                                DialogError(errorMsg: '',));
                          }else{

                            showDialog(context: context, builder: (BuildContext bc) =>
                                DialogAttention(
                                  ontap: ()async{
                                    Navigator.pop(context);
                                  await  Navigator.push(context, MaterialPageRoute(builder: (context)=>LuxuryRoomBooking(roomtype: 'Luxury Suite',)));

                                  },));

                          }


                        },
                      ),
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  void AccomodationApi ( ) async{
    try{
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var body ={
        "mobile":prefs.getString(Constants.MOBILE_NUMBER),
        "memberType":prefs.getString(Constants.MEMBER_Type),
        "deviceId": "4E8EB26C-9143-49ED-B415-B67EE16A9E2F",
        "refreshToken":"sgsghdsvdhjsd",
        "hardwareDetails":"",
      };
      Response response =await http.post(Uri.parse('https://api.rasclub.org/getRoomRates.php'),
          headers: {
            "Accept": "application/json",
            "User-Agent":"okhttp/3.10.0",
            "Content-Type": "application/json",
            "Authorization": "Bearer ${prefs.getString(Constants.SALT)}"
          },

          body:jsonEncode(body)
      );
      if(response.statusCode==200){
        var data = jsonDecode(response.body.toString());
        print(data);
       var roomRateModel =RoomRateModel.fromJson(data);
       setState(() {
         message= data["Message"].toString();
         kingsizeroomprice=roomRateModel.rateKingSizeRoom! +" /Night";
         luxurysuiteprice =roomRateModel.rateLuxurySuite!+" /Night";
         twinbeddedroomprice =roomRateModel.rateTwinBeddedRoom!+" /Night";
       });
      }else
      {
        print("dalid");
      }
    }catch(e){
      print(e.toString());
    }
  }
}







