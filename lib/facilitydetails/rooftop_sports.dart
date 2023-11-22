import 'package:flutter/material.dart';

import '../const/home_icon_stacks.dart';

class RooftopSports extends StatelessWidget {
  const RooftopSports({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,

        child: HomeIconStacks(thumbnail: 'assets/images/rooftopsports_2.jpg',tittle: 'Rooftop Sports',
          subtittle: "RAS Club extends unparalleled experience of playing 'infinity tennis' - we proudly call our rooftop tennis courts overlooking the Jhalana hills, first 'Infinity Tennis Courts' in Rajasthan! At the same time, you can also enjoy the bird's eye view of pink city while playing a game of tennis atop a 6-storey building.\n"
              "You can also enjoy playing badminton or sweat it out on our state of the art indoor Badminton and Squash courts and Table Tennis.\n"
              "You are welcome to flex your muscles and loosen up your nerves with any sport anytime. It can be as friendly or competitive as you wish, but the emphasis tends to be about having fun and playing as part of an active social life."
              ,),
      ),
    );
  }
}
