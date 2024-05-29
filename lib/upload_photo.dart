import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart'as http;
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ras_club_flutter/model/ImageModel.dart';
import 'package:ras_club_flutter/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'const/constants.dart';

class UploadPhoto extends StatefulWidget {
  const UploadPhoto({Key? key}) : super(key: key);

  @override
  State<UploadPhoto> createState() => _UploadPhotoState();
}

class _UploadPhotoState extends State<UploadPhoto> {
  @override
  String imagepath = '';
  File? imageFile;
  ImagePicker image =ImagePicker();
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: false,
        elevation: 0,
        title: Text('Upload Photo'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 100,),

            Center(
                child: InkWell(
                  onTap: (){},
                  child: Container(
                      width: 300,
                      height: 300,
                      decoration: BoxDecoration(
                        border: Border.all(
                            width: 1.0,
                            color: Theme.of(context).scaffoldBackgroundColor
                        ),
                        boxShadow: [
                          BoxShadow(
                            spreadRadius: 1,
                            blurRadius: 20,
                            color: Colors.black.withOpacity(0.2),
                            offset: Offset(0,10),
                          )
                        ],
                        shape: BoxShape.circle,
                      ),
                      child: Card(
                        clipBehavior: Clip.hardEdge,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(200)),
                        child: imagepath.isEmpty
                            ? Image.asset("assets/images/man.jpg")
                            : Image.memory(
                          base64Decode(imagepath),
                          fit: BoxFit.fill,
                          gaplessPlayback: true,
                        ),
                      )),
                )),

            Spacer(),
            Row(
              children: [
                InkWell(
                  onTap: (){


                    pickImage();

                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width/2-2,
                    padding: EdgeInsets.symmetric(vertical: 12),
                    color: Colors.pink,
                    child: const Center(
                      child: Text('PICK PHOTO',style: TextStyle(
                        color: Colors.white,fontWeight: FontWeight.bold,fontSize: 16
                      ),),
                    ),
                  ),
                ),
                SizedBox(width: 5,),
                InkWell(
                  onTap: (){

                    SaveImageApi();
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width/2-3,
                    padding: EdgeInsets.symmetric(vertical: 12),
                    color: Colors.pink,
                    child: const Center(
                      child: Text('SAVE PHOTO',style: TextStyle(
                          color: Colors.white,fontWeight: FontWeight.bold,fontSize: 16
                      ),),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10,)
          ],
        ),
      ),
    );
  }


  void pickImage() async {
    final ImagePicker _picker = ImagePicker();
    // Pick an image
    final XFile? image = await _picker.pickImage(
        source: ImageSource.gallery,
        maxHeight: 400,
        maxWidth: 400,
        imageQuality: 80);
    if (image != null) {
      final bytes = image.readAsBytes();
      imageFile = File(image.path);
      bytes.then((value) {
        setState(() {
          imagepath = base64Encode(value);
        });
        print("toreiiaroaifnfgasdidnifdsni");
        print(imagepath);
      });
    }
  }

  void SaveImageApi ( ) async{
    try{
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var body ={
        "mobile":prefs.getString(Constants.MOBILE_NUMBER),
        "memberType":prefs.getString(Constants.MEMBER_Type),
        "deviceId": "4E8EB26C-9143-49ED-B415-B67EE16A9E2F",
        "refreshToken":"sgsghdsvdhjsd",
        "hardwareDetails":"",
        "name": prefs.getString(Constants.USER_NAME),
        "room_type": "King Size Room",
        "photo": "${imagepath}",

      };
      Response response =await http.post(Uri.parse('https://api.rasclub.org/saveMemberProfilePic.php'),
          headers: {
            "Accept": "application/json",
            "User-Agent":"okhttp/3.10.0",
            "Content-Type": "application/json",
            "Authorization": "Bearer ${prefs.getString(Constants.SALT)}"
          },

          body:jsonEncode(body)
      );
      if(response.statusCode==200){
        var data = jsonDecode(response.body);
        print(data);
        print(body);
        print(response);
        SharedPreferences preferences = await SharedPreferences.getInstance();
        preferences.setString(Constants.Photo, imagepath);
        var imageModel =ImageModel.fromJson(data);
        print("data convert success");
        setState(() {
          // imagepath = imagepath;


        });

      }else
      {
        print("dalid");
        print(response.statusCode.toString());
        print(body);
      }
    }catch(e){
      print(e.toString());
    }
  }



  // Future getcam()async{
  //   var img = await image.getImage(source: ImageSource.camera);
  //   setState(() {
  //     file= File(img!.path);
  //   });
  // }
  //
  // getgallery()async{
  //   var img = await image.getImage(source: ImageSource.gallery);
  //   setState(() {
  //     file= File(img!.path);
  //   });
  // }

}
