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
import 'book_kingroom.dart';

class BanquetHallDetails extends StatefulWidget {
  final TextEditingController functiondate;
  final hallname;
  final String functiontime;
  final String bookingfor;
  final functiontype;
  final hostname;
  final plates;
  final costrplate;
  final amount;
  final gst;
  final grandtotal;
  final advance;
  final number;
  final menu;
  final items;
  final orderid;

  BanquetHallDetails({required this.orderid,required this.number,required this.functiondate,required this.functiontime,required this.hostname,required this.functiontype,required this.bookingfor,required this.plates, required this.menu,
    required this.costrplate,required this.advance,required this.amount,required this.gst,
    required this.grandtotal,required this.items,required this.hallname,
  });
  @override
  State<BanquetHallDetails> createState() => _BanquetHallDetailsState();
}

class _BanquetHallDetailsState extends State<BanquetHallDetails> {
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
                    SizedBox(height: 30,),
                    Text(' ${widget.orderid}',style: TextStyle(fontSize: 15),),
                    Divider(height: 15,color: Colors.pink.shade700,thickness: 2,),

                    Text('${widget.hallname}  Booking',style: TextStyle1,),
                    Text('₹ '"${widget.advance}",style: TextStyle(fontSize: 45,fontWeight: FontWeight.bold),),
                    PinkButton(ontap: (){
                      SaveHallBooking();
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
               SizedBox(height: 25,),
                Text('Function Date',style:TextStyle1 ),
                Text(widget.functiondate.text),
                SizedBox(height: 15,),
                Text('Function Time',style:TextStyle1 ),
                Text(widget.functiontime),
                SizedBox(height: 15,),
                Text('Selected menu',style:TextStyle1 ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Text(widget.menu),
                ),
                // Text(widget.menu)
                SizedBox(height: 15,),
                Text('Extra items',style:TextStyle1 ),
                Text("${widget.items}"),
                Divider(thickness: 1,),
                Container1(text1: 'No of Plates',text2: widget.hallname =="Mini Party Hall (10 px)"? "10":  widget.plates,),
                Row1(text1: 'Booking for',text2: widget.bookingfor,),
                Container1(text1: 'Function Type',text2: widget.functiontype,),
                Row1(text1: 'Host Name ',text2: widget.hostname,),
                Container1(text1: 'Host Mobile No.',text2: widget.number,),
                Row1(text1: 'Cost Per Plate',text2: widget.costrplate,),
                Container1(text1: 'Total Amount',text2: "₹ ${widget.amount}",),
                Row1(text1: 'Total GST',text2: '₹ ${widget.gst}',),
                Container1(text1: 'Grand Total',text2: "₹ ${widget.grandtotal} ",),
                Row1(text1: 'Advance Amount', text2: "₹ ${widget.advance} @30%"),
                SizedBox(height: 20,),

              ],
            ),
          ),


        ],
      ),
    ));
  }
  void _handlePaymentSuccess(PaymentSuccessResponse response) {

    print(response.signature);
    print(response);
    SavePaymentforHall(response.paymentId.toString(), myorderid, response.signature.toString());

    setState(() {

    });

    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomePage()));

  }

  void _handlePaymentError(PaymentFailureResponse response) {
    print("Error while making payment   ${response.message}");
    print("Error while making payment   ${response.code}");
    print("Error while making payment   ${response.error}");
    print("Error while making payment   ${response.toString()}");
    SavePaymentforHall("test", myorderid, "test");

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


  Future<void> getPaymentStatus(String? paymentId) async {
    if(paymentId == null)
    {
      return;
    }
    const url = "https://api.rasclub.org/savePaymentForRooms.php";
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String mobileNumber = prefs.getString(Constants.MOBILE_NUMBER)!;
    String name = prefs.getString(Constants.USER_NAME)!;
    String email = prefs.getString(Constants.EMAIL )!;
    String token = prefs.getString(Constants.SALT)!;
    Map<String, String> body = {
      "name": name,
      "mobile": mobileNumber,
      "email":email,

      "payment_id":paymentId,
      "deviceId": Utils.deviceId??"",
      "refreshToken": "sgsghdsvdhjsd",
      "hardwareDetails": Utils.deviceData??"",
    };
    print(token);
    var headers = {
      "Accept": "application/json",
      "Content-Type": "application/json",
      "User-Agent": "okhttp/3.10.0",
      'Authorization': 'Bearer $token',
    };

    var response = await http.post(Uri.parse(url),
        headers: headers,
        body: jsonEncode(body),
        encoding: Encoding.getByName("utf-8"));
    Map<String, dynamic> responseData = json.decode(response.body);
    if (responseData['status'] == '200' &&
        responseData["response"] == 'payment details successfully updated') {
      Fluttertoast.showToast(
          msg: "Payment Successful",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0
      );
      if(!mounted) return;
      // getMembers();

    }
  }

  void SaveHallBooking () async{

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
        // "payment_id": paymentId,
        // "order_id": widget.orderid,
        // "signature_hash":signature,
        // "order_id": orderId,
        "hall_type": widget.hallname,
        "fdate": widget.functiondate.text,
        "ftime": widget.functiontime,
        "menu": widget.menu,
        "extra_items": widget.items,
        "no_of_plates": widget.plates,
        "booking_for": widget.bookingfor,
        "function_type": widget.functiontype,
        "host_name": widget.hostname,
        "host_mobile": widget.number,
        "total_amount":"${widget.amount}",
        "total_gst": "${widget.gst}",
        "advance_amount": "${widget.advance}",
        "cost_per_plate": "${widget.costrplate}",
        "grand_total": "${widget.grandtotal}"



      };
      print(body);
      Response response =await http.post(Uri.parse('https://api.rasclub.org/saveHallBookingDetails.php'),
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
      if(response.statusCode==200 && data["response"].toString().contains("order_")){
        myorderid=data["response"].toString();
        print("myorder id=>$myorderid");
          Razorpay razorpay = Razorpay();
          SharedPreferences prefs = await SharedPreferences.getInstance();
          String mobileNumber = prefs.getString(Constants.MOBILE_NUMBER)!;
          String emaildetails = prefs.getString(Constants.EMAIL)!;
          // String  = prefs.getString(Constants.MOBILE_NUMBER)!;
          var options = {
            'key': 'rzp_live_NalzYyd1d8kTRB',
            // "amount":100,
            'amount':double.parse(widget.advance)*100,
            'name':'RAS CLUB.',
            "order_id":myorderid,
            'description': 'Banquet Hall booking',
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

  void SavePaymentforHall (String paymentid,String orderid, String signature) async{

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
        "payment_id": paymentid,
        "order_id": orderid,
        "signature_hash":signature,

        "hall_type": widget.hallname,
        "fdate": widget.functiondate.text,
        "ftime": widget.functiontime,
        "menu": widget.menu,
        "extra_items": widget.items,
        "no_of_plates": widget.plates,
        "booking_for": widget.bookingfor,
        "function_type": widget.functiontype,
        "host_name": widget.hostname,
        "host_mobile": widget.number,
        "total_amount":"${widget.amount}",
        "total_gst": "${widget.gst}",
        "advance_amount": "${widget.advance}",
        "cost_per_plate": "${widget.costrplate}",
        "grand_total": "${widget.grandtotal}"



      };
      print(body);
      Response response =await http.post(Uri.parse('https://api.rasclub.org/savePaymentForHallsNew.php'),
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
      if(response.statusCode==200 ){
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomePage()));

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
        Expanded(child: Text(text1,style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),)),
        Expanded(child: Text(text2,style: TextStyle1,)),
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
          Expanded(child: Text(text1,style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),)),
          Expanded(child: Text(text2,style: TextStyle1,)),
        ],
      ),
    );
  }
}
