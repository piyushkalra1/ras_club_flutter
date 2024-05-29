import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:ras_club_flutter/Booking/banquethall_details.dart';
import 'package:ras_club_flutter/const/condition.dart';
import 'package:ras_club_flutter/const/constants.dart';
import 'package:ras_club_flutter/const/pink_button.dart';
import 'package:ras_club_flutter/model/BanqetHallAccount.dart';
import 'package:ras_club_flutter/model/ConferenceHallAccount.dart';
import 'package:ras_club_flutter/model/LiveCounters.dart';
import 'package:ras_club_flutter/model/PartyHallAccoundModel.dart';
import 'package:ras_club_flutter/model/PartyhallBookingModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../const/customstatic_dropdown.dart';
import '../model/HallBookingModal.dart';
import '../utils.dart';
import 'book_kingroom.dart';
import 'package:http/http.dart'as http;




class ConferenceHallBooking extends StatefulWidget {

  final TextEditingController dateOfFunctionController;
  final String time;
  final PartyhallBookingModel conferencehallBookingModel ;
  final  halltype;

  ConferenceHallBooking({super.key, required this.dateOfFunctionController,required this.time,required this.halltype,required this.conferencehallBookingModel});
  @override
  State<ConferenceHallBooking> createState() => _ConferenceHallBookingState();
}

class _ConferenceHallBookingState extends State<ConferenceHallBooking>  {

  late List< LiveCounters> liveCountersList;
  @override
  void initState() {
    // TODO: implement initState
    liveCountersList =widget.conferencehallBookingModel.liveCounters!;
    super.initState();

  }
  String check="";


  @override
  Color getColor(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
      MaterialState.hovered,
      MaterialState.focused,
    };
    if (states.any(interactiveStates.contains)) {
      return Colors.blue;
    }
    return Colors.red;
  }
  bool isChecked = false;
  String functionfor ="Function Organizing for*";
  final _formKey = GlobalKey<FormState>();
  TextEditingController platenumber = TextEditingController();
  TextEditingController functiontype = TextEditingController();
  TextEditingController hostname = TextEditingController();
  TextEditingController hostnumber = TextEditingController();
  int radiotittle= -1 ;
  String costplate="";
  String costperplate="";
  String totalamount="";
  String totalgst ="";
  String grandtotal="";
  String advanceamount ="";
  String advanceamountper ="";
  String genralcost ="";
  String oneplaterate = "";

  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          centerTitle: false,
          title: Text(
            "Book ${widget.halltype}",style: TextStyle1,
          ),
        ),
        body: SingleChildScrollView(
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: (){
              FocusScope.of(context).unfocus();
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  color: Colors.black12,
                  width: double.infinity,
                  padding: EdgeInsets.all(8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Hall Type :  ${widget.halltype}",style: TextStyle1,),
                      Text("Function date ${widget.dateOfFunctionController.text}"),
                      Text("Function time ${widget.time}")

                    ],
                  ),
                ),

                SizedBox(height: 14,),

                Container(
                  margin: EdgeInsets.all(10),
                  child: TextFormField(
                    controller: platenumber,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      hintText: 'Enter no.of.plates',
                      border: OutlineInputBorder(

                      ),

                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty || int.parse(value) <50) {
                        Utils.showToast( 'Please enter number of plates between 50 to 100');
                        return "Please enter number of plates between 50 to 100'";
                      }else if (int.parse(value)>100){
                        Utils.showToast( 'Please enter number of plates between 50 to 100');
                        return "Please enter number of plates between 50 to 100'";
                      }
                      return null;
                    },
                  ),
                ),

                Container(
                  margin: EdgeInsets.all(12),
                  child: CustomStaticDropdown(items: const ['Function Organizing For*',
                    'Self','Spouse','Son','Daughter','Father','Mother','Guest'
                  ], onItemSelected: (String? value) {
                    setState(() {
                      value.toString();
                      functionfor =value.toString();
                    });
                  },),
                ),
                Container(
                  margin: EdgeInsets.all(10),
                  child: TextFormField(
                    controller: functiontype,
                    decoration: const InputDecoration(
                      hintText: 'Function Type',
                      border: OutlineInputBorder(

                      ),

                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter function type';
                      }
                      return null;
                    },
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(10),
                  child: TextFormField(
                    controller: hostnumber,
                    maxLength: 10,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      hintText: 'Host Mobile Number',
                      counterText: "",
                      border: OutlineInputBorder(

                      ),

                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty || value.length !=10) {
                        Utils.showToast( 'Please enter number');
                        return "Please enter number";
                      }
                      return null;
                    },
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(10),
                  child: TextFormField(
                    controller: hostname,
                    decoration: const InputDecoration(
                      hintText: 'Host Name',
                      border: OutlineInputBorder(

                      ),

                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter Host Name';
                      }
                      return null;
                    },
                  ),
                ),

                Text("Additonal Items (Rate Mentioned Are Per Plate Basis):",style: TextStyle1,),



                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (bc,i)=>RadioListTile(
                    controlAffinity: ListTileControlAffinity.leading,
                    title: Text(widget.conferencehallBookingModel.menu![i].menuItems! ),


                    value: i,
                    onChanged: (radiovalue) {
                      print(widget.conferencehallBookingModel.menu![i].rate);
                      setState(() {
                        radiotittle = i;

                      });
                    },
                    groupValue: radiotittle,
                  ),
                  itemCount: widget.conferencehallBookingModel.menu!.length,


                ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (bc,i)=>CheckboxListTile(
                    controlAffinity: ListTileControlAffinity.leading,
                    title:Row(
                      children: [
                        Text(liveCountersList[i].itemName!,style: TextStyle(fontSize: 15),),
                        Spacer(),
                        Text(liveCountersList[i].rate!),

                      ],
                    ),

                    value: liveCountersList[i].isselected!,
                    onChanged: ( value) {

                      setState(() {
                        print(i);
                        liveCountersList[i].isselected = value!;


                      });
                    },
                  ),
                  itemCount: liveCountersList.length,


                ),

               Padding(
                 padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 8),
                 child: Column(
                   mainAxisAlignment: MainAxisAlignment.start,
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children: [
                     Text('Terms and Conditions :',style: TextStyle1,),
                     Conditions(),
                     Text("Declartion :",style: TextStyle1,),
                   ],
                 ),
               ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Checkbox(
                      checkColor: Colors.white,
                      fillColor: MaterialStateProperty.resolveWith(getColor),
                      value: isChecked,
                      onChanged: (bool? value) {
                        setState(() {
                          isChecked = value!;
                        });
                      },
                    ),
                    Expanded(child: Container(child: Text("All above information filled by me is correct to the best of my knowledge, and if it is found incorrect at any level, then forfiet the advance amount deposited by me and cancel my membership from RAS Club, Jaipur forever."))),


                  ],
                ),
                PinkButton(text: 'Continue',
                    ontap: (){
                  if(functionfor=='Function Organizing For*'|| functionfor == "Function Organizing for*"){
                    Utils.showToast('Please Select FunctionOrganizing For');
                  }
                  else
                      if(_formKey.currentState!.validate()){
                        BookConferenceHallApi();
                      }

                    })
              ],
            ),
          ),
        ),
      ),
    );
  }
  void BookConferenceHallApi ( ) async{
    Random rand = new Random();
    int rand_int1 = rand.nextInt(1000000);
    String orderId = "Order #RZP"+rand_int1.toString();
    try{
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String ids ="";
      String itemname ="";
      for(int i=0 ; i<liveCountersList.length; i++){

        if(liveCountersList[i].isselected){
          ids =ids+liveCountersList[i].id.toString()+",";
          itemname =itemname+liveCountersList[i].itemName.toString()+",";

        }

      };
      if(ids != ""){
        print(ids.substring(0,ids.length-1));
        ids =ids.substring(0,ids.length-1);
        itemname=itemname.substring(0,itemname.length-1);}

      var body ={
        "mobile":prefs.getString(Constants.MOBILE_NUMBER),
        "memberType":prefs.getString(Constants.MEMBER_Type),
        "deviceId": "4E8EB26C-9143-49ED-B415-B67EE16A9E2F",
        "refreshToken":"sgsghdsvdhjsd",
        "hardwareDetails":"",
        "name": prefs.getString(Constants.USER_NAME),
        "membership_no": prefs.getString(Constants.MEMVERSHIP_NO),
        "fdate": "${widget.dateOfFunctionController.text}",
        "ftime" :"${widget.time}",
        "hall_type" :'Conference Hall',
        "plates": "${platenumber.text}",
        "menu" :widget.conferencehallBookingModel.menu![radiotittle].menuName,
        "extra_items": "${ids==""?"0":ids}",
        "funtion_type" : "${functiontype.text}",
        "host_name": "${hostname.text}",
        "host_mobile": "${hostnumber.text}",
        "book_for" : "${functionfor.toString()}"


      };
      Response response =await http.post(Uri.parse('https://api.rasclub.org/getBestDealForHall.php'),
          headers: {
            "Accept": "application/json",
            "User-Agent":"okhttp/3.10.0",
            "Content-Type": "application/json",
            "Authorization": "Bearer ${prefs.getString(Constants.SALT)}"
          },

          body:jsonEncode(body)
      );
      var data = jsonDecode(response.body);
      if(response.statusCode==200 && data["Message"]=="Valid User"){
        print("in if");
        var data = jsonDecode(response.body);
        print(data);
        print(body);
        var conferenceaccount = ConferenceHallAccount.fromJson(data);
        print("data convert success");
        Navigator.push(context, MaterialPageRoute(builder: (context)=>BanquetHallDetails(functiondate: widget.dateOfFunctionController, functiontime: widget.time, hostname: "${hostname.text}", functiontype: "${functiontype.text}", bookingfor: "${functionfor.toString()}",plates: "${platenumber.text}", costrplate: costperplate.toString(), advance: advanceamount, amount:totalamount, gst: totalgst, grandtotal: grandtotal, number: "${hostnumber.text}", menu: widget.conferencehallBookingModel.menu![radiotittle].menuItems, items:"${itemname}", orderid: orderId, hallname: 'Conference Hall',)));

        setState(() {
          costperplate =conferenceaccount.costPerPlate.toString();
          totalamount =conferenceaccount.totalAmount.toString();
          totalgst =conferenceaccount.totalGST.toString();
          grandtotal =conferenceaccount.grandTotal.toString();
          advanceamount =conferenceaccount.advanceAmount.toString();
          advanceamountper =conferenceaccount.advanceAmount.toString();


        });

        print(response);

      } else if(data["Message"]=="Unauthorized User"){
        print("in elseif");
        Utils.showToast("Unauthorized User");
      }
      else
      {
        print("dalid");
        print(response.statusCode.toString());
        print(body);
      }
    }catch(e){
      print(e.toString());
    }
  }
}