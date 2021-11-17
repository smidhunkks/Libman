import 'package:flutter/material.dart';
import 'package:libman/constants.dart';

class ReusableCard extends StatelessWidget {
  const ReusableCard({this.colour=kprimarycolor});
  final Color colour;

  @override
  Widget build(BuildContext context) {
    return Container(


  margin: EdgeInsets.only(left: 30, top: 100, right: 30, bottom: 20),
  height: double.infinity,
  width: double.infinity,
  decoration: BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.only(
      topLeft: Radius.circular(10),
        topRight: Radius.circular(10),
        bottomLeft: Radius.circular(10),
        bottomRight: Radius.circular(10)
    ),
    boxShadow: [
      BoxShadow(
        color: Colors.grey.withOpacity(0.5),
        spreadRadius: 5,
        blurRadius: 7,
        offset: Offset(0, 3), // changes position of shadow
      ),
    ],
  ),
     
      // margin: EdgeInsets.all(25.0),
      
      // decoration: BoxDecoration(
        
      //   color: colour,
      //   borderRadius: BorderRadius.circular(10.0),
      // ),
    );
  }
}
