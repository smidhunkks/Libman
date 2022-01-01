import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:libman/Components/background.dart';
import 'package:libman/constants.dart';
import 'package:libman/screens/tabs/inventory_fn/stock_register.dart';
import 'package:libman/screens/tabs/inventory_fn/issuebook.dart';
import 'package:libman/screens/tabs/inventory_fn/returnbook.dart';

import 'package:libman/screens/tabs/membership.dart';
import 'package:libman/services/authservice.dart';
import 'package:libman/widgets/reusable_card.dart';
import 'package:provider/provider.dart';

class Inventory extends StatelessWidget {
  const Inventory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 40, left: 15, right: 10),
          child: Text(
            "Inventory",
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
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) {
                      return Issuebook();
                    }));
                  },
                  colour: activeCardColor,
                  width: size.width * .1,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(
                        Icons.logout_rounded,
                        size: 75,
                        color: kprimarycolor,
                      ),
                      Text(
                        "Issue Book",
                        style: kcardtext,
                      )
                    ],
                  ),
                ),
              ),
              Expanded(
                child: ReusableCard(
                  onTap: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) {
                      return ReturnBook();
                    }));
                  },
                  colour: activeCardColor,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(
                        Icons.login_rounded,
                        size: 75,
                        color: kprimarycolor,
                      ),
                      Text(
                        "Return/Renew",
                        style: kcardtext,
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: ReusableCard(
                  onTap: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) {
                      return StockRegister();
                    }));
                  },
                  colour: activeCardColor,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(
                        Icons.book_outlined,
                        size: 75,
                        color: kprimarycolor,
                      ),
                      Text(
                        "Stock Register",
                        style: kcardtext,
                      )
                    ],
                  ),
                ),
              ),
            ),
            StreamBuilder<Object>(
                stream: FirebaseFirestore.instance
                    .collection('users')
                    .doc(FirebaseAuth.instance.currentUser!.email)
                    .snapshots(),
                builder: (context, AsyncSnapshot snapshot) {
                  print("stream : ${snapshot.data}");

                  return Visibility(
                    visible: snapshot.hasData || snapshot.hasError
                        ? snapshot.data!['role'] == 'Admin'
                        : false, // snapshot.data.d['role'] == 'Admin',
                    child: Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: ReusableCard(
                          onTap: () {
                            Navigator.of(context)
                                .push(MaterialPageRoute(builder: (context) {
                              return Scaffold(
                                body: Text("data"),
                              );
                            }));
                          },
                          colour: activeCardColor,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(
                                Icons.inventory_rounded,
                                size: 75,
                                color: kprimarycolor,
                              ),
                              Text(
                                "Programmes",
                                style: kcardtext,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                }),
          ],
        ),
      ],
    );
  }
}
