import 'package:flutter/material.dart';
import 'package:libman/Components/authbutton.dart';
import 'package:libman/Components/background.dart';
import 'package:libman/constants.dart';
import 'package:libman/screens/auth/login.dart';

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
                  "Valakam Public Library",
                  style: ktitleStyle,
                ),
                Text(
                  "& Reading Room",
                  style: ktitleStyle,
                ),
              ],
            ),
            Visibility(
              visible: true,
              child: AuthButton(
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

// class AuthButton extends StatelessWidget {
//   const AuthButton({
//     Key? key,
//     required this.size,
//   }) : super(key: key);

//   final Size size;

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Container(
//           decoration: BoxDecoration(
//             gradient: const LinearGradient(
//                 begin: Alignment.bottomLeft,
//                 end: Alignment.topRight,
//                 colors: [kprimarycolor, kprimarylightcolor]),
//             borderRadius: BorderRadius.circular(30),
//           ),
//           margin: EdgeInsets.only(
//             left: size.width * .08,
//             right: size.width * .08,
//             top: size.height * .15,
//           ),
//           width: double.infinity,
//           height: size.height * .08,
//           child: TextButton(
//               onPressed: () {
//                 Navigator.push(context,
//                     MaterialPageRoute(builder: (context) => Login()));
//                 print("Elevated button");
//               },
//               child: const Text(
//                 "Log In",
//                 style: TextStyle(color: Colors.white, fontSize: 20),
//               )),
//         ),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             const Text(
//               "Don't have an account?",
//               style: TextStyle(fontFamily: "RedHat"),
//             ),
//             TextButton(
//               onPressed: () {
//                 print("signup");
//               },
//               child: const Text(
//                 "Sign Up",
//                 style: TextStyle(
//                   fontFamily: "RedHat",
//                   fontWeight: FontWeight.w700,
//                   color: Colors.black,
//                 ),
//               ),
//             )
//           ],
//         )
//       ],
//     );
//   }
// }
