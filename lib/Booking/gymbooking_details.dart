import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:ras_club_flutter/model/payment/SuccessGympay.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart'as http;
import '../const/constants.dart';
import '../const/pink_button.dart';
import '../homepage.dart';
import '../razor_pay/razorpay_screen.dart';
import '../utils.dart';
import 'banquethall_details.dart';
import 'book_kingroom.dart';

class GymBookingDetails extends StatefulWidget {
  final duration;
  final trainer;
  final pttime;
  final double fees;
  final orderid;

  GymBookingDetails({required this.orderid,required this.duration,required this.trainer,required this.pttime,required this.fees });

  @override
  State<GymBookingDetails> createState() => _GymBookingDetailsState();
}

class _GymBookingDetailsState extends State<GymBookingDetails> {
  @override
  late var _razorpay;
  bool isloading =false;
  late AnimationController controller;
  bool determinate = false;
  Widget build(BuildContext context) {
    return  Scaffold(
      body:  ListView(
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
                    Text('Order ${widget.orderid}',style: TextStyle(fontSize: 15),),
                    Divider(height: 15,color: Colors.pink.shade700,thickness: 2,),

                    Text(' Gym Fees',style: TextStyle1,),
                    Text("₹${widget.fees}",style: TextStyle1,),
                    PinkButton(ontap: ()async{
                      // Navigator.push(context, MaterialPageRoute(builder: (context)=>RazorPay()));
                      Razorpay razorpay = Razorpay();
                      SharedPreferences prefs = await SharedPreferences.getInstance();
                      String mobileNumber = prefs.getString(Constants.MOBILE_NUMBER)!;
                      String emaildetails = prefs.getString(Constants.EMAIL)!;
                      var options = {
                        'key': 'rzp_live_NalzYyd1d8kTRB',
                        'amount': widget.fees*100,
                        'name': 'RAS CLUB.',
                        'description': 'Gym booking',
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
                Text('Booking Details',style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),),

                SizedBox(height: 15,),

                Divider(thickness: 1,),
                Container1(text1: 'Duration',text2: widget.duration.toString()),
                Row1(text1: 'Personal Trainer',text2:widget.trainer ),
                Container1(text1: 'PT Duration',text2:widget.pttime ),
                Row1(text1: 'Total Fees ',text2:"₹  ${widget.fees.toString()}" ,),



              ],
            ),
          ),


        ],
      ),
    );
  }
  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    //getPaymentStatus(response.paymentId);
    print(response.signature);

    setState(() {

    });
    GymPaymentApi(response.paymentId,response.signature);
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
    const url = "https://api.rasclub.org/savePaymentForGym.php";
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

  void GymPaymentApi (String? paymentId, String? singnature) async{
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
        "order_id": widget.orderid,
        "signature_hash":singnature ,
        "duration": widget.duration,
        "pt_type" : widget.trainer,
        "pt_duration": widget.pttime,
        "amount": widget.fees,
        "gst" : singnature,
        "grand_total": widget.fees,


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
        var gymsuccessfeemodel =SuccessGympay.fromJson(data);
        print("data convert success");
        print(response);
        setState(() {
          // ptfees =gymfeemodel.pTFees.toString();
          // gymfees =gymfeemodel.gymFees.toString();
          // tottalfees =gymfeemodel.totalFees.toString();
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
