import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:ras_club_flutter/const/pink_button.dart';
import 'package:ras_club_flutter/homepage.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart'as http;
import '../../Booking/banquethall_details.dart';
import '../../Booking/book_kingroom.dart';
import '../../const/constants.dart';
import '../../model/SportsModel.dart';
import '../../utils.dart';


class SportDetails extends StatefulWidget {

  final String feesamount;
  final String orderno;
  final String month;
  final String timeslot;
  final game;
  final type;



  SportDetails({required this.month,required this.feesamount ,required this.timeslot,required this.orderno,
  required this.game , required this.type
  });
  @override
  State<SportDetails> createState() => _SportDetailsState();
}

class _SportDetailsState extends State<SportDetails> {
  @override
  bool isloading =false;
  late AnimationController controller;
  bool determinate = false;
 late  double fees=0.0;
  late double gstfees=0.0;
  late String grandtotal='';

  Widget build(BuildContext context) {
    double withoutgst  = int.parse(widget.feesamount)/1.18;
    int withoutgst1 =withoutgst.toInt();
    double gst = int.parse(widget.feesamount)-withoutgst;
    int gstvalue = gst.toInt();
    setState(() {
      fees =withoutgst;
      gstfees= gst;
      grandtotal =widget.feesamount;
    });

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
                    Text('${widget.orderno} ',style: TextStyle1,),
                    Divider(height: 15,color: Colors.pink.shade700,thickness: 2,),
                    Text("Fees ${widget.feesamount}",style: TextStyle1,),
                    // Text('₹ '"${widget.advance}",style: TextStyle(fontSize: 45,fontWeight: FontWeight.bold),),
                    PinkButton(ontap: ()
                    async{
                      Razorpay razorpay = Razorpay();
                      SharedPreferences prefs = await SharedPreferences.getInstance();
                      String mobileNumber = prefs.getString(Constants.MOBILE_NUMBER)!;
                      String emaildetails = prefs.getString(Constants.EMAIL)!;
                      // String  = prefs.getString(Constants.MOBILE_NUMBER)!;
                      var options = {
                        'key': 'rzp_live_NalzYyd1d8kTRB',
                        'amount':double.parse(widget.feesamount)*100,
                        'name':'RAS CLUB.',
                        'description': 'Rooftop Sports booking',
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

                    },
                        text:'pay now'),
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
                Text('Booking Details',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
               Divider(height: 2,color: Colors.black26,),
                SizedBox(height: 25,),
                Text('Month',style:TextStyle1 ),
                Text(widget.month),
                SizedBox(height: 15,),
                Text(' Time Slot',style:TextStyle1 ),
                Text(widget.timeslot),
                SizedBox(height: 15,),
                Text('Fees',style:TextStyle1 ),
                Text(widget.feesamount),
                Divider(thickness: 1,),
                Container1(text1: 'Month',text2: widget.month,),
                Row1(text1: 'Time Slot',text2: widget.timeslot,),
                Container1(text1: ' FEES',text2: ("${fees.toStringAsFixed(2)}"),),
                Row1(text1: 'GST @ 18% ',text2: '${gstfees.toStringAsFixed(2)}',),
                Container1(text1: 'Grand Total',text2: grandtotal,),
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

    setState(() {

    });
    SavePaymentRoom(response.paymentId,response.signature);
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


  Future<void> getPaymentStatus(String? paymentId) async {
    if(paymentId == null)
    {
      return;
    }
    const url = "https://api.rasclub.org/savePaymentForGames.php";
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

  void SavePaymentRoom (String? paymentId, String? signature) async{
    Random rand = new Random();
    int rand_int1 = rand.nextInt(1000);
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
        "email": prefs.getString(Constants.EMAIL),
        "payment_id": paymentId,
        "signature_hash":signature,
        "order_id": orderId,
        "amount": fees,
        "gst": gstfees,
           "grand_total": grandtotal,
        "game": widget.game,
          "type": widget.type,
          "month": widget.month,
          "time_slot": widget.timeslot,
        
      };
      print(body);
      Response response =await http.post(Uri.parse('https://api.rasclub.org/savePaymentForGames.php'),
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

        print(response);
        setState(() {
        });

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


