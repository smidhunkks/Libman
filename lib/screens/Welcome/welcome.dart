import 'package:flutter/material.dart';
import 'package:libman/Components/authbutton.dart';
import 'package:libman/Components/background.dart';
import 'package:libman/constants.dart';
import 'package:libman/screens/auth/login.dart';
import 'package:libman/screens/auth/signup.dart';

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
                Text(
                  "Reg No : 593",
                  style: ktitleStyle,
                ),
              ],
            ),
            Visibility(
              visible: true,
              child: AuthButton(
                onbottomlabelpress: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => SignUp(),
                    ),
                  );
                },
                bottombuttonlabel: "Sign Up",
                bottomtext: "Don't have an account?",
                size: size,
                label: "Log In",
                onPress: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => Login(),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
