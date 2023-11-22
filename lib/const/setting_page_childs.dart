import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingpageChild extends StatelessWidget {
  final text;
  final thumnail1;
  final onpress;

  SettingpageChild({required this.text, required this.onpress,required this.thumnail1});



  @override
  Widget build(BuildContext context) {
    return  Container(
      margin: EdgeInsets.only(left: 15),
      child: Column(
        children: [
          InkWell(
            onTap: onpress,
            child: Row(
              children: [
                Image(image: AssetImage(thumnail1),height: 20,),
                SizedBox(width: 20,),
                Text(text),
                Spacer(),
                IconButton(onPressed: onpress, icon: Icon(Icons.arrow_forward_ios_sharp))
              ],
            ),
          ),
          Divider(thickness: 1,)

        ],
      ),
    );
  }
  Future<void> _launchInBrowser(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw Exception('Could not launch $url');
    }
  }
}