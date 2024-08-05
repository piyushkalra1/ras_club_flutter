import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:ras_club_flutter/Booking/bookconferencehall.dart';
import 'package:ras_club_flutter/const/pink_button.dart';
import 'package:ras_club_flutter/model/ConferenceHallModel.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart'as http;
import '../Booking/book_kingroom.dart';
import '../const/dialogueerror.dart';
import 'PARTYHALL/partyhall_booling.dart';
import '../const/constants.dart';
import '../const/custom_grey_container.dart';
import '../const/customstatic_dropdown.dart';
import '../const/tv_wifi.dart';
import '../model/PartyhallBookingModel.dart';
import '../utils.dart';




final List<String> imgList = [
  'assets/images/conference_1.jpg',
  'assets/images/conference_2.jpg',
  'assets/images/conference_3.jpg',
  'assets/images/conference_4.jpg',
  'assets/images/conference_5.jpg',

];

class ConfereceHometab extends StatefulWidget {
  const ConfereceHometab({Key? key}) : super(key: key);

  @override
  State<ConfereceHometab> createState() => _ConfereceHometabState();
}

class _ConfereceHometabState extends State<ConfereceHometab> {
  @override
  TextEditingController dateOfFunctionController = TextEditingController();
  String timing ="Select Function Time*";
  String message ="";

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: false,
        title: Text('Conference Hall'),
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
                const Text('The conference room sets the stage for building relationships, exchanging creative ideas and making breakthroughs all the more possible through networking...\n'
                    'and RAS Club means business by providing a professional work environment that can accommodate up to 350 people. Our vibrant conference room fulfills long held aspiration for a centrally located meeting place in Jaipur where bureaucrats, corporate, investors and like segments of the society can come together for a fruitful convention, seminars, training etc.\n'
                    'Our conference hall can also be divided into 3 parts facilitating creative, effective and dynamic use of the space.'),
                SizedBox(height: 15,),
                Text("Here is what we have to offer",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),

                SizedBox(height: 15,),
                Container(
                  height: 130,
                  child: Row(
                    children: [
                      TvWiBreakfast(icon: Icons.apartment,text: '300-320 Sq.Mt.',),
                      SizedBox(width: 10,),
                      TvWiBreakfast(icon: Icons.restaurant,text: 'Pre-Menu',),
                      SizedBox(width: 10,),
                      TvWiBreakfast(icon: Icons.man_2_outlined,text: 'Upto 100',),
                    ],
                  ),

                ),
                SizedBox(height: 20,),
                Text('Make Your Conference Hall Reservation',style: TextStyle(fontSize: 30/2,fontWeight: FontWeight.bold),),
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
                          DateFormat('dd-MM-yyyy').format(pickedDate);
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
                    'Dinner Time 7:00 P.M. To 11:00 P.M.',
                  ], onItemSelected: (String? value) {
                  setState(() {
                    value.toString();
                    timing =value.toString();
                  });
                },),
                PinkButton(text: "Check Availability",ontap: (){
                  if(timing=='Select Function Time*' ){
                    Utils.showToast('Please select function time');
                    return ;

                  }
                  else{
                    if((validateData()))
                      ConferenceHallBookingApi();
                  }

                }),

              ],
            ),
          )
        ],
      ),
    );
  }

  void ConferenceHallBookingApi ( ) async{
    try{
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var body ={
        "mobile":prefs.getString(Constants.MOBILE_NUMBER),
        "member_type":prefs.getString(Constants.MEMBER_Type),
        // "member_type":"outsider",
        "deviceId": "4E8EB26C-9143-49ED-B415-B67EE16A9E2F",
        "refreshToken":"sgsghdsvdhjsd",
        "hardwareDetails":"",
        "name": prefs.getString(Constants.USER_NAME),
        "membership_no": prefs.getString(Constants.MEMVERSHIP_NO),
        "fdate": "${dateOfFunctionController.text}",
        "ftime" :"${timing}",
        "hall_type" :"Conference Hall"

      };
      print(body);
      Response response =await http.post(Uri.parse('https://api.rasclub.org/checkHallAvailablity.php'),
          headers: {
            "Accept": "application/json",
            "User-Agent":"okhttp/3.10.0",
            "Content-Type": "application/json",
            "Authorization": "Bearer ${prefs.getString(Constants.SALT)}"
          },

          body:jsonEncode(body)
      );
      print("${prefs.getString(Constants.SALT)}");
      if(response.statusCode==200){
        var data = jsonDecode(response.body);

        setState(() {
          message = data["Message"].toString();
        });
        if( message=="Unauthorized User")    {
          showDialog(context: context, builder: (BuildContext bc) =>
              DialogError(errorMsg: '',));
        }
     else{
          var conferencehallbookkingModel =ConferenceHallModel.fromJson(data);
          print("data convert success");

          setState(() {
          });
          // ignore: use_build_context_synchronously
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
                              if(conferencehallbookkingModel.availablity=="Available")...{

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


                              Text('Conference Hall',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
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






                      if(conferencehallbookkingModel.availablity=="Available")...{
                        InkWell(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>ConferenceHallBooking( time: timing, dateOfFunctionController: dateOfFunctionController, halltype: 'Conference Hall', conferencehallBookingModel: PartyhallBookingModel.fromJson(data),)));

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
                          child: Center(child: Text('Not Available',style: TextStyle(fontSize: 20,color: Colors.white),)),
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
        print("dalid");
        print(response.statusCode.toString());
        print(body);
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



