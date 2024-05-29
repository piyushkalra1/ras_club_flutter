import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:ras_club_flutter/const/pink_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../login/login_screen.dart';
class DialogAttention extends StatelessWidget {

  final ontap;

  const DialogAttention({Key? key, required this.ontap}) : super(key: key);

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
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white),
                child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Lottie.asset('assets/lottie/attention.json', width: 100),

                      const Text(
                        "*Attention Member:*",
                        style: TextStyle(

                            fontSize: 26,
                            fontWeight: FontWeight.bold),
                      ),

                      const SizedBox(
                        height: 6,
                      ),
                      Text(
                          "Kindly note that there is a maximum limit of 5 rooms per member for booking at member rates of same dates, irrespective of the room category. We appreciate your understanding and cooperation."),
                      const SizedBox(
                        height: 6,
                      ),
                      PinkButton(ontap: ontap, text: "CONTINUE"),
                    ]))),
      ),
    );
  }
}
