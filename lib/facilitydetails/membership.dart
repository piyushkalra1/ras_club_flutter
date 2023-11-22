import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../const/home_icon_stacks.dart';

class Membership extends StatelessWidget {
  const Membership({Key? key}) : super(key: key);
  Future<void> _launchInBrowser(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,

          child: HomeIconStacks(thumbnail: 'assets/images/img2.jpg',tittle: 'Membership',
            subtittle: "RAS Club is a stable yet happening, friendly yet exciting and an upcoming important part in the lives of the officers of Rajasthan Administrative Service. It was a growing membership and offers support to members for the fullest development of their imposing personalities.\n"
                "The Club serves as a place where members and their families can come to feel at home and participate in life mending activities such as Gymnasium, Spa, Ample Parking, Grand Lounge, Swimming Pool, Cafeteria (Indoor and Outdoor), 600 pax capacity Banquet, Movable Partition Conference Hall, Party Hall, Kids Zone, Exhibition Area, 40 Rooms (Including 6 Suits, 10 Twin Sharing and 24 Deluxe), Hill view Bar and Restaurant, Rooftop Badminton, Squash and Tennis Court, Indoor Games etc.\n"
                "We welcome all such people who have and interest to immerse in such social activities. Be it from corporate or private sectors, RAS Club is your single stop place to make a bold style statement for people who value quality living. Some benefits of The Club include empowerment, companionship and maintaining one's balance in life while of course rubbing shoulders with the cream of Bureaucracy, Successful Businessmen and Professionals.\n",
            // button1: 'Download Brouchure',ontap: (){
            //   _launchInBrowser(Uri.parse('https://www.rasclub.org/downloads/brochure.pdf'));
            // },



            ),
        ),
      ),
    );
  }
}
