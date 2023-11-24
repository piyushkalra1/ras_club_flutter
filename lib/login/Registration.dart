import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:ras_club_flutter/const/pink_button.dart';
import 'package:http/http.dart'as http;
import 'package:ras_club_flutter/login/login_screen.dart';
import '../utils.dart';
import 'custom/AppDropDown.dart';
import 'custom/cutomtextfield.dart';

class RegisterUser extends StatefulWidget {
  const RegisterUser({super.key});

  @override
  State<RegisterUser> createState() => _RegisterUserState();
}

class _RegisterUserState extends State<RegisterUser> {
  final List<String> genderlist = ["Gender","Male","Female"];


  late String selgender = genderlist.first;
  final _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController emailidController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  bool isloading =false;
  @override
  Widget build(BuildContext context) {
    return  Form(
      key: _formKey,
      child: Scaffold(
        appBar: AppBar(

          leading: IconButton(icon: Icon(Icons.arrow_back),onPressed: (){
            Navigator.pop(context);
          },),
          backgroundColor: Colors.white,
          elevation: 0,
          title: Text('Registration'),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Image.asset("assets/images/logo_round.png",scale: 1.5,),
              SizedBox(height: 15,),

              CustomTextField(
                controller: nameController,
                hint: "Your Name*",
                textCapitalization: TextCapitalization.words,
                padding: EdgeInsets.symmetric(
                    horizontal: 8, vertical: 8),
                validation: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your Name';
                  } else if (value.length < 3) {
                    return "Please enter your Name";
                  }
                  return null;
                },
              ),

              CustomTextField(
                controller: mobileController,
                hint: "Your Mobile Number*",
                textInputType: TextInputType.number,
                inputFormatters: [
                  LengthLimitingTextInputFormatter(10),
                  FilteringTextInputFormatter.digitsOnly
                ],
                padding: EdgeInsets.symmetric(
                    horizontal: 8, vertical: 8),
                validation: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your Mobile Number';
                  } else if (value.length != 10) {
                    return "Please enter your 10 digit mobile number";
                  }
                  return null;
                },
              ),

              CustomTextField(
                controller: emailidController,
                hint: "Your Email Id*",
                textInputType: TextInputType.emailAddress,
                padding: EdgeInsets.symmetric(
                    horizontal: 8, vertical: 8),
                validation: (value) {
                  if (value == null ||
                      value.isEmpty ||
                      !value.contains('@') ||
                      !value.contains('.')) {
                    return 'Invalid Email';
                  }
                  return null;
                },
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 10,vertical: 6),
                child: AppDropdown(
                    dropdownList: genderlist,
                    dropdownValue: selgender,
                    onChanged: (value) {
                      setState(() {
                        selgender = value!;
                      });
                      print(selgender);
                    }),
              ),
              CustomTextField(
                controller: dobController,
                hint: "Date of Birth*(DD-MM-YYYY)",
                suffixIcon: Icons.calendar_month,
                readOnly: true,
                onTap: () {
                  pickDate();
                },
                padding: EdgeInsets.symmetric(
                    horizontal: 8, vertical: 8),
                validation: (value) {
                  if (value == null || value.isEmpty) {
                    return "please choose your date of birth";
                  }
                  return null;
                },
              ),

              PinkButton(ontap: (){ print(selgender);
                if(_formKey.currentState!.validate()){
                  if(selgender=="Gender"){
                    Utils.showToast('Please select your gender');
                  }
                  else
                    print(selgender);
                 callApi();
                }
                else
                  Utils.showToast('Please fill all the details');

              }, text: 'Register')
            ],
          ),
        ),
      ),
    );
  }
  void pickDate() async {
    DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime(DateTime.now().year-18),
        firstDate: DateTime(1950),
        //DateTime.now() - not to allow to choose before today.
        lastDate: DateTime(DateTime.now().year-15),);

    if (pickedDate != null) {
      print(pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
      String formattedDate = DateFormat('dd MMM yyyy').format(pickedDate);
      dobController.text = formattedDate;
    }
  }


  Future<void> callApi() async {
    setState(() {
      isloading = true;
    });

    const url = "https://api.rasclub.org/userSignup.php";
    print("Device Data " + Utils.deviceData!);
    var body = {
      "mobile": mobileController.text,
      "deviceId": Utils.deviceId!,
       "email": emailidController.text,
       "name": nameController.text,
      "gender":selgender.toString(),
       "dob":dobController.text,
    };
    var response = await http.post(Uri.parse(url),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json",
          "User-Agent": "okhttp/3.10.0"
        },
        body: jsonEncode(body),
        encoding: Encoding.getByName("utf-8")
    );
    Map<String, dynamic> responseData = json.decode(response.body);
    setState(() {
      isloading = false;
    });
    print(responseData);
    print(body.toString());
    if(response.statusCode==200){
      if (responseData['response'].toString().trim() == 'Member successfully registered') {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Login()));
       Utils.showSuccessToast('Successfully Register');
      }
      else if(responseData ['response'].toString().trim()=="This mobile no. id already registered"){
        Utils.showToast('This mobile no. id already registered');
      }
    }
    else
      Utils.showToast('Something Went Wrong');
  }
}
