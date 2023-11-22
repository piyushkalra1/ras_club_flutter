import 'package:flutter/material.dart';

import '../const/home_icon_stacks.dart';

class AboutUS extends StatelessWidget {
  const AboutUS({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,

        child: HomeIconStacks(thumbnail: 'assets/images/img2.jpg',tittle: 'About us',
          subtittle: "Excellently endowed with 40 luxurious rooms, an elegant and lavishly laid out 24 hours Lounge Cafe, Bar and Restaurant, a 500 plus Capacity Banquet, Business Conference Room for 200, Billiards and Card rooms, Spa and Kids Zone, an all under one roof health and wellbeing destination with best equipped Gymnasium, Swimming Pool, Badminton Courts, Squash Court, Roof Top Tennis Court etc.\n\n"
              "Added with conference Hall and exhibition area, we are also an ideal MICE venue.\n\n"
              "We discern and appreciate your social status and refined lifestyle and reckon you would like to join this Club and gift yourself and your family, a lifelong cruise on the happiness highway!\n"


          ,),
      ),
    );
  }
}
