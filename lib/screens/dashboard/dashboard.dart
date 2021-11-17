import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:libman/Components/background.dart';
import 'package:libman/constants.dart';
import 'package:libman/screens/Welcome/welcome.dart';
import 'package:libman/screens/auth/authservice.dart';
import 'package:provider/provider.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authservice = Provider.of<Authservice>(context);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Background(
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Membership",
                style: TextStyle(
                    fontFamily: "RedHat",
                    fontSize: size.width * .07,
                    fontWeight: FontWeight.w200),
              ),
            )
          ],
        ),
      ),
    );
  }
}
