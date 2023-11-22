import 'package:flutter/material.dart';

import 'package:flutter/material.dart';

import 'constants.dart';

class CustomGrayContainer extends StatelessWidget {
  Widget child, icon;
  final width;
  CustomGrayContainer({Key? key, required this.child,required this.width, this.icon = const SizedBox()}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      margin: EdgeInsets.symmetric(vertical: 8,),
      decoration: BoxDecoration(
        // color: Colors.grey.shade200,
        border: Border.all(width: 1,color: Colors.black45),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        child: Center(
          child: Row(
            children: [
              SizedBox(width: 10,),
              Expanded(child: child),
              Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12)
                ),
                child: Center(child: icon,),
              ),
              SizedBox(width: 10,),            ],
          ),
        ),
      ),
    );
  }
}
