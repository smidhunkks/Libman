import 'package:flutter/material.dart';

class Background extends StatelessWidget {
  final child;

  const Background({
    Key? key,
    @required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: double.infinity,
      height: double.infinity,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            bottom: 0,
            left: 0,
            child: Image.asset(
              "assets/images/corner-shape-bottom.png",
            ),
          ),
          Positioned(
            top: 0,
            right: 0,
            child: Image.asset(
              "assets/images/corner-shape.png",
            ),
          ),
          child,
        ],
      ),
    );
  }
}
