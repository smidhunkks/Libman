import 'package:flutter/material.dart';
import 'package:libman/constants.dart';

class AuthButton extends StatelessWidget {
  final Size size;
  final String label;
  final VoidCallback onPress;
  const AuthButton({
    Key? key,
    required this.size,
    required this.label,
    required this.onPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            gradient: const LinearGradient(
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
              onPressed: onPress,
              child: Text(
                label.isNotEmpty ? label : "Button",
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontFamily: "RedHat",
                    fontWeight: FontWeight.w700),
              )),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Don't have an account?",
              style: TextStyle(fontFamily: "RedHat"),
            ),
            TextButton(
              onPressed: () {
                print("signup");
              },
              child: const Text(
                "Sign Up",
                style: TextStyle(
                  fontFamily: "RedHat",
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                ),
              ),
            )
          ],
        )
      ],
    );
  }
}
