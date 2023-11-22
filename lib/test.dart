import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:ras_club_flutter/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart'as http;

import 'const/constants.dart';
import 'homepage.dart';

class Test extends StatefulWidget {
  final mobilenumber;
  const Test({Key? key,required this.mobilenumber}) : super(key: key);

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(),
      body: TextButton(onPressed: (){
        callApi();

      }, child: Text('dj')),
    );
  }
  Future<void> callApi() async {
    // setState(() {
    //   isloading = true;
    // });
    const url = "https://api.rasclub.org/getRoomRates.php";

    var body = {
      "mobile": widget.mobilenumber,
      "memberType":"",
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
    print(responseData);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      // isloading = false;
    });
    print(responseData);
    if (responseData['Message'] == 'OTP verified') {
      prefs.setBool(Constants.IS_LOGIN, true);
      prefs.setString(Constants.SALT, responseData['Salt']);
      // prefs.setString(Constants.MOBILE_NUMBER, widget.mobilenumber);
      prefs.setString(Constants.USER_NAME, responseData['Name']);
      prefs.setString(Constants.EMAIL, responseData['Email']);
      print("Inside If");
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
              builder: (context) =>  HomePage()
          ),  (Route<dynamic> route) => false);
    } else {
      Utils.showToast("Please Enter Correct OTP");
    }
  }
}
