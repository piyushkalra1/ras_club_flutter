import 'package:flutter/material.dart';
import 'package:ras_club_flutter/Booking/banquethall_details.dart';
import 'package:ras_club_flutter/const/dashboard_cards.dart';

import '../Booking/book_twinbedroom.dart';
import '../const/dashbord_stack_container.dart';
import 'model/GetHallBookingModel.dart';

class HallBooking extends StatefulWidget {

  final GetHallBookingModel data;
  HallBooking({required this.data});
  @override
  State<HallBooking> createState() => _HallBookingState();
}

class _HallBookingState extends State<HallBooking> {
  @override
  Widget build(BuildContext context) {
    print( widget.data.hallbookings!.length,);
    return Scaffold(

      body: Stack(
        children: [
          DashboaredStackContainer(tittle: 'Hall Bookings',gradient: linergradienthall,),
          Positioned(
              top: 130,

              child: Container(
                height: MediaQuery.of(context).size.height, width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.white
                ),
                child:ListView.builder(
                    itemCount: widget.data.hallbookings!.length,
                    itemBuilder: (BuildContext context, int index) {
                      return  Container(

                        padding: EdgeInsets.all(8),
                        margin: EdgeInsets.all(12),

                        decoration: BoxDecoration(

                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                                width: 2,
                                color: Colors.black12
                            )
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 4),
                              child: Row(
                                children: [
                                  Text('${widget.data.hallbookings![index].hallType}',style: TextStyle1,),
                                  Spacer(),
                                  Text('Expired'),
                                  if(widget.data.hallbookings![index].status== 'Expired')...{
                                    Icon(Icons.circle,color: Colors.red,size: 12,)
                                  }else
                                    Icon(Icons.circle,color: Colors.green,size: 12,)
                                ],
                              ),
                            ),




                            Center(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('Function date:',style: TextStyle2),
                                  Text('${widget.data.hallbookings![index].fdate}',style: TextStyle(fontSize: 15),),
                                  SizedBox(height: 12,),
                                  Text('Function Timw:',style: TextStyle2),
                                  Text('${widget.data.hallbookings![index].ftime}',style: TextStyle(fontSize: 15),),


                                ],
                              ),
                            ),
                            SizedBox(height: 12,),
                            Center(child: Text('Selected Menu :',style: TextStyle2,)),
                            Text('${widget.data.hallbookings![index].menu}',textAlign: TextAlign.center,),
                            SizedBox(height: 12,),
                            Center(child: Text('Extra items:',style: TextStyle2,)),
                            Text('${widget.data.hallbookings![index].extraItems}',textAlign: TextAlign.center,),

                            SizedBox(height: 20,),
                            Divider(thickness: 1,),
                            Container1(text1: "No of Plates", text2: "${widget.data.hallbookings![index].totalPlates}"),
                            Row1(text1: 'Booking for', text2: "${widget.data.hallbookings![index].bookFor}"),
                            Container1(text1: "Function Type", text2: "${widget.data.hallbookings![index].fdate}"),
                            Row1(text1: 'Host Name', text2: "${widget.data.hallbookings![index].hostName}"),
                            Container1(text1: "Host Mobile No.", text2: "${widget.data.hallbookings![index].hostMobile}"),
                            Row1(text1: 'Cost Per PLate', text2: "₹ ${widget.data.hallbookings![index].ratePerPlate}"),
                            Container1(text1: "Total Amount", text2: "₹ ${widget.data.hallbookings![index].totalAmount}"),
                            Row1(text1: "Total GST", text2: "₹ ${widget.data.hallbookings![index].gst}"),
                            Container1(text1: "Grand Total", text2: "₹ ${widget.data.hallbookings![index].grandTotal}"),
                            Row1(text1: "Advance  Amount", text2: "₹ ${widget.data.hallbookings![index].advancePaid}"),
                            Container1(text1: "Booking Time", text2: "${widget.data.hallbookings![index].createdAt}"),
                            Row1(text1: "Booking Id ", text2: "${widget.data.hallbookings![index].orderId}"),




                          ],
                        ),
                      );
                    })
              ),)
        ],
      ),
    );
  }
}

const TextStyle2= TextStyle(fontWeight: FontWeight.bold,fontSize: 15);


class Row1 extends StatelessWidget {
  final text1;
  final text2;

  Row1({required this.text1,required this.text2});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        SizedBox(width: 10,),
        Expanded(child: Text(text1,style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500),)),
        Expanded(child: Text(text2,style: TextStyle2,)),
      ],
    );
  }
}

class Container1 extends StatelessWidget {
  final text1;
  final text2;
  Container1({required this.text1,required this.text2});
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black12,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(width: 10,),
          Expanded(child: Text(text1,style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500),)),
          Expanded(child: Text(text2,style: TextStyle2,)),
        ],
      ),
    );
  }
}