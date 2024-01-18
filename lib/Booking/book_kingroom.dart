import 'dart:convert';
import 'dart:math';

import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:pinput/pinput.dart';
import 'package:ras_club_flutter/bookroomDetails.dart';
import 'package:ras_club_flutter/const/pink_button.dart';
import 'package:ras_club_flutter/homepage.dart';
import 'package:ras_club_flutter/model/BookKingRoomModel.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../const/constants.dart';
import '../const/custom_grey_container.dart';
import '../const/customstatic_dropdown.dart';
import 'package:http/http.dart'as http;

import '../model/RoomRateModel.dart';
import '../utils.dart';


final List<String> imgList = [

  'assets/images/kingsizeroom_4.jpg',
  'assets/images/kingsizeroom_5.jpg',
  'assets/images/kingsizeroom_6.jpg',
  'assets/images/kingsizeroom_7.jpg',
  'assets/images/kingsizeroom_2.jpg',
  'assets/images/kingsizeroom_3.jpg',
  'assets/images/kingsizeroom_1.jpg',


];
class BookKingRoom extends StatefulWidget {
  final roomtype;

  BookKingRoom({required this.roomtype});
  @override
  State<BookKingRoom> createState() => _BookKingRoomState();
}

class _BookKingRoomState extends State<BookKingRoom> {
  String _selectedDate = '';
  String _dateCount = '';
  String _range = '';
  String _rangeCount = '';
  bool visiblecalender =false;
  String bedrequired ="Extra Bed Required*";
  String client ="Booking For*";

  bool isloading =false;
  late AnimationController controller;
  bool determinate = false;

  String totalfare="";
  String totalgst="";
  String grandtotal="";
  String totalnights ="";

  TextEditingController startdate =TextEditingController();
  TextEditingController enddate =TextEditingController();
  TextEditingController roomnumber = TextEditingController();
  DateTime checkindate =DateTime.now();
  DateTime checkoutdate =DateTime.now();
  late int difference;

  final _formKey = GlobalKey<FormState>();

  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {

    setState(() {
      if (args.value is PickerDateRange) {
        checkindate = args.value.startDate;
        if(args.value.endDate != null)
          checkoutdate =args.value.endDate;
        else
          checkoutdate = args.value.startDate;
        startdate.text= '${DateFormat('dd-MM-yyyy').format(args.value.startDate)}';
        // ignore: lines_longer_than_80_chars
         enddate.text=   ' ${DateFormat('dd-MM-yyyy').format(args.value.endDate ?? args.value.startDate)}';
         difference = checkoutdate.difference(checkindate).inDays;
      } else if (args.value is DateTime) {
        _selectedDate = args.value.toString();
      } else if (args.value is List<DateTime>) {
        _dateCount = args.value.length.toString();
      } else {
        _rangeCount = args.value.length.toString();
      }
    });
  }
  String? get _errorText {
    // at any time, we can get the text from _controller.value.text
    final text1 = startdate.value.text;
    final text2 =enddate.value.text;
    if (text1.isEmpty || text2.isEmpty) {
      return 'Can\'t be empty';
    }

    // return null if the text is valid
    return null;
  }

  @override
  TextEditingController dateOfFunctionController = TextEditingController();
  Widget build(BuildContext context) {
    return  Form(
      key: _formKey,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,centerTitle: false,
          title: Text(widget.roomtype),
        ),
        body: ListView(
          children: [
            Container(
              margin: EdgeInsets.all(10),


              child: ClipRRect(
                borderRadius: BorderRadius.only(topRight:Radius.circular(18) ,topLeft: Radius.circular(18),
                    bottomRight: Radius.circular(18),bottomLeft: Radius.circular(18)
                ),
                child: CarouselSlider(
                  options: CarouselOptions(
                      height: 300.0,
                      autoPlay: true,
                      viewportFraction: 1,
                      onPageChanged: (index, reason) {
                        // setState(() {
                        //   incrementIndex();
                        // });
                      }),
                  items: [0, 1, 2,3,4,5,6,].map((i) {
                    return Builder(
                      builder: (BuildContext context) {
                        return
                          Image.asset(

                            imgList[i],
                            fit: BoxFit.fill,
                          );
                      },
                    );
                  }).toList(),
                ),
              ),
            ),
            Center(child: Text('Make Your Room Reservation',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[


                Row(
                  children: [
                    SizedBox(width: 10,),
                    CustomGrayContainer(
                      width: MediaQuery.of(context).size.width/2-20,
                        icon: Icon(Icons.calendar_month_outlined,color: Colors.pink,),
                        child: TextFormField(
                            controller: startdate, readOnly:true,
                            onTap:()async {
                              setState(() {
                                visiblecalender =!visiblecalender;
                                Text("${_selectedDate}");
                              });

                            },
                            decoration: const InputDecoration(
                              hintText: "Check-in",
                              enabled: true,




                              // hintStyle: KTextStyle.textFieldHintStyle,
                              border: InputBorder.none,
                            ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {

                              ScaffoldMessenger.of(context).showSnackBar(

                                const SnackBar(backgroundColor: Colors.white12,
                                    content: Text('Please enter check-in',style: TextStyle(color: Colors.red),)),
                              );
                            }
                            return null;
                          },
                        )),
                    SizedBox(width: 15,),
                    CustomGrayContainer(
                      width: MediaQuery.of(context).size.width/2-20,
                        icon: Icon(Icons.calendar_month_outlined,color: Colors.pink,),
                        child: TextFormField(
                            controller: enddate,
                            readOnly: true,
                            onTap: () async {
                              setState(() {
                                visiblecalender =!visiblecalender;
                              });

                            },
                            decoration: const InputDecoration(
                              hintText: "Check-out",
                              enabled: true,
                              // hintStyle: KTextStyle.textFieldHintStyle,
                              border: InputBorder.none,
                            ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {

                              ScaffoldMessenger.of(context).showSnackBar(

                                const SnackBar(backgroundColor: Colors.white12,
                                    content: Text('Please enter CHeck-out',style: TextStyle(color: Colors.red),)),
                              );
                            }
                            return null;
                          },
                        )),
                  ],
                ),

                Visibility(
                  visible: visiblecalender,
                  child: Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 30),
                        child: SfDateRangePicker(
                          minDate: DateTime.now(),
                          onSelectionChanged: _onSelectionChanged,
                          selectionMode: DateRangePickerSelectionMode.range,
                          initialSelectedRange: PickerDateRange(

                              DateTime.now(),
                              DateTime.now().add(Duration(days: 1))),
                        ),
                      ),
                      Positioned(
                        right: 10,
                          child: IconButton(icon: Icon(Icons.close),onPressed: (){
                            setState(() {
                              visiblecalender=false;
                            });
                          },))
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(10),
                  child: TextFormField(
                    controller: roomnumber,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      hintText: 'Enter no.of.rooms',
                      border: OutlineInputBorder(

                      ),

                    ),
                      validator: (value) {
                if (value == null || value.isEmpty) {
                return 'Please enter room number';
                }else if (int.parse(value) < 1 || int.parse(value) > 20){
                  return 'We have only 20 King size room pls fill less';
                }
                return null;
                },
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(12),
                  child: CustomStaticDropdown(items: const ['Extra Bed Required*',
                    'No',
                    'Yes'
                  ], onItemSelected: (String? value) {

                    setState(() {
                      value.toString();
                      bedrequired =value.toString();
                    });
                  },),
                ),
                Container(
                  margin: EdgeInsets.all(12),
                  child: CustomStaticDropdown(items: const ['Booking For*',
                    'Self','Spouse','Son','Daughter','Father','Mother','Guest'

                  ], onItemSelected: (String? value) {
                    setState(() {
                      value.toString();
                      client =value.toString();
                    });
                  },),
                ),

                PinkButton(text: "Check  Availability",ontap: () {
                  if (_formKey.currentState!.validate()) {
                    if(client=='Booking For*'){
                      Utils.showToast('please select booking for');
                      return;
                    }else if(bedrequired =='Extra Bed Required*'){
                      Utils.showToast('please select bed requirement');
                    }
                    else
                    BookKingRoomApi();
                  }
                },),
                SizedBox(height: 30,)



              ],
            ),

          ],
        ),
      ),
    );
  }
  void BookKingRoomApi ( ) async{
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
        "no_of_rooms":"${roomnumber.text}",
        "checkin":
        "${startdate.text}",
        "checkout":
        "${enddate.text}",
        "extra_bed":
        "${bedrequired}",
        "booking_for" :
        "${client}",
      };
      Response response =await http.post(Uri.parse('https://api.rasclub.org/checkRoomsAvailablity.php'),
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
        var bookkingroomModel =BookKingRoomModel.fromJson(data);
        print("data convert success");
        setState(() {

          totalfare=bookkingroomModel.totalFair.toString();
          totalgst =bookkingroomModel. totalGST!.toString();
          grandtotal =bookkingroomModel.grandTotal!.toString();
          totalnights =bookkingroomModel.totalNights!.toString();
        });
        if(int.parse(totalnights)<6){
          showModalBottomSheet<void>(
            isScrollControlled: true,
            context: context,
            builder: (BuildContext context) {
              return Container(
                height: 420,

                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20)
                    )
                ),
                child: Center(
                  child:  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(height: 160,
                        decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20)

                            ),
                            color: Colors.black12
                        ),
                        child: Center(
                          child: Column(
                            children: [
                              SizedBox(height: 13,),
                              if(bookkingroomModel.availablity=="Available")...{

                                CircleAvatar(
                                  backgroundColor: Colors.white,
                                  child: IconButton(

                                    icon: Icon(Icons.check,color: Colors.green,),
                                    onPressed: () {},
                                  ),
                                ),
                              }else...{
                                CircleAvatar(
                                  backgroundColor: Colors.red,
                                  child: IconButton(

                                    icon: Icon(Icons.close,color: Colors.white,),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                  ),
                                ),
                              },


                              SizedBox(height: 12,),
                              Text('King Size Room',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Column(
                                    children: [
                                      Text('Check-in:',style: TextStyle1),
                                      Text('${startdate.text}',style: TextStyle(fontSize: 15),)
                                    ],
                                  ),
                                  SizedBox(width: 10,),
                                  Container(width: 2,height: 30,color: Colors.black45,),
                                  SizedBox(width: 10,),
                                  Column(
                                    children: [
                                      Text('Check-out:',style: TextStyle1),
                                      Text('${enddate.text}',style: TextStyle(fontSize: 15),)
                                    ],
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                      CommonRow( tittle: 'Total Stay : ', requirement: '${totalnights}Night',),
                      CommonRow(tittle:'Total Rooms : ' , requirement: '${roomnumber.text} Room/s'),
                      CommonRow(tittle:'Extra Bed Required : ' , requirement: '${bedrequired}'),
                      CommonRow(tittle: 'Booking For : ', requirement: ' ${client}'),
                      CommonRow(tittle: 'Total Fair : ', requirement: ' ₹${totalfare}.00'),
                      CommonRow(tittle: 'GST @12% : ', requirement: ' ₹ ${totalgst}.00'),
                      CommonRow(tittle: 'Grand Total : ', requirement: ' ₹ ${grandtotal}.00'),

                      if(bookkingroomModel.availablity=="Available")...{

                        InkWell(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>BookRoomDetails(roomname: 'King Size Room', checkindate: '${startdate.text}', checkoutdate: '${enddate.text}', Nightstay: '${totalnights}', RoomNumbers: '${roomnumber.text}',bookingfor: '$client',Bedrequired: '${bedrequired}',totalfair: ' ${totalfare}.00',gst:'${totalgst}.00' ,grandtotal:'${grandtotal}.00' ,
                            )
                            ));
                          },

                          child: Container(
                            height: 40,
                            color: Colors.green,
                            width: double.infinity,
                            margin: EdgeInsets.symmetric(vertical: 8),
                            child: Center(child: Text('Book Now',style: TextStyle(fontSize: 20,color: Colors.white),)),
                          ),
                        )
                      }
                      else
                        InkWell(
                          onTap: (){},
                          child: Container(
                            height: 40,
                            color: Colors.red,
                            width: double.infinity,
                            margin: EdgeInsets.symmetric(vertical: 8),
                            child: Center(child: Text('Not Avialable',style: TextStyle(fontSize: 20,color: Colors.white),)),
                          ),
                        )




                    ],
                  ),
                ),
              );
            },
          );
        }
        else
          await showDialog(
            context: context,
            builder: (context) => new AlertDialog(
              title: new Text('Alert',textAlign: TextAlign.center,),
              content: Text(
                  'You can make upto 5 nights booking at a time',textAlign: TextAlign.center,style: TextStyle(
                fontWeight: FontWeight.bold
              ),),
              actions: <Widget>[
                new TextButton(
                  onPressed: () {
                    Navigator.of(context, rootNavigator: true)
                        .pop(); // dismisses only the dialog and returns nothing
                  },
                  child: new Text('OK'),
                ),
              ],
            ),
          );

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
  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    // getPaymentStatus(response.paymentId);
    print(response.signature);

    setState(() {

    });
    SavePaymentRoom(response.paymentId,response.signature);
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomePage()));

  }

  void _handlePaymentError(PaymentFailureResponse response) {
    print("Error while making payment   ${response.message}");
    print("Error while making payment   ${response.code}");
    print("Error while making payment   ${response.error}");
    print("Error while making payment   ${response.toString()}");

    setState(() {
      isloading = false;
    });
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomePage()));
    Fluttertoast.showToast(
        msg: "Payment Failed",
        toastLength: Toast.LENGTH_SHORT,

        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.redAccent,
        textColor: Colors.white,
        fontSize: 16.0
    );
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Do something when an external wallet is selected

    print(response.walletName);
  }


  Future<void> getPaymentStatus(String? paymentId) async {
    if(paymentId == null)
    {
      return;
    }
    const url = "https://api.rasclub.org/savePaymentForRooms.php";
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String mobileNumber = prefs.getString(Constants.MOBILE_NUMBER)!;
    String name = prefs.getString(Constants.USER_NAME)!;
    String email = prefs.getString(Constants.EMAIL )!;
    String token = prefs.getString(Constants.SALT)!;
    Map<String, String> body = {
      "name": name,
      "mobile": mobileNumber,
      "email":email,

      "payment_id":paymentId,
      "deviceId": Utils.deviceId??"",
      "refreshToken": "sgsghdsvdhjsd",
      "hardwareDetails": Utils.deviceData??"",
    };
    print(token);
    var headers = {
      "Accept": "application/json",
      "Content-Type": "application/json",
      "User-Agent": "okhttp/3.10.0",
      'Authorization': 'Bearer $token',
    };

    var response = await http.post(Uri.parse(url),
        headers: headers,
        body: jsonEncode(body),
        encoding: Encoding.getByName("utf-8"));
    Map<String, dynamic> responseData = json.decode(response.body);
    if (responseData['status'] == '200' &&
        responseData["response"] == 'payment details successfully updated') {
      Fluttertoast.showToast(
          msg: "Payment Successful",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0
      );
      if(!mounted) return;
      // getMembers();

    }
  }

  void SavePaymentRoom (String? paymentId, String? signature) async{
    Random rand = new Random();
    int rand_int1 = rand.nextInt(1000000);
    String orderId = "Order #RZP"+rand_int1.toString();
    try{
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var body ={
        "mobile":prefs.getString(Constants.MOBILE_NUMBER),
        "member_type":prefs.getString(Constants.MEMBER_Type),
        "deviceId": "4E8EB26C-9143-49ED-B415-B67EE16A9E2F",
        "refreshToken":"sgsghdsvdhjsd",
        "hardwareDetails":"",
        "name":
        prefs.getString(Constants.USER_NAME),
        "membership_no": prefs.getString(Constants.MEMVERSHIP_NO),
        "email": prefs.getString(Constants.EMAIL),
        "payment_id": paymentId,
        // "order_id": widget.orderid,
        "signature_hash":signature,

        "order_id": orderId,
        "room_type": widget.roomtype,
        "checkin": '${startdate.text}',
        "checkout": '${enddate.text}',
        "no_of_rooms": '${roomnumber.text}',
        "total_nights": '${totalnights}',
        "extra_bed": '${bedrequired}',
        "booking_for": '${client}',
        "total_fair": '${totalfare}.00',
        "total_gst": '${totalgst}.00',
        "grand_total":'${grandtotal}.00'


      };
      print(body);
      Response response =await http.post(Uri.parse('https://api.rasclub.org/savePaymentForRooms.php'),
          headers: {
            "Accept": "application/json",
            "User-Agent":"okhttp/3.10.0",
            "Content-Type": "application/json",
            "Authorization": "Bearer ${prefs.getString(Constants.SALT)}"
          },

          body:jsonEncode(body)
      );
      print("${prefs.getString(Constants.SALT)}");
      if(response.statusCode==200){
        var data = jsonDecode(response.body);
        print(data);
        print(body);
        print("data convert success");
        print(response);
        setState(() {
        });

      }else
      {
        CircularProgressIndicator();
        print("dalid");
        print(response.statusCode.toString());
        print(body);
      }
    }catch(e){
      print(e.toString());
    }
  }
}

class CommonRow extends StatelessWidget {
  final String tittle;
  final String requirement;
   CommonRow({
    required this.tittle,
    required this.requirement,
  });



  @override
  Widget build(BuildContext context) {
    return Row(

      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(child: Text(tittle,style: TextStyle(fontSize: 15),textAlign: TextAlign.right,)),
        Expanded(child: Text(requirement,style: TextStyle1,textAlign: TextAlign.left,))
      ],
    );
  }
}


const TextStyle1=TextStyle(fontSize: 20,fontWeight: FontWeight.w600);