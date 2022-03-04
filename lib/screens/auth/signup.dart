import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:libman/Components/authbutton.dart';
import 'package:libman/Components/background.dart';
import 'package:libman/constants.dart';
import 'package:libman/screens/auth/login.dart';
import 'package:libman/screens/auth/wrapper.dart';

import 'package:libman/services/authservice.dart';

import 'package:provider/provider.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController conf_password = TextEditingController();

  @override
  void initState() {
    email = TextEditingController();
    password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final authservice = Provider.of<Authservice>(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Background(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: size.height * .1),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flex(
                direction: Axis.vertical,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "വാളകം പബ്ലിക് ലൈബ്രറി",
                    style: ktitleStyle.copyWith(fontSize: 20),
                  ),
                  Text(
                    " & റീഡിംഗ് റൂം",
                    style: ktitleStyle.copyWith(fontSize: 20),
                  ),
                ],
              ),
              // const Text(
              //   "Libman",
              //   style: ktitleStyle,
              // ),
              Container(
                padding: EdgeInsets.only(
                    left: size.width * .06,
                    right: size.width * .06,
                    top: size.height * .1),
                child: Column(
                  children: [
                    Align(
                      child: Text(
                        "Sign Up",
                        style: TextStyle(
                            fontSize: size.width * .07,
                            fontFamily: "RedHat",
                            color: Colors.black.withOpacity(.5)),
                      ),
                      alignment: Alignment.centerLeft,
                    ),
                    SizedBox(
                      height: size.height * .03,
                    ),
                    TextField(
                      controller: email,
                      decoration: const InputDecoration(
                          hintText: "Email",
                          prefixIcon: Icon(Icons.email_outlined)),
                    ),
                    SizedBox(
                      height: size.height * .01,
                    ),
                    TextField(
                      obscureText: true,
                      controller: password,
                      decoration: const InputDecoration(
                        hintText: "Password",
                        prefixIcon: Icon(Icons.password_outlined),
                      ),
                    ),
                    SizedBox(
                      height: size.height * .01,
                    ),
                    TextField(
                      obscureText: true,
                      controller: conf_password,
                      decoration: const InputDecoration(
                        hintText: "Confirm Password",
                        prefixIcon: Icon(Icons.password_outlined),
                      ),
                    ),
                  ],
                ),
              ),
              AuthButton(
                bottomtext: "Already have an account?",
                bottombuttonlabel: "Log In",
                size: size,
                label: "Sign Up",
                onbottomlabelpress: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => Login(),
                    ),
                  );
                },
                onPress: () async {
                  if (password.text == conf_password.text) {
                    try {
                      await authservice.SignUpWithEmailandPassword(
                          email.text, password.text);
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                            builder: (ctx) => Wrapper(),
                          ),
                          (Route<dynamic> route) => false);
                    } on FirebaseAuthException catch (err) {
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
                  } else {
                    final snackbar = SnackBar(
                      backgroundColor: Colors.redAccent,
                      content: Text(
                        "Password Mismatch",
                        style: TextStyle(color: Colors.white),
                      ),
                      action: SnackBarAction(
                        label: 'dismiss',
                        onPressed: () {},
                      ),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackbar);
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
