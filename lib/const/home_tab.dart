import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
import 'package:http/http.dart';
import 'package:ras_club_flutter/facilitydetails/about_us.dart';
import 'package:ras_club_flutter/const/specialityicons.dart';
import 'package:ras_club_flutter/hometab/Conference_hall_tab.dart';
import 'package:ras_club_flutter/hometab/accomodation_hometab.dart';
import 'package:ras_club_flutter/hometab/PARTYHALL/party_hall_hometab.dart';
import 'package:ras_club_flutter/facilitydetails/membership.dart';
import 'package:ras_club_flutter/facilitydetails/photo_gallery.dart';
import 'package:ras_club_flutter/facilitydetails/rooftop_sports.dart';
import 'package:ras_club_flutter/facilitydetails/swimming_pool.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../facilitydetails/cafe_and_longue.dart';
import '../hometab/gymhometab.dart';
import '../hometab/sports/rooftop_hometab.dart';
import 'constants.dart';
import '../facilitydetails/gym_and_spa.dart';
import '../homepage.dart';
import '../hometab/banquet_hall_hometab.dart';
import '../facilitydetails/resturent_and_bar.dart';
import 'facility_card.dart';
final List<String> imgList = [
  'assets/images/banner1.jpg',
  'assets/images/banner2.jpg',
  'assets/images/banner3.jpg',
  'assets/images/banner4.jpg',
];

class hometab extends StatelessWidget {
   hometab({
    super.key,
  });



  @override
  bool loading =false;
  Widget build(BuildContext context) {
    return

      ListView(

      children: [
        Container(
          height: 125,
          child: ListView(
            scrollDirection: Axis.horizontal,

            children:  [
              SpecilityIcon(colour: Colors.blue.shade200,tittle: 'Cafe and\n Loungue',thumbnail:const Image(image: AssetImage('assets/images/icon_cafe.png')), ontap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>CafeandLoungue()));
              } ,),
              SpecilityIcon(colour: Colors.greenAccent.shade200,tittle: 'Restaurant \nand Bar',thumbnail:const Image(image: AssetImage('assets/images/icon_restaurant.png')), ontap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>RestaurentandBar()));
              },),
              SpecilityIcon(ontap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>GymandSpa()));

              },colour: Colors.purple.shade100,tittle: 'Gym and \n Spa',thumbnail:const Image(image: AssetImage('assets/images/icon_gym.png')) ,),
              SpecilityIcon(ontap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>SwimmingPool()));
              },colour: Colors.deepOrangeAccent.shade100,tittle: 'Swimming \n Pool',thumbnail:const Image(image: AssetImage('assets/images/icon_swimming.png')) ,),
              SpecilityIcon(ontap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>RooftopSports()));
              },colour: Colors.purple.shade200,tittle: 'Rooftop \nSports',thumbnail:const Image(image: AssetImage('assets/images/icon_rooftop.png')) ,),
              SpecilityIcon(ontap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>Membership()));
              },colour: Colors.orangeAccent.shade100,tittle: 'Membership ',thumbnail:const Image(image: AssetImage('assets/images/icon_membership.png')) ,),
              SpecilityIcon(ontap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>PhotoGallery()));

              },colour: Colors.greenAccent.shade200,tittle: 'Photo \n Gallery',thumbnail:const Image(image: AssetImage('assets/images/icon_gallery.png')) ,),
              SpecilityIcon(ontap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>AboutUS()));
              },colour: Colors.blueGrey.shade200,tittle: 'About Us',thumbnail:const Image(image: AssetImage('assets/images/icon_about.png')) ,),

            ],
          ),
        ),
        Container(
          height: 250,
          child: CarouselSlider(
            options: CarouselOptions(
                height: 250.0,
                autoPlay: true,
                viewportFraction: 1,
                onPageChanged: (index, reason) {
                  // setState(() {
                  //   incrementIndex();
                  // });
                }),
            items: [0, 1, 2,3].map((i) {
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
        Container(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Welcome to RAS Club!',textAlign: TextAlign.start,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 24),),
              const Text('RAS club brings to you a world full of dreams that is designed to complement the moments of life with the plus service suites.')
            ],
          ),
        ),
        Container(
          color: Colors.grey.shade200,
          padding: const EdgeInsets.all(8),
          child: const Text(
            'A perfect getway from tedium of life',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),
          ),
        ),

        Row(
          children: [
            FacilityCards(thumbnail: 'assets/images/img2.jpg',ontap: (){
             Navigator.push(context, MaterialPageRoute(builder: (context)=>AccomodationHometab()));
            },tittle: 'Accomodation',),
            FacilityCards(thumbnail: 'assets/images/banquet_3.jpg',ontap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>BanquetHallHometab()));
            },tittle: 'Banquet Hall',),

          ],
        ),
        SizedBox(height: 10,),
        Row(
          children: [

            FacilityCards(thumbnail: 'assets/images/banquet_4.jpg',ontap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>PartyHallHomeTab()));

            },tittle: 'Party Hall',),
            FacilityCards(thumbnail: 'assets/images/conference_3.jpg',ontap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>ConfereceHometab()));

            },tittle: 'Conference Hall',),
          ],
        ),
        SizedBox(height: 10,),
        Row(
          children: [

            FacilityCards(thumbnail: 'assets/images/rooftopsports_2.jpg',ontap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>RooftopHometab()));

            },tittle: 'Rooftop Sports',),
            FacilityCards(thumbnail: 'assets/images/gym_1.jpg',ontap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>GymHometab()));

            },tittle: 'Gym and  SPA',),
          ],
        ),


      ],
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

       }else
       {
         print("dalid");
       }
     }catch(e){
       print(e.toString());
     }
   }

}