import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../login/login_screen.dart';
class DialogError extends StatelessWidget {
  final String? errorMsg;

  const DialogError({Key? key, required this.errorMsg}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        child: Dialog(
            backgroundColor: Colors.transparent,
            alignment: Alignment.center,
            child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20), color: Colors.white),
                child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Lottie.asset('assets/lottie/error.json', width: 80),
                      const Text(
                        "Alert !",
                        style: TextStyle(

                            fontSize: 32,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                    Text('Session Expired'),
                      Text("Please Login Again"),
                      const SizedBox(
                        height: 6,
                      ),
                      ElevatedButton(
                          onPressed: ()async{
                            SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
                            sharedPreferences.clear();
                            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>Login()), (route) => false);
                          },
                          child: Text("Login"))
                    ]))),
      ),
    );
  }
}
