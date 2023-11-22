import 'package:flutter/material.dart';

class SpecilityIcon extends StatelessWidget {

  final tittle;
  final thumbnail;
  final colour;
  final ontap;
  SpecilityIcon({required this.ontap,required this.tittle, required this.thumbnail ,required this.colour});

  @override
  Widget build(BuildContext context) {
    return Column(
      children:  [
        InkWell(
          onTap: ontap,
          child: Container(
              height :70,
              decoration: BoxDecoration(
                  color: colour,
                  borderRadius: BorderRadius.circular(20)
              ),
              margin: EdgeInsets.symmetric(horizontal: 10),
              padding: EdgeInsets.all(8),

              child: thumbnail),
        ),
        Container(
            child: Text(tittle,textAlign: TextAlign.center,))
      ],
    );
  }
}
