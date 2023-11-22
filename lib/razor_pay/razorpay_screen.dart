// import 'dart:convert';
// import 'dart:math';
//
// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:http/http.dart';
// import 'package:razorpay_flutter/razorpay_flutter.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// import '../const/constants.dart';
// import '../utils.dart';
// import 'package:http/http.dart'as http;
// class RazorPay extends StatefulWidget {
//   const RazorPay({Key? key}) : super(key: key);
//
//   @override
//   State<RazorPay> createState() => _RazorPayState();
// }
//
// class _RazorPayState extends State<RazorPay> {
//
//   late var _razorpay;
//   bool isloading =false;
//   // late String _base64;
//   late AnimationController controller;
//   bool determinate = false;
//
//
//
//   @override
//   void initState() {
//     super.initState();
//     _razorpay = Razorpay();
//     // getData();
//     _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
//     _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
//     _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
//
//
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold (
//       appBar: AppBar(),
//       body:
//       Center(
//         child: ElevatedButton(onPressed: (){
//
//           Razorpay razorpay = Razorpay();
//           var options = {
//             'key': 'rzp_live_ILgsfZCZoFIKMb',
//             'amount': 100,
//             'name': 'RAS CLUB.',
//             'description': 'Fine T-Shirt',
//             'retry': {'enabled': true, 'max_count': 1},
//             'send_sms_hash': true,
//             'prefill': {'contact': '7976725792', 'email': 'rasclubjaipur@gmail.com'},
//             'external': {
//               'wallets': ['paytm']
//             }
//           };
//           razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
//           razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
//           razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
//           razorpay.open(options);
//         },
//             child: const Text("Pay with Razorpay")),
//       ),
//     );
//   }
//   void _handlePaymentSuccess(PaymentSuccessResponse response) {
//     //getPaymentStatus(response.paymentId);
//     print(response.signature);
//   }
//
//   void _handlePaymentError(PaymentFailureResponse response) {
//     print("Error while making payment   $response");
//     setState(() {
//       isloading = false;
//     });
//     Fluttertoast.showToast(
//         msg: "Payment Failed",
//         toastLength: Toast.LENGTH_SHORT,
//         gravity: ToastGravity.BOTTOM,
//         timeInSecForIosWeb: 1,
//         backgroundColor: Colors.redAccent,
//         textColor: Colors.white,
//         fontSize: 16.0
//     );
//   }
//
//   void _handleExternalWallet(ExternalWalletResponse response) {
//     // Do something when an external wallet is selected
//     print(response.walletName);
//   }
//
//
//   Future<void> getPaymentStatus(String? paymentId) async {
//     if(paymentId == null)
//     {
//       return;
//     }
//     const url = "http://bonanza.globaltechsoft.com/getSuccessPayment.php";
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     String mobileNumber = prefs.getString(Constants.MOBILE_NUMBER)!;
//     String name = prefs.getString(Constants.USER_NAME)!;
//     String email = prefs.getString(Constants.EMAIL )!;
//     String token = prefs.getString(Constants.SALT)!;
//     Map<String, String> body = {
//       "name": name,
//       "mobile": mobileNumber,
//       "email":email,
//       // "plan_name":widget.planType,
//       // "amount":widget.planAmount,
//       "payment_id":paymentId,
//       "deviceId": Utils.deviceId??"",
//       "refreshToken": "sgsghdsvdhjsd",
//       "hardwareDetails": Utils.deviceData??"",
//     };
//     print(token);
//     var headers = {
//       "Accept": "application/json",
//       "Content-Type": "application/json",
//       "User-Agent": "okhttp/3.10.0",
//       'Authorization': 'Bearer $token',
//     };
//
//     var response = await http.post(Uri.parse(url),
//         headers: headers,
//         body: jsonEncode(body),
//         encoding: Encoding.getByName("utf-8"));
//     Map<String, dynamic> responseData = json.decode(response.body);
//     if (responseData['status'] == '200' &&
//         responseData["response"] == 'payment details successfully updated') {
//       Fluttertoast.showToast(
//           msg: "Payment Successful",
//           toastLength: Toast.LENGTH_SHORT,
//           gravity: ToastGravity.BOTTOM,
//           timeInSecForIosWeb: 1,
//           backgroundColor: Colors.green,
//           textColor: Colors.white,
//           fontSize: 16.0
//       );
//       if(!mounted) return;
//       // getMembers();
//
//     }
//   }
//
//
//
//   void GymApi ( ) async{
//     Random rand = new Random();
//     int rand_int1 = rand.nextInt(1000);
//     String orderId = "Order #RZP"+rand_int1.toString();
//     try{
//       SharedPreferences prefs = await SharedPreferences.getInstance();
//       var body ={
//         "mobile":prefs.getString(Constants.MOBILE_NUMBER),
//         "member_type":prefs.getString(Constants.MEMBER_Type),
//         "deviceId": "4E8EB26C-9143-49ED-B415-B67EE16A9E2F",
//         "refreshToken":"sgsghdsvdhjsd",
//         "hardwareDetails":"",
//         "name": prefs.getString(Constants.USER_NAME),
//         "membership_no": prefs.getString(Constants.MEMVERSHIP_NO),
//         // "duration":duration[durationindex],
//         // "pt_duration" :ptduration[ptdurationindex],
//         // "pt_type":ptrequirement![ptrequirementindex],
//         // "fdate": "${dateOfFunctionController.text}",
//         // // "ftime" :"${timing}",
//         // "hall_type" :"Conference Hall"
//
//       };
//       print(body);
//       Response response =await http.post(Uri.parse('https://api.rasclub.org/checkGymPrices.php'),
//           headers: {
//             "Accept": "application/json",
//             "User-Agent":"okhttp/3.10.0",
//             "Content-Type": "application/json",
//             "Authorization": "Bearer ${prefs.getString(Constants.SALT)}"
//           },
//
//           body:jsonEncode(body)
//       );
//       print("${prefs.getString(Constants.SALT)}");
//       if(response.statusCode==200){
//         var data = jsonDecode(response.body);
//         print(data);
//         print(body);
//         // var gymfeemodel =GymModel.fromJson(data);
//         print("data convert success");
//         print(response);
//         setState(() {
//
//           // ptfees =gymfeemodel.pTFees.toString();
//           // gymfees =gymfeemodel.gymFees.toString();
//           // tottalfees =gymfeemodel.totalFees.toString();
//         });
//
//         // ignore: use_build_context_synchronously
//
//
//       }else
//       {
//         CircularProgressIndicator();
//         print("dalid");
//         print(response.statusCode.toString());
//         print(body);
//       }
//     }catch(e){
//       print(e.toString());
//     }
//   }
//
//
//
//
//
//   // void showAlertDialog(BuildContext context, String title, String message){
//   //   // set up the buttons
//   //   Widget continueButton = ElevatedButton(
//   //     child: const Text("Continue"),
//   //     onPressed:  () {},
//   //   );
//   //   // set up the AlertDialog
//   //   AlertDialog alert = AlertDialog(
//   //     title: Text(title),
//   //     content: Text(message),
//   //     actions: [
//   //       continueButton,
//   //     ],
//   //   );
//   //   // show the dialog
//   //   showDialog(
//   //     context: context,
//   //     builder: (BuildContext context) {
//   //       return alert;
//   //     },
//   //   );
//   // }
// }
