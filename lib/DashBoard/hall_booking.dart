import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:ras_club_flutter/Booking/banquethall_details.dart';
import 'package:ras_club_flutter/const/dashboard_cards.dart';
import 'package:ras_club_flutter/const/pink_button.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart'as https;
import '../Booking/book_twinbedroom.dart';
import '../const/constants.dart';
import '../const/dashbord_stack_container.dart';
import '../homepage.dart';
import 'model/GetHallBookingModel.dart';

class HallBooking extends StatefulWidget {

  final GetHallBookingModel data;
  HallBooking({required this.data});
  @override
  State<HallBooking> createState() => _HallBookingState();
}

class _HallBookingState extends State<HallBooking> {
  @override
  Widget build(BuildContext context) {
    print( widget.data.hallbookings!.length,);
    return Scaffold(

      body: Stack(
        children: [
          DashboaredStackContainer(tittle: 'Hall Bookings',gradient: linergradienthall,),
          Positioned(
              top: 130,

              child: Container(
                height: MediaQuery.of(context).size.height-50, width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.white
                ),
                child: ListView.builder(
                    shrinkWrap: true,

                    itemCount: widget.data.hallbookings!.length,
                    itemBuilder: (BuildContext context, int index) {
                      return  Container(

                        padding: EdgeInsets.only(bottom: 50,top: 5,left: 5,right: 5),
                        margin: EdgeInsets.only(left: 12,right: 12),

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
                                  Text('${widget.data.hallbookings![index].hallType}',style: TextStyle1,),
                                  Spacer(),
                                  Text(widget.data.hallbookings![index].status.toString()),
                                  SizedBox(width: 5,),
                                  if(widget.data.hallbookings![index].status== 'Expired')...{
                                    Icon(Icons.circle,color: Colors.red,size: 12,)
                                  }else
                                    Icon(Icons.circle,color: Colors.green,size: 12,)
                                ],
                              ),
                            ),




                            Center(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('Function date:',style: TextStyle2),
                                  Text('${widget.data.hallbookings![index].fdate}',style: TextStyle(fontSize: 15),),
                                  SizedBox(height: 12,),
                                  Text('Function Time:',style: TextStyle2),
                                  Text('${widget.data.hallbookings![index].ftime}',style: TextStyle(fontSize: 15),),


                                ],
                              ),
                            ),
                            SizedBox(height: 12,),
                            Center(child: Text('Selected Menu :',style: TextStyle2,)),
                            Text('${widget.data.hallbookings![index].menu}',textAlign: TextAlign.center,),
                            SizedBox(height: 12,),
                            Center(child: Text('Extra items:',style: TextStyle2,)),
                            Text('${widget.data.hallbookings![index].extraItems}',textAlign: TextAlign.center,),

                            SizedBox(height: 20,),
                            Divider(thickness: 1,),
                            Container1(text1: "No of Plates", text2: "${widget.data.hallbookings![index].totalPlates}"),
                            Row1(text1: 'Booking for', text2: "${widget.data.hallbookings![index].bookFor}"),
                            Container1(text1: "Function Type", text2: "${widget.data.hallbookings![index].fdate}"),
                            Row1(text1: 'Host Name', text2: "${widget.data.hallbookings![index].hostName}"),
                            Container1(text1: "Host Mobile No.", text2: "${widget.data.hallbookings![index].hostMobile}"),
                            Row1(text1: 'Cost Per PLate', text2: "₹ ${widget.data.hallbookings![index].ratePerPlate}"),
                            Container1(text1: "Total Amount", text2: "₹ ${widget.data.hallbookings![index].totalAmount}"),
                            Row1(text1: "Total GST", text2: "₹ ${widget.data.hallbookings![index].gst}"),
                            Container1(text1: "Grand Total", text2: "₹ ${widget.data.hallbookings![index].grandTotal}"),
                            Row1(text1: "Advance  Amount", text2: "₹ ${widget.data.hallbookings![index].advancePaid}"),
                            Container1(text1: "Booking Time", text2: "${widget.data.hallbookings![index].createdAt}"),
                            Row1(text1: "Booking Id ", text2: "${widget.data.hallbookings![index].orderId}"),


                            widget.data.hallbookings![index].status== 'Expired'?SizedBox(): PinkButton(ontap: (){
                              // CancelBookinApi(index);
                              showAlertDialog(context,index);
                            }, text: 'Cancel Booking'),





                          ],
                        ),
                      );
                    }),
              ),)
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

      "fdate": widget.data.hallbookings![i].fdate,
      "ftime": widget.data.hallbookings![i].ftime,
      "hall_type": widget.data.hallbookings![i].hallType,



        "id": widget.data.hallbookings![i].id,
        "order_id": widget.data.hallbookings![i].orderId,
        "amount": widget.data.hallbookings![i].grandTotal,


        "mobile": prefs.getString(Constants.MOBILE_NUMBER),
        "member_type": prefs.getString(Constants.MEMBER_Type),
        "deviceId": "4E8EB26C-9143-49ED-B415-B67EE16A9E2F",
        "refreshToken": "sgsghdsvdhjsd",
        "hardwareDetails": "",
        "email":prefs.getString(Constants.EMAIL),
        "name": prefs.getString(Constants.USER_NAME),
        "membership_no": prefs.getString(Constants.MEMVERSHIP_NO),
      };
      Response response = await https.post(
          Uri.parse('https://api.rasclub.org/removeHallBooking.php'),
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
          // Navigator.of(context)
          //   ..pop()
          //   ..pop();
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

const TextStyle2= TextStyle(fontWeight: FontWeight.bold,fontSize: 15);


class Row1 extends StatelessWidget {
  final text1;
  final text2;

  Row1({required this.text1,required this.text2});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        SizedBox(width: 10,),
        Expanded(child: Text(text1,style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500),)),
        Expanded(child: Text(text2,style: TextStyle2,)),
      ],
    );
  }
}

class Container1 extends StatelessWidget {
  final text1;
  final text2;
  Container1({required this.text1,required this.text2});
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black12,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(width: 10,),
          Expanded(child: Text(text1,style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500),)),
          Expanded(child: Text(text2,style: TextStyle2,)),
        ],
      ),
    );
  }
}