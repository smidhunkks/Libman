import 'package:flutter/material.dart';
import 'package:libman/constants.dart';

class ReusableCard extends StatelessWidget {
  const ReusableCard(
      {this.colour = kprimarycolor,
      this.width,
      this.height,
      required this.child,
      required this.onTap});
  final double? width;
  final double? height;
  final Color colour;
  final Widget child;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(
            horizontal: size.width * .04, vertical: size.height * .01),
        height: height ?? size.height * .25,
        width: width ?? double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 1,
              blurRadius: 20,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: child,
        // margin: EdgeInsets.all(25.0),

        // decoration: BoxDecoration(

        //   color: colour,
        //   borderRadius: BorderRadius.circular(10.0),
        // ),
      ),
    );
  }
}
