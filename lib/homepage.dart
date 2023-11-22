
import 'dart:io';

import 'package:app_version_update/app_version_update.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ras_club_flutter/const/constants.dart';
import 'package:ras_club_flutter/setting_tab.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:url_launcher/url_launcher.dart';

import 'const/dashboredtab.dart';
import 'const/home_tab.dart';


final List<String> imgList = [
  'assets/images/banner1.jpg',
  'assets/images/banner2.jpg',
  'assets/images/banner3.jpg',
  'assets/images/banner4.jpg',
];


class HomePage extends StatefulWidget {


  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  int _selectedIndex = 0;

  String name="";
  static const TextStyle optionStyle =
  TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static  final List<Widget> _widgetOptions = <Widget>[
    hometab(),
   Dashbordtab(),
    Settingtab(),

  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  @override


  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: false,
        backgroundColor: Colors.white,elevation: 0,
        title:appbarname[_selectedIndex],
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: NavigationBar(
        destinations: const <NavigationDestination>[
          NavigationDestination(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.dashboard),
            label: 'My Dashboard',
          ),
          NavigationDestination(
            icon: Icon(Icons.settings_sharp),
            label: 'Setting',
          ),
        ],
        selectedIndex: _selectedIndex,
        onDestinationSelected: _onItemTapped,
      ),
    );
  }
  final List<Widget> appbarname = [
    Hometabtextwidget(),
    Text('Dashboard',style: TextStyle(color: Colors.black),),
    Text('Settings',style: TextStyle(color: Colors.black),),
  ];

  }



class Hometabtextwidget extends StatefulWidget {
  const Hometabtextwidget({Key? key}) : super(key: key);

  @override
  State<Hometabtextwidget> createState() => _HometabtextwidgetState();
}

class _HometabtextwidgetState extends State<Hometabtextwidget> {
  void _verifyVersion() async {
    await AppVersionUpdate.checkForUpdates(
      appleId: '6443890895',
      playStoreId: '',
      country: 'in',
    ).then((result) async {
      print(result.storeVersion);
      if (result.canUpdate!) {

        await AppVersionUpdate.showAlertUpdate(
          appVersionResult: result,
          context: context,
          backgroundColor: Colors.grey[200],

          title: 'Update Available',
          titleTextStyle: const TextStyle(
              color: Colors.black, fontWeight: FontWeight.w600, fontSize: 24.0),

          content: Platform.isIOS?
          'New version is ${result.storeVersion} available on App Store ':
          'New version is ${result.storeVersion} available on Play Store ',
          contentTextStyle: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w400,
          ),
          updateButtonText: 'Update Now',
          cancelButtonText: 'Cancel',
        );

        //## AppVersionUpdate.showBottomSheetUpdate ##
        // await AppVersionUpdate.showBottomSheetUpdate(
        //   context: context,
        //   mandatory: true,
        //   appVersionResult: result,
        // );

        //## AppVersionUpdate.showPageUpdate ##

        // await AppVersionUpdate.showPageUpdate(
        //   context: context,
        //   appVersionResult: result,
        // );
      }
    });
    // TODO: implement initState
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _verifyVersion();
    getnamefunction();
  }
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

  getnamefunction()async{
    var sharepreference =await SharedPreferences.getInstance();
    name =sharepreference.getString(Constants.USER_NAME)!;
    setState(() {

    });
  }

  @override
  String name="";
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: showExitPopup,
      child: Row(
        children:  [
          Text('Hey, ',style: TextStyle(color: Colors.black),),
          Text(name,style: TextStyle(color: Colors.black),),
          Image(image: AssetImage('assets/images/hello.png',),height: 40,width: 30,),
          Spacer(),
          Icon(Icons.notifications_none_outlined,size: 30,),
        ],
      ),
    );
  }
}








