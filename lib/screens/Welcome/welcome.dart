import 'package:flutter/material.dart';
import 'package:libman/Components/background.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Background(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            "assets/images/splash_logo.png",
            height: size.height * .25,
          ),
          const Text(
            "Libman",
            style: TextStyle(
                fontFamily: "Rochester",
                fontSize: 50,
                fontWeight: FontWeight.w400),
          ),
          TextButton(
              onPressed: () {
                print("log in");
              },
              child: Text("Log in"))
        ],
      )),
    );
  }
}
