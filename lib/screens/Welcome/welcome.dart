import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:libman/Components/background.dart';
import 'package:libman/constants.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Background(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: size.height * .1,
          ),
          Image.asset(
            "assets/images/splash_logo.png",
            height: size.height * .21,
          ),
          const Text(
            "Libman",
            style: TextStyle(
                fontFamily: "Rochester",
                fontSize: 50,
                fontWeight: FontWeight.w400),
          ),
          Visibility(
            visible: true,
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.bottomLeft,
                        end: Alignment.topRight,
                        colors: [kprimarycolor, kprimarylightcolor]),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  margin: EdgeInsets.only(
                    left: size.width * .08,
                    right: size.width * .08,
                    top: size.height * .15,
                  ),
                  width: double.infinity,
                  height: size.height * .08,
                  child: TextButton(
                      onPressed: () {
                        print("Elevated button");
                      },
                      child: Text(
                        "Log In",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      )),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account?",
                      style: TextStyle(fontFamily: "RedHat"),
                    ),
                    TextButton(
                        onPressed: () {
                          print("signup");
                        },
                        child: Text(
                          "Sign Up",
                          style: TextStyle(
                              fontFamily: "RedHat",
                              fontWeight: FontWeight.w700,
                              color: Colors.black),
                        ))
                  ],
                )
              ],
            ),
          ),
        ],
      )),
    );
  }
}
