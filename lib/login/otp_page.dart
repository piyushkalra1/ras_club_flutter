import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:otp_timer_button/otp_timer_button.dart';
import 'package:pinput/pinput.dart';
import 'package:ras_club_flutter/homepage.dart';
import 'package:ras_club_flutter/utils.dart';
import 'package:http/http.dart'as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../const/authbutton.dart';
import '../const/constants.dart';

class OtpPage extends StatefulWidget {
  final mobilenumber;
  const OtpPage({Key? key,required this.mobilenumber}) : super(key: key);



  @override

  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  @override
  final _formKey = GlobalKey<FormState>();
  TextEditingController mobilecontroller = TextEditingController();
  String number = "";
  String otp ="";
  final pinController = TextEditingController();
  final focusNode = FocusNode();
  final formKey = GlobalKey<FormState>();
  bool  isloading =false;
  late final String  name;
  @override
  void dispose() {
    pinController.dispose();
    focusNode.dispose();
    super.dispose();

  }


  Widget build(BuildContext context) {

    const focusedBorderColor = Color.fromRGBO(23, 171, 144, 1);
    const fillColor = Color.fromRGBO(243, 246, 249, 0);
    const borderColor = Color.fromRGBO(23, 171, 144, 0.4);

    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: const TextStyle(
        fontSize: 22,
        color: Color.fromRGBO(30, 60, 87, 1),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(19),
        border: Border.all(color: borderColor),
      ),
    );
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        leading: IconButton(icon: Icon(Icons.arrow_back),onPressed: (){
          Navigator.pop(context);
        },),
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text('Login'),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image(image: AssetImage('assets/images/otp_vector2.jpg'),height: 220,),
              Text('Verification Code',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 22),),
              Text('Please type the verification code sent to\n'
                  ,textAlign: TextAlign.center,),
              Text('${widget.mobilenumber}'),

              SizedBox(height: 30,),

              Directionality(
                // Specify direction if desired
                textDirection: TextDirection.ltr,
                child: Pinput(
                  length: 6,
                  controller: pinController,
                  focusNode: focusNode,
                  androidSmsAutofillMethod:
                  AndroidSmsAutofillMethod.smsUserConsentApi,
                  listenForMultipleSmsOnAndroid: true,
                  defaultPinTheme: defaultPinTheme,
                  validator: (value) {
                    // return value == pinController ? null : 'Pin is incorrect';
                    if(value==null && value?.length !=6){
                      Text('enter correcat otp');
                    }
                  },


                  hapticFeedbackType: HapticFeedbackType.lightImpact,
                  onCompleted: (pin) {
                    otp=pin;
                    debugPrint('onCompleted: $pin');
                  },
                  onChanged: (value) {
                    debugPrint('onChanged: $value');
                  },
                  cursor: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(bottom: 9),
                        width: 22,
                        height: 1,
                        color: focusedBorderColor,
                      ),
                    ],
                  ),
                  focusedPinTheme: defaultPinTheme.copyWith(
                    decoration: defaultPinTheme.decoration!.copyWith(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: focusedBorderColor),
                    ),
                  ),
                  submittedPinTheme: defaultPinTheme.copyWith(
                    decoration: defaultPinTheme.decoration!.copyWith(
                      color: fillColor,
                      borderRadius: BorderRadius.circular(19),
                      border: Border.all(color: focusedBorderColor),
                    ),
                  ),
                  errorPinTheme: defaultPinTheme.copyBorderWith(
                    border: Border.all(color: Colors.redAccent),
                  ),
                ),
              ),
              SizedBox(height: 20,),



              InkWell(
                onTap: () {
                  isLoading: isloading;
                  print(otp);
                  if (otp.isNotEmpty && otp.length == 6) {
                    callApi();
                  } else {
                    Utils.showToast("Please Enter correct OTP");
                  }
                },
                child: Container(
                  margin: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.pink,
                  ),
                  padding: EdgeInsets.symmetric(vertical: 12),

                  child: const Center(
                    child: Text('LOGIN ',style: TextStyle(
                        color: Colors.white,fontWeight: FontWeight.bold,fontSize: 16
                    ),),
                  ),
                ),
              ),
              SizedBox(
                height: 12,
              ),




              OtpTimerButton(
                backgroundColor: Colors.brown,
                buttonType: ButtonType.text_button,

                onPressed: () {},
                text: Text(
                  'Resend OTP',
                  style: TextStyle(fontSize: 12),
                ),
                duration: 60,
              ),

            ],
          ),
        )


      ),
    );
  }
  Future<void> callApi() async {
    setState(() {
      isloading = true;
    });
    const url = "https://api.rasclub.org/verifyOTP.php";

    var body = {
      "mobile": widget.mobilenumber,
      "otp": otp,
      "deviceId": Utils.deviceId!,
      "refreshToken": "sgsghdsvdhjsd",
      "hardwareDetails": Utils.deviceData!
    };
    var response = await http.post(Uri.parse(url),
        headers: {
          "Accept": "application/json",
          "User-Agent":"okhttp/3.10.0",
          "Content-Type": "application/json"
        },
        body: jsonEncode(body),
        encoding: Encoding.getByName("utf-8"));
    print(jsonEncode(body));
    Map<String, dynamic> responseData = json.decode(response.body);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isloading = false;
    });
    print(responseData);
    if (responseData['Message'] == 'OTP verified' && responseData["errorMessage"]=='') {
      prefs.setBool(Constants.IS_LOGIN, true);
      prefs.setString(Constants.SALT, responseData['Salt']);
      prefs.setString(Constants.MOBILE_NUMBER, widget.mobilenumber);
      prefs.setString(Constants.MEMVERSHIP_NO, responseData!['membershipNo']??"");
      prefs.setString(Constants.USER_NAME, responseData['Name']??"");
      prefs.setString(Constants.EMAIL, responseData['Email']??"");
      prefs.setString(Constants.MEMBER_Type, responseData['memberType']??"");

      setState(() {
        name =  prefs.getString(Constants.USER_NAME,)!;
      });
      print(responseData);


      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) =>  HomePage()
          ),  (Route<dynamic> route) => false);
    } else if(responseData["errorMessage"] !=''){
      Utils.showToast(responseData["errorMessage"]);
    }
    else {
      Utils.showToast("Please Enter Correct OTP");
    }
  }
}
