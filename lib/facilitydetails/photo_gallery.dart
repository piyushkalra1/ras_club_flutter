import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../const/image_list.dart';




class PhotoGallery extends StatelessWidget {
  const PhotoGallery({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: false,
        title: Text('Photo Gallery'),
      ),
      body:
      ListView(
        children: [
          Container(
            margin: EdgeInsets.only(left: 20),
              child: Text('Cafe and Lounge',style: TextStyle(fontSize: 22,),)),
          CarouselSlider(
            options: CarouselOptions(
                height: 180.0,
                reverse: false,
                enableInfiniteScroll: false,
                enlargeCenterPage: true,
                aspectRatio: 16/ 9,
                autoPlay: false,
                viewportFraction: 0.7,
                onPageChanged: (index, reason) {
                  // setState(() {
                  //   incrementIndex();
                  // });
                }),
            items: [0, 1, 2,3,4,5,6,7,8,9,10,11,12,13].map((i) {
              return Builder(
                builder: (BuildContext context) {
                  return
                  Container(
                    // width: 280,
                    child:  Card(
                        semanticContainer: true,
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        elevation: 4,
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),

                          ),
                          // margin: EdgeInsets.all(30),
                          child: Image.asset(
                            imgListcafelongue[i],
                            fit: BoxFit.fill,
                          ),
                        )
                    ),
                  );




                },
              );
            }).toList(),
          ),
          Container(margin: EdgeInsets.only(left: 20),
              child: Text('Banquet and Party Hall',style: TextStyle(fontSize: 22,),)),
          CarouselSlider(
            options: CarouselOptions(
                height: 180.0,
                reverse: false,
                enableInfiniteScroll: false,
                enlargeCenterPage: true,
                aspectRatio: 16/ 9,
                autoPlay: false,
                viewportFraction: 0.7,
                onPageChanged: (index, reason) {
                  // setState(() {
                  //   incrementIndex();
                  // });
                }),
            items: [0, 1, 2,3].map((i) {
              return Builder(
                builder: (BuildContext context) {
                  return
                    Container(
                      width: 300,
                      margin: EdgeInsets.only(left: 20),
                      child:  Card(
                          semanticContainer: true,
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          elevation: 8,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),

                            ),
                            // margin: EdgeInsets.all(30),
                            child: Image.asset(
                              banquetimgList[i],
                              fit: BoxFit.fill,
                            ),
                          )
                      ),
                    );




                },
              );
            }).toList(),
          ),
          Container(margin: EdgeInsets.only(left: 20),
              child: Text('Confrence Hall',style: TextStyle(fontSize: 22,),)),
          CarouselSlider(
            options: CarouselOptions(
                height: 180.0,
                reverse: false,
                enableInfiniteScroll: false,
                enlargeCenterPage: true,
                aspectRatio: 16/ 9,
                autoPlay: false,
                viewportFraction: 0.7,
                onPageChanged: (index, reason) {
                  // setState(() {
                  //   incrementIndex();
                  // });
                }),
            items: [0, 1, 2,3,4].map((i) {
              return Builder(
                builder: (BuildContext context) {
                  return
                    Container(
                      width: 300,
                      child:  Card(
                          semanticContainer: true,
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          elevation: 8,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),

                            ),
                            // margin: EdgeInsets.all(30),
                            child: Image.asset(
                              confrenceroomList[i],
                              fit: BoxFit.fill,
                            ),
                          )
                      ),
                    );




                },
              );
            }).toList(),
          ),
          Container(margin: EdgeInsets.only(left: 20),
              child: Text('Bar and Restaurant',style: TextStyle(fontSize: 22,),)),
          CarouselSlider(
            options: CarouselOptions(
                height: 180.0,
                reverse: false,
                enableInfiniteScroll: false,
                enlargeCenterPage: true,
                aspectRatio: 16/ 9,
                autoPlay: false,
                viewportFraction: 0.7,
                onPageChanged: (index, reason) {
                  // setState(() {
                  //   incrementIndex();
                  // });
                }),
            items: [0, 1, 2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22].map((i) {
              return Builder(
                builder: (BuildContext context) {
                  return
                    Container(
                      width: 300,
                      child:  Card(
                          semanticContainer: true,
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          elevation: 8,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),

                            ),
                            // margin: EdgeInsets.all(30),
                            child: Image.asset(
                              restaurentandbarimgList[i],
                              fit: BoxFit.fill,
                            ),
                          )
                      ),
                    );




                },
              );
            }).toList(),
          ),
          Container(
            margin: EdgeInsets.only(left: 20),
              child: Text('Gymnasium',style: TextStyle(fontSize: 22,),)),
          CarouselSlider(
            options: CarouselOptions(
                height: 180.0,

                enlargeCenterPage: true,
                aspectRatio: 16/ 9,
                autoPlay: false,
                reverse: false,
                enableInfiniteScroll: false,
                viewportFraction: 0.7,
                onPageChanged: (index, reason) {
                  // setState(() {
                  //   incrementIndex();
                  // });
                }),
            items: [0, 1, 2,3,4,5,6,7,8,9,10,11].map((i) {
              return Builder(
                builder: (BuildContext context) {
                  return
                    Container(
                      width: 300,
                      child:  Card(
                          semanticContainer: true,
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          elevation: 8,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),

                            ),
                            // margin: EdgeInsets.all(30),
                            child: Image.asset(
                              gymimgList[i],
                              fit: BoxFit.fill,
                            ),
                          )
                      ),
                    );




                },
              );
            }).toList(),
          ),
          Container(margin: EdgeInsets.only(left: 20),
              child: Text('King Size Room',style: TextStyle(fontSize: 22,),)),
          CarouselSlider(
            options: CarouselOptions(
                height: 180.0, reverse: false,
                enableInfiniteScroll: false,
                enlargeCenterPage: true,
                aspectRatio: 16/ 9,
                autoPlay: false,
                viewportFraction: 0.7,
                onPageChanged: (index, reason) {
                  // setState(() {
                  //   incrementIndex();
                  // });
                }),
            items: [0, 1, 2,3,4,5,6].map((i) {
              return Builder(
                builder: (BuildContext context) {
                  return
                    Container(
                      width: 300,
                      child:  Card(
                          semanticContainer: true,
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          elevation: 8,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),

                            ),
                            // margin: EdgeInsets.all(30),
                            child: Image.asset(
                              kingsizeroomimgList[i],
                              fit: BoxFit.fill,
                            ),
                          )
                      ),
                    );




                },
              );
            }).toList(),
          ),

          Container(margin: EdgeInsets.only(left: 20),
              child: Text('Twin Bedded Room',style: TextStyle(fontSize: 22,),)),
          CarouselSlider(
            options: CarouselOptions(
                height: 180.0, reverse: false,
                enableInfiniteScroll: false,
                enlargeCenterPage: true,
                aspectRatio: 16/ 9,
                autoPlay: false,
                viewportFraction: 0.7,
                onPageChanged: (index, reason) {
                  // setState(() {
                  //   incrementIndex();
                  // });
                }),
            items: [0, 1, 2,3,4,5,6,7,8,9,10,11,].map((i) {
              return Builder(
                builder: (BuildContext context) {
                  return
                    Container(
                      width: 300,
                      child:  Card(
                          semanticContainer: true,
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          elevation: 8,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),

                            ),
                            // margin: EdgeInsets.all(30),
                            child: Image.asset(
                              twinbedroomimgList[i],
                              fit: BoxFit.fill,
                            ),
                          )
                      ),
                    );




                },
              );
            }).toList(),
          ),
          Container(
            margin: EdgeInsets.only(left: 20),
              child: Text('Luxury Suite',style: TextStyle(fontSize: 22,),)),
          CarouselSlider(
            options: CarouselOptions(
                height: 180.0, reverse: false,
                enableInfiniteScroll: false,
                enlargeCenterPage: true,
                aspectRatio: 16/ 9,
                autoPlay: false,
                viewportFraction: 0.7,
                onPageChanged: (index, reason) {
                  // setState(() {
                  //   incrementIndex();
                  // });
                }),
            items: [0, 1, 2,3,4,5,6,7].map((i) {
              return Builder(
                builder: (BuildContext context) {
                  return
                    Container(
                      width: 300,
                      child:  Card(
                          semanticContainer: true,
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          elevation: 8,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),

                            ),
                            // margin: EdgeInsets.all(30),
                            child: Image.asset(
                              luxurysuiteroomList[i],
                              fit: BoxFit.fill,
                            ),
                          )
                      ),
                    );




                },
              );
            }).toList(),
          ),
          Container(margin: EdgeInsets.only(left: 20)
    ,child: Text('Swimming Pool',style: TextStyle(fontSize: 22,),)),
          CarouselSlider(
            options: CarouselOptions(
                height: 180.0, reverse: false,
                enableInfiniteScroll: false,
                enlargeCenterPage: true,
                aspectRatio: 16/ 9,
                autoPlay: false,
                viewportFraction: 0.7,
                onPageChanged: (index, reason) {
                  // setState(() {
                  //   incrementIndex();
                  // });
                }),
            items: [0, 1, 2,3,4,5].map((i) {
              return Builder(
                builder: (BuildContext context) {
                  return
                    Container(
                      width: 300,
                      child:  Card(
                          semanticContainer: true,
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          elevation: 8,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),

                            ),
                            // margin: EdgeInsets.all(30),
                            child: Image.asset(
                              swimmingpoolimgList[i],
                              fit: BoxFit.fill,
                            ),
                          )
                      ),
                    );




                },
              );
            }).toList(),
          ),


        ],
      ),
    );
  }
}
