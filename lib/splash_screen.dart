import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ras_club_flutter/homepage.dart';
import 'package:ras_club_flutter/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';
import 'const/constants.dart';


class Splash extends StatefulWidget {

  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();

}

class _SplashState extends State<Splash> {

  @override
  bool isloading = false;
  void initState() {
    super.initState();



    Timer(const Duration(seconds: 3),
            () {navigateUser();});
  }

  Future<void> navigateUser() async {
    setState(() {
      isloading =true;
    });

    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? isLogin = prefs.getBool(Constants.IS_LOGIN);
    Navigator.pushReplacement(context,
        MaterialPageRoute(builder:
            (context) {
          if(isLogin == true){
            return HomePage();
          }
          else{
            return Login();
          }
        }
        )
    );
    setState(() {
      isloading =false;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/splash1.png", ),
            fit: BoxFit.fill,
          )
        ),
        child: Center(
          child: Image.asset("assets/images/logo_round.png",height: 200,),
        )
      ),
    );
  }
}
