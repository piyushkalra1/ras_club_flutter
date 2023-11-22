
import 'package:flutter/material.dart';


class AuthButton extends StatelessWidget {
  final String text;
  final Function() onTap;
  final bool isLoading;

  const AuthButton({Key? key, required this.onTap, required this.text, required this.isLoading})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(seconds: 4),
        child: isLoading? const CircularProgressIndicator()
            :Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.065,
          margin: const EdgeInsets.only(left: 20, right: 20),
          decoration: const BoxDecoration(
              color: Colors.blueAccent,
              borderRadius: BorderRadius.all(Radius.circular(10))),
          child: Center(
            child: Text(
              text,
            ),
          ),
        ),
      ),
    );
  }
}
