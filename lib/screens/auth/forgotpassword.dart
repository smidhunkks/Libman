import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:libman/Components/authbutton.dart';
import 'package:libman/Components/background.dart';
import 'package:libman/constants.dart';
import 'package:libman/screens/auth/passwordresetconfirm.dart';

TextEditingController email = TextEditingController();

class ForgotPassWord extends StatelessWidget {
  const ForgotPassWord({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Background(
          child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Forgot Password",
              style: ktitleStyle,
            ),
            TextField(
              controller: email,
              decoration: const InputDecoration(
                hintText: "Email",
                prefixIcon: Icon(Icons.email_outlined),
              ),
            ),
            SizedBox(
              height: size.height * .03,
            ),
            Container(
              width: double.infinity,
              height: size.height * .08,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                    begin: Alignment.bottomLeft,
                    end: Alignment.topRight,
                    colors: [kprimarycolor, kprimarylightcolor]),
                borderRadius: BorderRadius.circular(30),
              ),
              child: TextButton(
                onPressed: () async {
                  if (email.text.isNotEmpty) {
                    try {
                      await FirebaseAuth.instance
                          .sendPasswordResetEmail(email: email.text);
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (ctx) => ConfirmReset(
                                email: email.text,
                              )));
                    } on FirebaseAuthException catch (err) {
                      // print("forgot pasword:${err.code}");
                      final snackbar = SnackBar(
                        backgroundColor: Colors.redAccent,
                        content: Text(
                          " ${err.code}",
                          style: TextStyle(color: Colors.white),
                        ),
                        action: SnackBarAction(
                          label: 'dismiss',
                          onPressed: () {},
                        ),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackbar);
                    }
                  }
                },
                child: Text("Send Reset Mail",
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontFamily: "RedHat",
                        fontWeight: FontWeight.w700)),
              ),
            )
          ],
        ),
      )),
    );
  }
}
