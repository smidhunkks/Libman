import 'package:flutter/material.dart';
import 'package:libman/Components/background.dart';
import 'package:libman/constants.dart';

class ConfirmReset extends StatelessWidget {
  const ConfirmReset({Key? key, this.email}) : super(key: key);
  final String? email;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Background(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Icon(
                  Icons.email,
                  size: 60,
                  color: kprimarycolor,
                ),
                Text(
                  "The link to reset your password has been sent to $email",
                  style: kcardtext.copyWith(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Follow the link for next steps",
                    style: kcardtext.copyWith(fontSize: 18),
                  ),
                ),
                SizedBox(
                  height: 50,
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
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text("Go To Home",
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontFamily: "RedHat",
                            fontWeight: FontWeight.w700)),
                  ),
                )
              ]),
        ),
      ),
    );
  }
}
