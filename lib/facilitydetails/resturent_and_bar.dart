import 'package:flutter/material.dart';

import '../const/home_icon_stacks.dart';

class RestaurentandBar extends StatelessWidget {
  const RestaurentandBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,

        child: HomeIconStacks(thumbnail: 'assets/images/restaurant_8.jpg',tittle: 'Restaurant and Bar',
          subtittle: "Italo-americano decor, indo-contiental cuisine and personally chaperoned service will invite you to create occasions to break the bread togetherness with your family and friends. Come here to entertain appetite, share liberated laughter and savour the moments you would commemorate.\n"
              "\n"
              "This glittering centre piece at the RAS Club-the cocktail and champagne bar is designed to soak in one and all. Its ambience will embrace friends, family and business colleagues, alike. A family celebration of relationships or a toast to triumphs in business- this madhushaala is the perfect venue to add a little spring to your toes with the finest range of cocktails, champagnes, amazing wines or traditional drinks ",),
      ),
    );
  }
}
