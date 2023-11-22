import 'dart:convert';
import 'dart:math';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:ras_club_flutter/Booking/gymbooking_details.dart';
import 'package:ras_club_flutter/const/constants.dart';
import 'package:ras_club_flutter/model/GymModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Booking/book_kingroom.dart';
import '../const/customstatic_dropdown.dart';
import '../const/image_list.dart';
import '../const/pink_button.dart';
import '../utils.dart';
import 'package:http/http.dart'as http;
class GymHometab extends StatefulWidget {
  const GymHometab({Key? key}) : super(key: key);

  @override
  State<GymHometab> createState() => _GymHometabState();
}

class _GymHometabState extends State<GymHometab> {

  @override
  TextEditingController dateOfFunctionController = TextEditingController();
  String timezone ='Select Time Slot*';
  String month = 'Select Month*';
  String gymfees ="";
  String ptfees ="";
  String tottalfees ="";
  int durationindex= -1 ;
  int ptdurationindex =-1;
  int ptrequirementindex =-1;
  List<String>duration =['1 Day','1 Month','3 Months' , '6 Months' , '12 Months' , '12 Months for Couple'];
  List<String> ptduration =['Not Required','1 Month','3 Months' , '6 Months' , '12 Months'  ];
  
  List<String> ptrequirement = ['Not Required', 'Regular' , 'Alternate'];




  Widget build(BuildContext context) {

    return  Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: false,
        title: Text('Gym and Spa'),
      ),
      body: SingleChildScrollView(
        child: Column(
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
                            gymimgList[i],

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
                  Text("Wake up, breathe in, breathe out, flex your muscles, feel your being and live moments of life that surpass the limitations of routine and the mundane. At RAS Club you will be able to work out at the well-furnished air-conditioned gym and enjoy an extensive range of new equipment's. These equipment's in a green surrounding satiate those seeking rejuvenation through high energy workout.\n\n"
                      "Relax, refresh and rejuvenate at RAS Club Spa where you can choose a body massage and Spa treatment. Our highly trained therapists will pamper you for your vigorous health. Our first goal is to understand your needs and then we aim to fulfil those needs and exceed your expectations. Let us take you on a journey, you choose the treatment which appeals the most to you and we will bespeak it, in the healing touch of expert hands.\n\n"
                      ),
                  SizedBox(height: 15,),
                  Center(child: Text("Book Your Gym and Spa here",style: TextStyle1)),

                  SizedBox(height: 15,),
                  Text('Select Duration:',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
                  ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (bc,i)=>RadioListTile(
                      controlAffinity: ListTileControlAffinity.leading,
                      title: Text(duration[i]),
                      value: i,
                      onChanged: (radiovalue) {
                        print(duration[i]);
                        setState(() {
                          durationindex = i;

                        });
                      },
                      groupValue: durationindex,
                    ),
                    itemCount: duration.length,


                  ),
                  Text('Do you want a personal trainer?',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
                  ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (bc,i)=>RadioListTile(
                      controlAffinity: ListTileControlAffinity.leading,
                      title: Text(ptduration[i]),
                      value: i,
                      onChanged: (radiovalue) {
                        print(ptduration[i]);
                        setState(() {
                          ptdurationindex = i;

                        });
                      },
                      groupValue: ptdurationindex,
                    ),
                    itemCount: ptduration.length,


                  ),
                  Text('Personal trainer required for daily or alternate?',style: TextStyle1,),
                  ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (bc,i)=>RadioListTile(
                      controlAffinity: ListTileControlAffinity.leading,
                      title: Text(ptrequirement[i]),
                      value: i,
                      onChanged: (radiovalue) {
                        print(ptrequirement[i]);
                        setState(() {
                          ptrequirementindex = i;

                        });
                      },
                      groupValue: ptrequirementindex,
                    ),
                    itemCount: ptrequirement.length,


                  ),




                  PinkButton(text: "Check Availablity",ontap: (){
                     if(durationindex ==-1 ){
                      Utils.showToast('Please select duration');
                    }else if(ptdurationindex ==-1 || ptrequirementindex ==-1){
                      Utils.showToast('Please select trainer details');
                    }
                    else{
                      GymApi();
                      print('hiiiii');
                      // if((validateData()))
                    }

                  }),

                ],
              ),
            )
          ],
        ),
      ),
    );
  }
  void GymApi ( ) async{
    Random rand = new Random();
    int rand_int1 = rand.nextInt(1000000);
    String orderId = "Order #RZP"+rand_int1.toString();
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
        "duration":duration[durationindex],
        "pt_duration" :ptduration[ptdurationindex],
        "pt_type":ptrequirement![ptrequirementindex],

      };
      print(body);
      Response response =await http.post(Uri.parse('https://api.rasclub.org/checkGymPrices.php'),
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
        print(data);
        print(body);
        var gymfeemodel =GymModel.fromJson(data);
        print("data convert success");
        print(response);
        setState(() {

          ptfees =gymfeemodel.pTFees.toString();
          gymfees =gymfeemodel.gymFees.toString();
          tottalfees =gymfeemodel.totalFees.toString();
        });

        // ignore: use_build_context_synchronously
        showModalBottomSheet<void>(
          isScrollControlled: true,
          context: context,
          builder: (BuildContext context) {
            return Container(
              height: 245,
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20)
                  )
              ),
              child: Center(
                child:  Column(

                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 8),
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

                            Text('Gym Prices',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
                          ],
                        ),
                      ),
                    ),
                    Column(
                      children: [
                        Text(' Duration  ',style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500)),
                        Text(' ${duration[durationindex]}',style: TextStyle(fontSize: 20,fontWeight:FontWeight.w700),)
                      ],
                    ),

                    Column(
                      children: [
                        Text('Personal Trainer ',style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500),),
                        Text('${ptrequirement[ptrequirementindex]}',style: TextStyle1,)
                      ],
                    ),

                    Column(
                      children: [
                        Text('Total Fees  ',style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500),),
                        Text(tottalfees,style: TextStyle1,)
                      ],
                    ),






                    if(gymfeemodel.message=="Valid User")...{
                      InkWell(
                        onTap: (){
                          print(orderId);
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>GymBookingDetails(duration: duration[durationindex], trainer: ptrequirement![ptrequirementindex], pttime: ptduration![ptdurationindex], fees: double.parse(tottalfees) ,orderid: orderId,

                          )));
                          // Navigator.push(context, MaterialPageRoute(builder: (context)=>ConferenceHallBooking( time: timing, dateOfFunctionController: dateOfFunctionController, halltype: 'Conference Hall', conferencehallBookingModel: PartyhallBookingModel.fromJson(data),)));

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
}
