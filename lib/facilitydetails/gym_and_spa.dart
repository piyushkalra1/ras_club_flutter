import 'package:flutter/material.dart';

import '../const/home_icon_stacks.dart';

class GymandSpa extends StatelessWidget {
  const GymandSpa({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,

        child: HomeIconStacks(thumbnail: 'assets/images/gym_7.jpg',tittle: 'Gym and Spa',
          subtittle: "Wake up, breathe in, breathe out, flex your muscles, feel your being and live moments of life that surpass the limitations of routine and the mundane. At RAS Club you will be able to work out at the well-furnished air-conditioned gym and enjoy an extensive range of new equipment's. These equipment's in a green surrounding satiate those seeking rejuvenation through high energy workout.\n"
              "Relax, refresh and rejuvenate at RAS Club Spa where you can choose a body massage and Spa treatment. Our highly trained therapists will pamper you for your vigorous health. Our first goal is to understand your needs and then we aim to fulfil those needs and exceed your expectations. Let us take you on a journey, you choose the treatment which appeals the most to you and we will bespeak it, in the healing touch of expert hands.",),
      ),
    );
  }
}
