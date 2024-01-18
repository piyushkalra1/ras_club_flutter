import 'dart:convert';
import 'dart:math';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:ras_club_flutter/Booking/book_banquet_hall.dart';
import 'package:ras_club_flutter/const/pink_button.dart';
import 'package:ras_club_flutter/model/PartyhallBookingModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Booking/book_kingroom.dart';
import '../../const/dialogueerror.dart';
import 'partyhall_booling.dart';
import '../../const/constants.dart';
import '../../const/custom_grey_container.dart';
import '../../const/customstatic_dropdown.dart';
import '../../const/tv_wifi.dart';
import '../../model/HallBookingModal.dart';
import '../../utils.dart';
import 'package:http/http.dart'as http;
import 'package:ras_club_flutter/model/PartyhallBookingModel.dart';


final List<String> imgList = [
  'assets/images/banquet_1.jpg',
  'assets/images/banquet_2.jpg',
  'assets/images/banquet_3.jpg',
  'assets/images/banquet_4.jpg',

];

class PartyHallHomeTab extends StatefulWidget {
  const PartyHallHomeTab({Key? key}) : super(key: key);

  @override
  State<PartyHallHomeTab> createState() => _PartyHallHomeTabState();
}

class _PartyHallHomeTabState extends State<PartyHallHomeTab> {
  @override
  TextEditingController dateOfFunctionController = TextEditingController();
  String timing ="Select Function Time*";
  List<String> halltype =['Mini Party Hall (10 px)','Mini Party Hall (15-30 px)', 'Party Hall (30-50 px)',];
  List<String> halltype1 =['Mini Party Hall 2','Mini Party Hall', 'Party Hall'];
  int radiotittle1 =-1;
  String message ="";
  
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: false,
        title: Text('Party Hall'),
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
                      TvWiBreakfast(icon: Icons.apartment,text: '1500Sq.Ft',),
                      SizedBox(width: 10,),
                      TvWiBreakfast(icon: Icons.restaurant,text: 'Pre-Menu',),
                      SizedBox(width: 10,),
                      TvWiBreakfast(icon: Icons.man_2_outlined,text: 'Upto 50',),
                    ],
                  ),

                ),
                SizedBox(height: 20,),
                Text('Make Your Party Hall Reservation',style: TextStyle(fontSize: 30/2,fontWeight: FontWeight.bold),),
                ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (bc,i)=>RadioListTile(
                    controlAffinity: ListTileControlAffinity.leading,
                    title: Text(halltype[i]),
                    value: i,
                    onChanged: (radiovalue) {
                      print(halltype[i]);
                      setState(() {
                        radiotittle1 = i;

                      });
                    },
                    groupValue: radiotittle1,
                  ),
                  itemCount: halltype.length,


                ),
               
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
                    'Dinner Time 7:00 P.M. To 11:00 P.M. '
                  ], onItemSelected: (String? value) {
                  setState(() {
                    value.toString();
                    timing =value.toString();
                  });
                },),
                PinkButton(text: "Check Availability",ontap: (){
                  if(timing=='Select Function Time*'){
                    Utils.showToast('Please select function time');
                    print('hii');
                    return ;

                  }else if(radiotittle1==-1){
                    Utils.showToast('please select party hall type');
                  }
                  else{

                    if((validateData()))
                      PartyHallBookingApi();
                  }

                }),

              ],
            ),
          )
        ],
      ),
    );
  }
  void PartyHallBookingApi ( ) async{
    Random rand = new Random();
    int rand_int1 = rand.nextInt(1000);
    String orderId = "Order #RZP"+rand_int1.toString();
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
        "hall_type" :"${halltype1[radiotittle1]}"

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
          var partyhallbookkingModel =PartyhallBookingModel.fromJson(data);

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
                              if(partyhallbookkingModel.availablity=="Available")...{

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
                              Text('${halltype[radiotittle1]}',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
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






                      if(partyhallbookkingModel.availablity=="Available")...{
                        InkWell(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>BookPartyHall( time: timing, dateOfFunctionController: dateOfFunctionController, halltype: "${halltype1[radiotittle1]}", partyhallBookingModel: PartyhallBookingModel.fromJson(data), halltype1: "${halltype1[radiotittle1]}", )));

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




