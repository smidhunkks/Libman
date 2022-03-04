import 'package:flutter/material.dart';
import 'package:libman/Components/authbutton.dart';
import 'package:libman/Components/background.dart';
import 'package:libman/constants.dart';
import 'package:libman/screens/auth/login.dart';
import 'package:url_launcher/url_launcher.dart';

class SupportScreen extends StatelessWidget {
  const SupportScreen({Key? key}) : super(key: key);

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
            Flex(
              direction: Axis.vertical,
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text(
                  "വാളകം പബ്ലിക് ലൈബ്രറി",
                  style: ktitleStyle,
                ),
                Text(
                  " & റീഡിംഗ് റൂം",
                  style: ktitleStyle,
                ),
              ],
            ),
            Container(
              width: double.infinity,
              margin: EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                  color: kprimarycolor, borderRadius: BorderRadius.circular(8)),
              child: TextButton(
                  onPressed: () {
                    launch('mailto:libman.contact@gmail.com');
                  },
                  child: Text(
                    "Support",
                    style: kcardtext.copyWith(color: Colors.white),
                  )),
            )
          ],
        ),
      ),
    );
  }
}
