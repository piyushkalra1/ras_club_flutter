import 'dart:convert';
import 'dart:io';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart'as http;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ras_club_flutter/homepage.dart';
import 'package:ras_club_flutter/login/Registration.dart';
import 'package:ras_club_flutter/login/otp_page.dart';
import 'package:ras_club_flutter/utils.dart';
import 'package:url_launcher/url_launcher.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {

  @override

  void initState() {
    // TODO: implement initState
    Utils.getDeviceIdAndData();
    super.initState();
  }
  @override

  final _formKey = GlobalKey<FormState>();
  TextEditingController mobilecontroller = TextEditingController();
  final _mobileNumber = TextEditingController();
  bool isLoading = false;

  String get mobileNumber => _mobileNumber.text.trim();
  String number = "";
  Future<bool> showExitPopup() async {
    return await showDialog( //show confirm dialogue
      //the return value will be from "Yes" or "No" options
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Exit App'),
        content: Text('Do you want to exit an App?'),
        actions:[
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(false),
            //return false when click on "NO"
            child:Text('No'),
          ),

          ElevatedButton(
            onPressed: () {SystemNavigator.pop();
            //return true when click on "Yes"
            print('press');},
            child:Text('Yes'),
          ),

        ],
      ),
    )??false; //if showDialouge had returned null, then return false
  }

  Widget build(BuildContext context) {
    return  WillPopScope(
      onWillPop: showExitPopup,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: false,
          leading: IconButton(icon: Icon(Icons.arrow_back),onPressed: (){
            showExitPopup();

          },),
          backgroundColor: Colors.white,
          elevation: 0,
          title: Text('Login'),
        ),
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Image(image: AssetImage('assets/images/login_vector.jpg'),height: 220,),
                Text('LOGIN',style: TextStyle(fontSize: 36,fontWeight: FontWeight.bold),),
                Container(
                  margin: EdgeInsets.all(12),
                  child: TextFormField(
                    controller: mobilecontroller,
                    keyboardType: TextInputType.phone,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(10),
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    decoration: const InputDecoration(
                      focusColor: Colors.white,
                      //add prefix icon
                      prefixIcon: Icon(
                        Icons.phone,
                        color: Colors.grey,
                      ),


                      fillColor: Colors.grey,

                      hintText: "Mobile Number",

                      hintStyle: TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                        fontFamily: "verdana_regular",
                        fontWeight: FontWeight.w400,
                      ),

                      //create lable
                      labelText: 'Register Number',
                      labelStyle: TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                        fontFamily: "verdana_regular",
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    onChanged: (value){
                      _formKey.currentState?.validate();
                    },
                    // onChanged: (value) {
                    //   setState(() {
                    //     mobilecontroller.text = value.toString();
                    //   });
                    // },
                    validator: (value){
                      if(value!.isEmpty || value.length !=10){
                        return "Please Enter a Valid Register Number";
                      }else if(!RegExp(r'^\s*(?:\+?(\d{1,3}))?[-. (]*(\d{3})[-. )]*(\d{3})[-. ]*(\d{4})(?: *x(\d+))?\s*$').hasMatch(value)){
                        return "Please Enter a Valid Phone Number";
                      }
                    },

                  ),
                ),
                InkWell(
                  onTap: (){
                    if (_formKey.currentState!.validate()) {
                      callApi();
                      // Navigator.push(context, MaterialPageRoute(builder: (context)=>OtpPage(mobilenumber: mobileNumber,)));

                    }else
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Please enter Register number')),
                      );
                  },
                  child: Container(
                    margin: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.pink,
                    ),
                    padding: EdgeInsets.symmetric(vertical: 12),

                    child: const Center(
                      child: Text('SEND OTP',style: TextStyle(
                          color: Colors.white,fontWeight: FontWeight.bold,fontSize: 16
                      ),),
                    ),
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Not Registered?'),
                    TextButton(onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>RegisterUser()));

                    }, child: Text('Create account',style: TextStyle(
                      color: Colors.pink
                    ),))
                  ],
                )

              ],
            ),
          ),
        ),
      ),
    );
  }
  Future<void> callApi() async {
    setState(() {
      isLoading = true;
    });
    print('your mdodndo');
    print(mobilecontroller.text);
    const url = "https://api.rasclub.org/verifyUserMobile.php";
    print("Device Data " + Utils.deviceData!);
    var body = {
      "mobile": mobilecontroller.text,
      "deviceId": Utils.deviceId!,
      "refreshToken": "sgsghdsvdhjsd",
      "hardwareDetails": Utils.deviceData!
    };
    var response = await http.post(Uri.parse(url),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json",
          "User-Agent": "okhttp/3.10.0"
        },
        body: jsonEncode(body),
        encoding: Encoding.getByName("utf-8")
    );
    Map<String, dynamic> responseData = json.decode(response.body);
    setState(() {
      isLoading = false;
    });
    print(responseData);
    if (responseData['response'] == 'This mobile no. is not registered') {
      print("Inside If");
      print(responseData);

      Utils.showToast('This Mobile is not registerd',gravity: ToastGravity.TOP);
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(builder: (context) => SignUpScreen(mobileNumber: mobileNumber,)),
      // );
    }
    else {
      print("Inside Else");

      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => OtpPage( mobilenumber: mobilecontroller.text,)),
      );
    }
  }
}
