import 'package:flutter/material.dart';
import 'package:libman/widgets/reusable_card.dart';
import 'package:libman/constants.dart';

const activeCardColor = Colors.white;

class Membership extends StatelessWidget {
  const Membership({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Row(
              children: [
                SizedBox(height: 150),
                Expanded(
                  child: new ReusableCard(
                    colour: activeCardColor,
                  ),
                ),
                Expanded(
                  child: new ReusableCard(
                    colour: activeCardColor,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: new ReusableCard(
              colour: activeCardColor,
            ),
          ),
        ],
      ),
    );
  }
}
