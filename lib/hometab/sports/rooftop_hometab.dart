import 'dart:convert';
import 'dart:math';

import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:ras_club_flutter/hometab/sports/sportbookingdetails.dart';
import 'package:ras_club_flutter/model/SportsModel.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart'as http;
import '../../Booking/book_kingroom.dart';
import '../../const/dialogueerror.dart';
import '../PARTYHALL/partyhall_booling.dart';
import '../../const/constants.dart';
import '../../const/custom_grey_container.dart';
import '../../const/customstatic_dropdown.dart';
import '../../const/pink_button.dart';
import '../../model/PartyhallBookingModel.dart';
import '../../utils.dart';

class RooftopHometab extends StatefulWidget {
  const RooftopHometab({Key? key}) : super(key: key);

  @override
  State<RooftopHometab> createState() => _RooftopHometabState();
}

class _RooftopHometabState extends State<RooftopHometab> {
  @override
  TextEditingController dateOfFunctionController = TextEditingController();
  String timezone ='Select Time Slot*';
  String month = 'Select Month*';
  String memberfee ="";
  String nonmemberfee ="";
  int radiotittle= -1 ;
  int radiotittle1 =-1;
  String message ="";
  List<String> gaming =['Badminton','Squash','Tennis'];
  List<String> type =['Playing', 'Coaching'];
  List<String>playingtime= ['Select Time Slot*',
    '6:00 A.M. To 7:00 A.M.',
    '7:00 A.M. To 8:00 A.M.',
    '8:00 A.M. To 9:00 A.M.', '9:00 A.M. To 10:00 A.M.',
    '7:00 P.M. To 8:00 P.M.','8:00 P.M. To 9:00 P.M.',
  ];
  List<String>coachingtime = ['Select Time Slot*',
    '4:00 P.M. To 5:00 P.M.','5:00 P.M. To 6:00 P.M.','6:00 P.M. To 7:00 P.M.',
  ];

  late List<String> timeDropdown = playingtime;

  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: false,
        title: Text('Rooftop Sports'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),

              ),
              child: Container(
                height: 250,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  image: DecorationImage(
                    image: AssetImage('assets/images/rooftopsports_2.jpg'),
                    fit: BoxFit.fill,
                  )
                ),
              )
            ),
            Container(
              margin: EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("RAS Club extends unparalleled experience of playing 'infinity tennis' - we proudly call our rooftop tennis courts overlooking the Jhalana hills, first 'Infinity Tennis Courts' in Rajasthan! At the same time, you can also enjoy the bird's eye view of pink city while playing a game of tennis atop a 6-storey building.\n\n"
                      "You can also enjoy playing badminton or sweat it out on our state of the art indoor Badminton and Squash courts and Table Tennis.\n\n"
                      "You are welcome to flex your muscles and loosen up your nerves with any sport anytime. It can be as friendly or competitive as you wish, but the emphasis tends to be about having fun and playing as part of an active social life"),
                  SizedBox(height: 15,),
                  Center(child: Text("Book Your sport's slot here",style: TextStyle1)),

                  SizedBox(height: 15,),
                  Text('Select Game:',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
                  ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (bc,i)=>RadioListTile(
                      controlAffinity: ListTileControlAffinity.leading,
                      title: Text(gaming[i]),
                      value: i,
                      onChanged: (radiovalue) {
                        print(gaming[i]);
                        setState(() {
                          radiotittle = i;

                        });
                      },
                      groupValue: radiotittle,
                    ),
                    itemCount: gaming.length,


                  ),
                  Text('What do you want to do ?',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
                  ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (bc,i)=>RadioListTile(
                      controlAffinity: ListTileControlAffinity.leading,
                      title: Text(type[i]),
                      value: i,
                      onChanged: (radiovalue) {

                        print(type[i]);
                        if(i == 0){
                          timeDropdown = playingtime;
                        }
                        else{
                          timeDropdown = coachingtime;
                        }
                        setState(() {
                          radiotittle1 = i;

                        });
                      },
                      groupValue: radiotittle1,
                    ),
                    itemCount: type.length,


                  ),


                  CustomStaticDropdown(

                    items: ['Select Month*',
                      'January 2024',"Feburary 2024",'March 2024','April 2024','May 2024', 'June 2024', 'July 2024', 'August 2024',
                      'September 2024', 'October 2024' , 'November 2024', 'December 2024',
                    ], onItemSelected: (String? value) {
                    setState(() {
                      value.toString();
                      month =value.toString();
                    });
                  },),
                  SizedBox(height: 30,),
                  CustomStaticDropdown(
                    key: ValueKey(timeDropdown.length),
                    items:timeDropdown, onItemSelected: (String? value) {
                    setState(() {
                      value.toString();
                      timezone =value.toString();
                    });
                  },),
                  PinkButton(text: "Check Availablity",ontap: (){
                    if(timezone=='Select Time Slot*' ){
                      Utils.showToast('Please select time');
                      print('hii');
                      return ;

                    }else if( month =='Select Month*'){
                      Utils.showToast('Please select month');
                    }else if(radiotittle ==-1 ){
                      Utils.showToast('Please select game');
                    }else if(radiotittle1 ==-1 ){
                      Utils.showToast('Please select status');
                    }
                    else{

                      RooftopBookingApi();
                      if((validateData())
                      );
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


  bool validateData() {
    if (month.isEmpty || month.toString()=='Select Month*') {
      Utils.showToast("Please Select month ");
      return false;
    } else if (timezone=='Select Time Slot*') {
      Utils.showToast("Please Select Time Slot");
      return false;
    }
    return true;
  }

  void RooftopBookingApi ( ) async{
    Random rand = new Random();
    int rand_int1 = rand.nextInt(1000000);
    String orderId = "Order #RZP"+rand_int1.toString();
    try{
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var body ={
        "mobile":prefs.getString(Constants.MOBILE_NUMBER),
        "member_type":prefs.getString(Constants.MEMBER_Type),
        "member_type":"outsider",
        "deviceId": "4E8EB26C-9143-49ED-B415-B67EE16A9E2F",
        "refreshToken":"sgsghdsvdhjsd",
        "hardwareDetails":"aVBob25lIDExI2lPUyMxNi4yI2lQaG9uZSNpUGhvbmUjNEU4RUIyNkMtOTE0My00OUVELUI0MTUtQjY3RUUxNkE5RTJGI2ZhbHNlI0RhcndpbiNQaXl1c2hzLU1hY0Jvb2stUHJvLmxvY2FsIzIxLjYuMCNEYXJ3aW4gS2VybmVsIFZlcnNpb24gMjEuNi4wOiBXZWQgQXVnIDEwIDE0OjI4OjI1IFBEVCAyMDIyOyByb290OnhudS04MDIwLjE0MS41fjIvUkVMRUFTRV9BUk02NF9UODExMCNpUGhvbmUxMCw0",
        "name": prefs.getString(Constants.USER_NAME),
        "membership_no": prefs.getString(Constants.MEMVERSHIP_NO),
      "game":"${gaming[radiotittle]}",
      "type" :"${type[radiotittle1]}",
      "month":"${month}",
      "time_slot" :"${timezone}",

      };
      print(body);
      Response response =await http.post(Uri.parse('https://api.rasclub.org/checkSportsAvailablity.php'),
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
        setState(() {
          message = data["Message"].toString();
        });
        if( message=="Unauthorized User")    {
          showDialog(context: context, builder: (BuildContext bc) =>
              DialogError(errorMsg: '',));
        }
        else{
          var gamingModel =SportsModel.fromJson(data);
          print("data convert success");
          print('1234e4');
          print(response.body);
          setState(() {
            memberfee = gamingModel.feesMember.toString();
            nonmemberfee = gamingModel.feesNonMember.toString();
          });
          showModalBottomSheet<void>(

            isScrollControlled: true,
            context: context,
            builder: (BuildContext context) {
              return Container(
                height: 350,

                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20)
                    )
                ),
                child: Center(
                  child:  Column(

                    children: <Widget>[
                      Container(height: 160,
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
                              if(gamingModel.availablity=="Available")...{

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
                              Text('${gaming[radiotittle]} - ${type[radiotittle1]}',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
                            ],
                          ),
                        ),
                      ),
                      Column(
                        children: [
                          Text('Month',style: TextStyle(fontSize: 15),),
                          Text(' ${month}',style: TextStyle1,)
                        ],
                      ),

                      Column(
                        children: [
                          Text('Time Slot ',style: TextStyle(fontSize: 15),),
                          Text('${timezone}',style: TextStyle1,)
                        ],
                      ),


                      Column(
                        children: [
                          Text('Fees',style: TextStyle(fontSize: 15),),
                          Text('${nonmemberfee}',style: TextStyle1,)
                        ],
                      ),




                      if(gamingModel.availablity=="Available")...{
                        InkWell(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>SportDetails(month: "${month}", timeslot: "${timezone}",feesamount: "${nonmemberfee}",orderno: '${orderId.toString()}',)));
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
        print("dalid");
        print(response.statusCode.toString());
        print(body);
      }
    }catch(e){
      print(e.toString());
    }
  }

}
