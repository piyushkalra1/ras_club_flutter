import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:ras_club_flutter/Booking/book_banquet_hall.dart';
import 'package:ras_club_flutter/const/dialogueerror.dart';
import 'package:ras_club_flutter/const/pink_button.dart';
import 'package:ras_club_flutter/DashBoard/hall_booking.dart';
import 'package:ras_club_flutter/model/HallBookingModal.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Booking/book_kingroom.dart';
import '../const/constants.dart';
import '../const/custom_grey_container.dart';
import '../const/customstatic_dropdown.dart';
import '../const/tv_wifi.dart';
import 'package:http/http.dart'as http;

import '../utils.dart';




final List<String> imgList = [
  'assets/images/banquet_1.jpg',
  'assets/images/banquet_2.jpg',
  'assets/images/banquet_3.jpg',
  'assets/images/banquet_4.jpg',

];


class BanquetHallHometab extends StatefulWidget {
  const BanquetHallHometab({Key? key}) : super(key: key);

  @override
  State<BanquetHallHometab> createState() => _BanquetHallHometabState();
}

class _BanquetHallHometabState extends State<BanquetHallHometab> {
  @override
  TextEditingController dateOfFunctionController = TextEditingController();
  String timing ="Select Function Time*";
  String message ="";
  late final String halltype;

  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: false,
        title: Text('Banquet Hall'),
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
          ),
          Container(
            margin: EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Host your memorable moments in our banquet hall which can accommodate up to 600 people at one time. Our knowledgeable staff and personalised catering will add a touch of elegance to your parties and events.'),
                SizedBox(height: 15,),
                Text("Here is what we have to offer",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),

                SizedBox(height: 15,),
                Container(
                  height: 130,
                  child: Row(
                    children: [
                      TvWiBreakfast(icon: Icons.apartment,text: '1000-1200 Sq.Mt',),
                      SizedBox(width: 10,),
                      TvWiBreakfast(icon: Icons.restaurant,text: 'Pre-Menu',),
                      SizedBox(width: 10,),
                      TvWiBreakfast(icon: Icons.man_2_outlined,text: 'Upto 500',),
                    ],
                  ),

                ),
                SizedBox(height: 20,),
                Text('Make Your Banquet Hall Reservation',style: TextStyle(fontSize: 30/2,fontWeight: FontWeight.bold),),
                SizedBox(height: 10,),

                CustomGrayContainer(
                  width: MediaQuery.of(context).size.width,
                    icon: Icon(Icons.calendar_month_outlined,color: Colors.pink,),
                    child: InkWell(
                      onTap: () async {
                        DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime.now(),
                            //DateTime.now() - not to allow to choose before today.
                            lastDate: DateTime(2100));

                        if (pickedDate != null) {
                          print(
                              pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                          String formattedDate =
                          DateFormat('yyyy-MM-dd').format(pickedDate);
                          print(
                              formattedDate); //formatted date output using intl package =>  2021-03-16
                          setState(() {
                            dateOfFunctionController.text =
                                formattedDate; //set output date to TextField value.
                          });
                        }
                      },
                      child: TextField(
                          controller: dateOfFunctionController,

                          decoration: const InputDecoration(
                            hintText: "Date of Function",
                            enabled: false,

                            // hintStyle: KTextStyle.textFieldHintStyle,
                            border: InputBorder.none,
                          )),
                    )),

                CustomStaticDropdown(

                  items: ['Select Function Time*',
                  'Lunch Time 11:00 A.M. To 3:00 P.M.',
                    'Hi-Tea 4:00 P.M. To 6:00 P.M.',
                  'Dinner Time 7:00 P.M. To 11:00 P.M.'
                ], onItemSelected: (String? value) {
                  setState(() {
                    value.toString();
                    timing =value.toString();
                  });
                },),
                PinkButton(text: "Check Availability",ontap: (){
                  if(timing=='Select Function Time*'){
                    Utils.showToast('Please select function time');
                    return ;

                  }
                  else{
                    if((validateData())){
                      print("login again");
                      HallBookingApi();

                    }

                  }

                }),

              ],
            ),
          )
        ],
      ),
    );
  }
  void HallBookingApi ( ) async{
    try{
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var body ={
        "mobile":prefs.getString(Constants.MOBILE_NUMBER),
        "member_type":prefs.getString(Constants.MEMBER_Type),
        "deviceId": "4E8EB26C-9143-49ED-B415-B67EE16A9E2F",
        "refreshToken":"sgsghdsvdhjsd",
        "hardwareDetails":"",
        "name": prefs.getString(Constants.USER_NAME),
        "membership_no": prefs.getString(Constants.MEMVERSHIP_NO),
        "fdate": "${dateOfFunctionController.text}",
        "ftime" :"${timing}",
        "hall_type" :"Banquet Hall"

      };
      Response response =await http.post(Uri.parse('https://api.rasclub.org/checkHallAvailablity.php'),
          headers: {
            "Accept": "application/json",
            "User-Agent":"okhttp/3.10.0",
            "Content-Type": "application/json",
            "Authorization": "Bearer ${prefs.getString(Constants.SALT)}"
          },

          body:jsonEncode(body)
      );
      print(response.statusCode);
      if(response.statusCode==200){

        var data = jsonDecode(response.body.toString());
        print(data);
        setState(() {
          message = data["Message"].toString();
        });
        print("message =>${message}");
       if( message=="Unauthorized User")    {
         showDialog(context: context, builder: (BuildContext bc) =>
             DialogError(errorMsg: '',));
       }
      else{
         var hallbookkingModel =HallBookingModal.fromJson(data);
         print("data convert success");


         print("message");
         print(message.toString());
         showModalBottomSheet<void>(
           isScrollControlled: true,
           context: context,
           builder: (BuildContext context) {
             return Container(
               height: 280,

               decoration: const BoxDecoration(
                   borderRadius: BorderRadius.only(
                       topLeft: Radius.circular(20),
                       topRight: Radius.circular(20)
                   )
               ),
               child: Center(
                 child:  Column(

                   children: <Widget>[
                     Container(height: 120,
                       decoration: const BoxDecoration(
                           borderRadius: BorderRadius.only(
                               topLeft: Radius.circular(20),
                               topRight: Radius.circular(20)

                           ),
                           color: Colors.black12
                       ),
                       child: Center(
                         child: Column(
                           children: [
                             SizedBox(height: 13,),
                             if(hallbookkingModel.availablity=="Available")...{

                               CircleAvatar(
                                 backgroundColor: Colors.green,
                                 child: IconButton(

                                   icon: Icon(Icons.check,color: Colors.white,),
                                   onPressed: () {},
                                 ),
                               ),
                             }else...{
                               CircleAvatar(
                                 backgroundColor: Colors.red,
                                 child: IconButton(

                                   icon: Icon(Icons.close,color: Colors.white,),
                                   onPressed: () {
                                     Navigator.pop(context);
                                   },
                                 ),
                               ),
                             },


                             SizedBox(height: 12,),
                             Text('Banquet Hall',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
                           ],
                         ),
                       ),
                     ),
                     Column(
                       children: [
                         Text('Function Date   : ',style: TextStyle(fontSize: 15),),
                         Text(' ${dateOfFunctionController.text}',style: TextStyle1,)
                       ],
                     ),

                     Column(
                       children: [
                         Text('Function Time  : ',style: TextStyle(fontSize: 15),),
                         Text('${timing}',style: TextStyle1,)
                       ],
                     ),






                     if(hallbookkingModel.availablity=="Available")...{
                       InkWell(
                         onTap: (){
                           Navigator.push(context, MaterialPageRoute(builder: (context)=>BookBanquet( time: timing, dateOfFunctionController: dateOfFunctionController, halltype: 'Banquet Hall',
                             hallbookkingModel: HallBookingModal.fromJson(data),)));

                         },
                         child: Container(
                           height: 40,
                           color: Colors.green,
                           width: double.infinity,
                           // margin: EdgeInsets.symmetric(vertical: 8),
                           child: Center(child: Text('Book Now',style: TextStyle(fontSize: 20,color: Colors.white),)),
                         ),
                       )
                     }
                     else
                       Container(
                         height: 40,
                         color: Colors.red,
                         width: double.infinity,
                         margin: EdgeInsets.symmetric(vertical: 8),
                         child: Center(child: Text('Not Avialable',style: TextStyle(fontSize: 20,color: Colors.white),)),
                       )




                   ],
                 ),
               ),
             );
           },
         );
       }

      }else
      {
        CircularProgressIndicator();
      }
    }catch(e){
      print(e.toString());
    }
  }

  bool validateData() {
    if (dateOfFunctionController.text.isEmpty || timing.toString()=='Select Function Time*') {
      Utils.showToast("Please Enter function date ");
      return false;
    } else if (timing.toString()=='Select Function Time*') {
      Utils.showToast("Please choose your function timing");
      return false;
    }
    return true;
  }


}
