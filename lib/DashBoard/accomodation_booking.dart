import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart'as http;
import 'package:http/http.dart';
import 'package:ras_club_flutter/Booking/book_kingroom.dart';
import 'package:ras_club_flutter/const/dashboard_cards.dart';
import 'package:ras_club_flutter/const/pink_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../const/dashbord_stack_container.dart';
import '../const/constants.dart';
import '../homepage.dart';
import 'model/GetRoomBookingModel.dart';

class Accomodation extends StatefulWidget {

  final GetRoomBookingModel data;
  Accomodation({required this.data});

  @override
  State<Accomodation> createState() => _AccomodationState();
}

class _AccomodationState extends State<Accomodation> {
  @override



  Widget build(BuildContext context) {
    // print(widget.data.bookings!.length);

    // print(widget.data);
    return  Scaffold(



      body: Stack(
        children: [
          DashboaredStackContainer(tittle: 'Accomodation Bookings',gradient: linergradientaccomodation,),
          Positioned(
            top: 130,

              child: InkWell(
                onTap:(){},

                child: Container(
                  height: MediaQuery.of(context).size.height, width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Colors.white,

            ),
                  child:ListView.builder(
                      itemCount: widget.data.bookings!.length,
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, int index) {
                        return  Container(

                          padding: EdgeInsets.all(8),
                          margin: EdgeInsets.all(12),

                          decoration: BoxDecoration(

                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                  width: 2,
                                  color: Colors.black12
                              )
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [

                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 4),
                                  child: Row(
                                    children: [
                                      Text('${widget.data.bookings![index].roomType}',style: TextStyle1,),
                                      Spacer(),
                                      Text('${widget.data.bookings![index].status}'),
                                      SizedBox(width: 5,),
                                      if(widget.data.bookings![index].status== 'Expired')...{
                                        Icon(Icons.circle,color: Colors.red,size: 12,)
                                      }else
                                      Icon(Icons.circle,color: Colors.green,size: 12,)
                                    ],
                                  ),
                                ),



                              Padding(
                                padding: const EdgeInsets.only(left: 8),
                                child: Text("${widget.data.bookings![index].bookingFor}"),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Column(
                                    children: [
                                      Text('Check-in:',style: TextStyle1),
                                      Text('${widget.data.bookings![index].checkin}',style: TextStyle(fontSize: 15),)
                                    ],
                                  ),
                                  SizedBox(width: 10,),
                                  Container(width: 2,height: 30,color: Colors.black45,),
                                  SizedBox(width: 10,),
                                  Column(
                                    children: [
                                      Text('Check-out:',style: TextStyle1),
                                      Text('${widget.data.bookings![index].checkout}',style: TextStyle(fontSize: 15),),
                                    ],
                                  ),

                                ],
                              ),
                              SizedBox(height: 20,),
                              Center(child: Text('Booking Id :${widget.data.bookings![index].orderId}')),
                              Text('Date & Time of Booking ${widget.data.bookings![index].createdAt}',textAlign: TextAlign.center,),

                              SizedBox(height: 20,),

                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      color: Colors.blueGrey.shade100
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: [
                                        Column(
                                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                                          children: [
                                            Text('Total Fair'),
                                            Text('${widget.data.bookings![index].totalFair}'),
                                          ],
                                        ),
                                        Column(
                                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                                          children: [
                                            Text('GST'),
                                            Text('${widget.data.bookings![index].gst}'),
                                          ],
                                        ),
                                        Column(
                                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                                          children: [
                                            Text('Grand Total '),
                                            Text('${widget.data.bookings![index].grandTotal}'),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),

                              widget.data.bookings![index].status== 'Expired'?SizedBox():PinkButton(ontap: (){
                                // CancelBookinApi(index);
                                showAlertDialog(context,index);
                              }, text: 'Cancel Booking'),
                              SizedBox(height: 50,),
                            ],
                          ),
                        );
                      })



          ),
              ))
        ],
      ),
    );
  }
  showAlertDialog(BuildContext context,int index) {

    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text("No"),
      onPressed:  () {
        Navigator.pop(context);
      },
    );
    Widget continueButton = TextButton(
      child: Text("Yes"),
      onPressed: () async {
        CancelBookinApi(index);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Cancel Booking"),
      content: Text("Are you sure you want to cancel your booking ?",style: TextStyle(fontWeight: FontWeight.bold),),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  void CancelBookinApi( int i)async{
    Loader.show(context);
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var body = {



      "room_type": widget.data.bookings![i].roomType,
      "id": widget.data.bookings![i].id,
      "order_id": widget.data.bookings![i].orderId,
      "amount": widget.data.bookings![i].grandTotal,


      "mobile": prefs.getString(Constants.MOBILE_NUMBER),
        "checkin":widget.data.bookings![i].checkin,

        "checkout":widget.data.bookings![i].checkout,
        "member_type": prefs.getString(Constants.MEMBER_Type),
        "deviceId": "4E8EB26C-9143-49ED-B415-B67EE16A9E2F",
        "refreshToken": "sgsghdsvdhjsd",
        "hardwareDetails": "",
        "email":prefs.getString(Constants.EMAIL),
        "name": prefs.getString(Constants.USER_NAME),
        "membership_no": prefs.getString(Constants.MEMVERSHIP_NO),
      };
      Response response = await http.post(
          Uri.parse('https://api.rasclub.org/removeRoomBooking.php'),
          headers: {
            "Accept": "application/json",
            "User-Agent": "okhttp/3.10.0",
            "Content-Type": "application/json",
            "Authorization": "Bearer ${prefs.getString(Constants.SALT)}"
          },
          body: jsonEncode(body)
      );

        Loader.hide();
        if (response.statusCode == 200) {

          var data = jsonDecode(response.body);
          print(data);
          if(data["response"]=="booking successfully removed!"){
            Fluttertoast.showToast(
                msg: data["response"],
                toastLength: Toast.LENGTH_SHORT,

                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.green,
                textColor: Colors.white,
                fontSize: 16.0
            );
            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>HomePage()), (route) => false);

          }

        } else {
          print(response.statusCode.toString());

        }



    } catch (e) {
      print(e.toString());
    }
  }

}

