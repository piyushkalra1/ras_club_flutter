import 'dart:io';

import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:ras_club_flutter/const/setting_page_childs.dart';
import 'package:ras_club_flutter/upload_photo.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import 'const/constants.dart';
import 'login/login_screen.dart';


class Settingtab extends StatefulWidget {
  const Settingtab({Key? key}) : super(key: key);

  State<Settingtab> createState() => _SettingtabState();
}

class _SettingtabState extends State<Settingtab> {


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getnamefunction();
    getAppVersionInfo();
  }

  getnamefunction()async{
    var sharepreference =await SharedPreferences.getInstance();
    name =sharepreference.getString(Constants.USER_NAME)!;
    setState(() {

    });
  }
  @override
  String name ="";

  Future<void> _launchInBrowser(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw Exception('Could not launch $url');
    }
  }
  List<String> imagePaths = [];
  List<String> imageNames = [];
  showAlertDialog(BuildContext context) {

    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text("No"),
      onPressed:  () {
        Navigator.pop(context);
      },
    );
    Widget continueButton = TextButton(
      child: Text("Yes"),
      onPressed: () async {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setBool(Constants.IS_LOGIN, false);
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const Login(  )), (Route<dynamic> route)=> false);

      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Logout"),
      content: Text("Do you want to logout from this app?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
  String appVersion = "";

  @override
  void getAppVersionInfo() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    appVersion = packageInfo.version;
  }
  Widget build(BuildContext context) {

    return ListView(
      children: [
        InkWell(
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>UploadPhoto()));
          },
          child: Container(
            color: Colors.black12,
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(

                    width: 60.0,
                    height: 60.0,
                    decoration: BoxDecoration(
                      image: const DecorationImage(
                        image: AssetImage('assets/images/sample_user.png'),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.all( Radius.circular(75.0)),
                      border: Border.all(
                        color: Colors.black,
                        width: 1.0,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 12,),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('${name}',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                    Text('Change Profile Photo'),
                  ],
                ),
                Spacer(),
                IconButton(onPressed: (){}, icon: Icon(Icons.arrow_forward_ios_sharp))

              ],
            ),
          ),
        ),

        SettingpageChild(thumnail1: 'assets/images/settings_share.png',text: 'Share App to friends',onpress:(){
          _onShare(context);
        } ,),
        SettingpageChild(thumnail1: 'assets/images/settings_rating.png',text: 'Rate us on  store',onpress:(){
          if (Platform.isAndroid || Platform.isIOS ) {
            // final appId = Platform.isAndroid ? 'YOUR_ANDROID_PACKAGE_ID' : 'YOUR_IOS_APP_ID';
            final url = Uri.parse(
              Platform.isAndroid
                  ? "https://play.google.com/store/apps/details?id=in.solvebee.rasclub"
                  : "https://apps.apple.com/in/app/ras-club/id6443890895",
            );
            launchUrl(
              url,
              mode: LaunchMode.externalApplication,
            );
          }
          // else{
          //   print('ios device');
          //   final url = Uri.parse(
          //     Platform.isIOS
          //         ? "https://apps.apple.com/in/app/ras-club/id6443890895"
          //         : "https://play.google.com/store/apps/details?id=in.solvebee.rasclub",
          //   );
          //   launchUrl(
          //     url,
          //     mode: LaunchMode.externalApplication,
          //   );
          // }
        } ,),
        SettingpageChild(thumnail1: 'assets/images/settings_update.png',text: 'Update app from  store',onpress:(){
          if (Platform.isAndroid || Platform.isIOS) {
            final appId = Platform.isAndroid ? 'YOUR_ANDROID_PACKAGE_ID' : 'YOUR_IOS_APP_ID';
            final url = Uri.parse(
              Platform.isAndroid
                  ? "https://play.google.com/store/apps/details?id=in.solvebee.rasclub"
                  : "https://apps.apple.com/in/app/ras-club/id6443890895",
            );
            launchUrl(
              url,
              mode: LaunchMode.externalApplication,
            );
          }
        } ,),
        SettingpageChild(thumnail1: 'assets/images/settings_notifications.png',text: 'Change notification setting',onpress:(){} ,),
        SettingpageChild(thumnail1: 'assets/images/settings_helpline.png',text: 'Helpline',onpress:()async{
          final Uri phoneUrl = Uri(
            scheme: 'tel',
            path: '9783312666',
          );

          if (await canLaunch(phoneUrl.toString())) {
            await launch(phoneUrl.toString());
          } else {
            throw "Can't phone that number.";
          }
        }

        ),
        SettingpageChild(thumnail1: 'assets/images/settings_privacy.png',text: 'Privacy Policy',onpress:(){
          _launchInBrowser(Uri.parse('https://rasclub.org/privacy_policy.html'));

        } ,),
        SettingpageChild(thumnail1: 'assets/images/settings_disclaimer.png',text: 'Refund and Cancellation Policy',onpress:(){
          _launchInBrowser(Uri.parse('https://rasclub.org/cancellation_policy.html'));
        } ,),
        SettingpageChild(thumnail1: 'assets/images/settings_logout.png',text: 'Logout',onpress:(){
          showAlertDialog(context);
          // showLogoutDialog();
        } ,),
       Center(
         child:  Text("Appversion $appVersion"),
       )

      ],
    );
  }



  void _onShare(BuildContext context) async {

    final box = context.findRenderObject() as RenderBox?;

    if (imagePaths.isNotEmpty) {
      final files = <XFile>[];
      for (var i = 0; i < imagePaths.length; i++) {
        files.add(XFile(imagePaths[i], name: imageNames[i]));
      }


      await Share.shareXFiles(files,
          text: 'https://play.google.com/store/apps/details?id=in.solvebee.rasclub',
          subject: 'RacClub',
          sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size);
    } else {
      await Share.share(
           "https://apps.apple.com/in/app/ras-club/id6443890895",
          subject: 'RasClub',
          sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size);
    }
  }
}

