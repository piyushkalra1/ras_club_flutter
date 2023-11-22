import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:ras_club_flutter/const/pink_button.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart'as http;
import '../const/constants.dart';
import '../homepage.dart';
import '../utils.dart';
import 'Booking/banquethall_details.dart';
import 'Booking/book_kingroom.dart';


class BookRoomDetails extends StatefulWidget {
  final String roomname;
  final String checkindate;
  final String checkoutdate;
  final String Nightstay;
  final String RoomNumbers;
  final String Bedrequired;
  final String bookingfor;
  final String totalfair;
  final String gst;
  final String grandtotal;


  BookRoomDetails({required this.roomname,required this.checkindate,required this.checkoutdate,required this.Nightstay,required this.RoomNumbers,required this.Bedrequired,required this.bookingfor,required this.totalfair, required this.gst, required this.grandtotal
  });
  @override
  State<BookRoomDetails> createState() => _BookRoomDetailsState();
}

class _BookRoomDetailsState extends State<BookRoomDetails> {
  @override

  bool isloading =false;
  late AnimationController controller;

  bool determinate = false;
  String myorderid="";
  Widget build(BuildContext context) {
    return  SafeArea(child: Scaffold(
      appBar: AppBar(),
      body: ListView(
        children: [
          SizedBox(height: 30,),
          Stack(
            children: [
              Container(
                height: 300,
                margin: EdgeInsets.symmetric(horizontal: 10,vertical: 40),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      width: 2,color: Colors.pinkAccent,
                    )
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(height: 20,),
                    Text('${widget.roomname} ',style: TextStyle1,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            Text('Check-in:',style: TextStyle1),
                            Text(widget.checkindate,style: TextStyle(fontSize: 15),)
                          ],
                        ),
                        SizedBox(width: 10,),
                        Container(width: 2,height: 30,color: Colors.black45,),
                        SizedBox(width: 10,),
                        Column(
                          children: [
                            Text('Check-out:',style: TextStyle1),
                            Text(widget.checkoutdate,style: TextStyle(fontSize: 15),)
                          ],
                        ),
                      ],
                    ),
                    // Text('₹ '"${widget.advance}",style: TextStyle(fontSize: 45,fontWeight: FontWeight.bold),),
                    PinkButton(ontap: (){
                      bookroomapi();
                    },
                    // Navigator.pop(context);},

                        text:'Pay Now'),

                  ],
                ),
              ),
              Align(
                  alignment: Alignment.topCenter,
                  child: CircleAvatar(
                    backgroundColor: Colors.white,radius: 40,
                    backgroundImage: AssetImage(
                        'assets/images/logo_round.png'
                    ),
                  ))
            ],
          ),

          Container(
            margin: EdgeInsets.symmetric(horizontal: 10,),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  width: 2,color: Colors.pinkAccent,
                )
            ),
            child: Column(
              children: [
                Text('Booking Details',style: TextStyle(fontSize: 26,fontWeight: FontWeight.bold),),


                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  // child: Text(widget.menu),
                ),
                // Text(widget.menu)
                SizedBox(height: 15,),
                Divider(thickness: 1,),
                Container1( text1: 'Total Stay : ', text2: "${widget.Nightstay}/Night",),
                Row1(text1: 'Total Rooms : ', text2: "${widget.RoomNumbers} Room"),
                Container1(text1: 'Extra Bed Required : ', text2: widget.Bedrequired),
                Row1(text1:  'Booking For : ', text2: widget.bookingfor),
                Container1(text1: 'Total Fair : ', text2: " ₹${widget.totalfair}"),
                Row1(text1: 'GST @12% : ', text2: " ₹ ${widget.gst}"),
                Container1(text1: 'Grand Total : ', text2: " ₹ ${widget.grandtotal}"),
                SizedBox(height: 20,),

              ],
            ),
          ),


        ],
      ),
    ));
  }
  void bookroomapi () async{
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
        "name":
        prefs.getString(Constants.USER_NAME),
        "membership_no": prefs.getString(Constants.MEMVERSHIP_NO),
        "email": prefs.getString(Constants.EMAIL),

        // "order_id": widget.orderid,
        "room_type": widget.roomname,
        "checkin": widget.checkindate,
        "checkout": widget.checkoutdate,
        "no_of_rooms": widget.RoomNumbers,
        "total_nights": widget.Nightstay,
        "extra_bed": widget.Bedrequired,
        "booking_for": widget.bookingfor,
        "total_fair": '${widget.totalfair}',
        "total_gst": '${widget.gst}',
        "grand_total":'${widget.grandtotal}'


      };
      print(body);
      Response response =await http.post(Uri.parse('https://api.rasclub.org/saveRoomBookingDetails.php'),
          headers: {
            "Accept": "application/json",
            "User-Agent":"okhttp/3.10.0",
            "Content-Type": "application/json",
            "Authorization": "Bearer ${prefs.getString(Constants.SALT)}"
          },

          body:jsonEncode(body)
      );
      print("${prefs.getString(Constants.SALT)}");

      var data = jsonDecode(response.body);
      print(data);
      if(response.statusCode==200 && data["response"].toString().contains("order_") ){

        print(data);
        print(body);
        print(response.body.toString());
       myorderid=data["response"];

          Razorpay razorpay = Razorpay();
          SharedPreferences prefs = await SharedPreferences.getInstance();
          String mobileNumber = prefs.getString(Constants.MOBILE_NUMBER)!;
          String emaildetails = prefs.getString(Constants.EMAIL)!;
          // String  = prefs.getString(Constants.MOBILE_NUMBER)!;
          var options = {
            'key': 'rzp_live_NalzYyd1d8kTRB',
            'amount':double.parse(widget.grandtotal)*100,
            // 'amount':100,
            'order_id':data["response"].toString(),
            'name':'RAS CLUB.',
            "image" : " https://razorpay.com/assets/razorpay-logo.png",
            'description': 'Room booking',
            'retry': {'enabled': true, 'max_count': 1},
            'send_sms_hash': true,
            'prefill': {'contact': mobileNumber, 'email':
            emaildetails,
            },
            'external': {
              'wallets': ['paytm']
            }
          };
          razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
          razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
          razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
          razorpay.open(options);


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
  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    // getPaymentStatus(response.paymentId);
    savePaymentforRoom(response.paymentId, response.signature,myorderid);
    print(response.signature);

    setState(() {

    });

    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomePage()));

  }

  void _handlePaymentError(PaymentFailureResponse response) {
    print("Error while making payment   ${response.message}");
    print("Error while making payment   ${response.code}");
    print("Error while making payment   ${response.error}");
    print("Error while making payment   ${response.toString()}");

    setState(() {
      isloading = false;
    });
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomePage()));
    Fluttertoast.showToast(
        msg: "Payment Failed",
        toastLength: Toast.LENGTH_SHORT,

        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.redAccent,
        textColor: Colors.white,
        fontSize: 16.0
    );
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Do something when an external wallet is selected


    print(response.walletName);
  }

  void savePaymentforRoom (String? paymentId, String? signature,String receiveorderid) async{

    try{
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var body ={
        "mobile":prefs.getString(Constants.MOBILE_NUMBER),
        "member_type":prefs.getString(Constants.MEMBER_Type),
        "deviceId": "4E8EB26C-9143-49ED-B415-B67EE16A9E2F",
        "refreshToken":"sgsghdsvdhjsd",
        "hardwareDetails":"",
        "name":
        prefs.getString(Constants.USER_NAME),
        "membership_no": prefs.getString(Constants.MEMVERSHIP_NO),
        "email": prefs.getString(Constants.EMAIL),
        "payment_id": paymentId,
        // "order_id": widget.orderid,
        "signature_hash":signature,
        "order_id": receiveorderid,
      "room_type": widget.roomname,
      "checkin": widget.checkindate,
      "checkout": widget.checkoutdate,
      "no_of_rooms": widget.RoomNumbers,
      "total_nights": widget.Nightstay,
      "extra_bed": widget.Bedrequired,
      "booking_for": widget.bookingfor,
      "total_fair": '${widget.totalfair}',
      "total_gst": '${widget.gst}',
      "grand_total":'${widget.grandtotal}'


      };
      print(body);
      Response response =await http.post(Uri.parse('https://api.rasclub.org/savePaymentForRoomsNew.php'),
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
        print("data convert success");
        print(response);
        setState(() {
        });

      }else
      {
        CircularProgressIndicator();
        print("dalid");

      }
    }catch(e){
      print(e.toString());
    }
  }

}