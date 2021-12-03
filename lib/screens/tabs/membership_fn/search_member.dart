import 'package:flutter/material.dart';
import 'package:libman/Components/background.dart';
import 'package:libman/constants.dart';

class MemberSearch extends StatelessWidget {
  const MemberSearch({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Background(
        child: SafeArea(
          child: Column(
            children: [
              const Text(
                "Search Member",
                style: kscreentitle,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
