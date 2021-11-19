import 'package:flutter/material.dart';
import 'package:libman/widgets/reusable_card.dart';
import 'package:libman/constants.dart';

const activeCardColor = Colors.white;

class Membership extends StatelessWidget {
  const Membership({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 40, left: 10, right: 10),
          child: Text(
            "Membership",
            style: TextStyle(
                fontSize: size.width * .07,
                fontFamily: "RedHat",
                color: Colors.black.withOpacity(.5)),
          ),
        ),
        Expanded(
          child: Row(
            children: [
              //SizedBox(height: 150),
              Expanded(
                child: ReusableCard(
                  onTap: () {
                    print("hi");
                  },
                  colour: activeCardColor,
                  width: size.width * .1,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.group_add_rounded,
                        size: 75,
                        color: kprimarycolor,
                      ),
                      Text("New Member")
                    ],
                  ),
                ),
              ),
              Expanded(
                child: ReusableCard(
                  onTap: () {
                    print("hi");
                  },
                  colour: activeCardColor,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.search_off_rounded,
                        size: 75,
                        color: kprimarycolor,
                      ),
                      const Text("Search Member")
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(bottom: 20),
            child: ReusableCard(
              onTap: () {
                print("hi");
              },
              colour: activeCardColor,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.bloodtype_rounded,
                    size: 75,
                    color: kprimarycolor,
                  ),
                  Text("Blood donation")
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
