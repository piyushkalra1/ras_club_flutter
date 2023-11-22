import 'package:flutter/material.dart';

import '../const/home_icon_stacks.dart';

class CafeandLoungue extends StatelessWidget {
  const CafeandLoungue({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,

        child: HomeIconStacks(thumbnail: 'assets/images/cafe_3.jpg',tittle: 'Cafe and Lounge',subtittle: "Cafes are where Voltaire, Sartre and Simone de Beauvior brewed ideas. Van Goghs and Renoirs found colours to their canvases and the human society discovered best 'social lubricant'. We welcome you to further the tradition alongside delectable cuisines and 'honest to the bean' Coffee. Served round the clock-because we know-you would like to come here anytime! ",),
      ),
    );
  }
}


