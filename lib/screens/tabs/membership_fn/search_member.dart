import 'package:flutter/material.dart';
import 'package:libman/Components/background.dart';
import 'package:libman/Components/model/membership.dart';
import 'package:libman/constants.dart';
import 'package:intl/intl.dart';
import 'package:libman/services/userservice.dart';
import 'package:libman/services/searchservice.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MemberSearch extends StatefulWidget {
  MemberSearch({Key? key}) : super(key: key);

  @override
  State<MemberSearch> createState() => _MemberSearchState();
}

class _MemberSearchState extends State<MemberSearch> {
  final _searchformKey = GlobalKey<FormState>();

  TextEditingController name = TextEditingController();
  Map<String, dynamic> userMap = {};
  void onSearch() async {
    FirebaseFirestore _firestore = FirebaseFirestore.instance;

    await _firestore
        .collection('member')
        .where("name", isEqualTo: name.text.toUpperCase())
        .get()
        .then((value) {
      setState(() {
        userMap = value.docs[0].data();
      });
      print(userMap);
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Background(
        child: SingleChildScrollView(
          child: Form(
            key: _searchformKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20.0,
              ),
              child: Column(
                children: [
                  const Text(
                    "Search Member",
                    style: kscreentitle,
                  ),
                  TextField(
                    controller: name,
                    decoration: const InputDecoration(
                      labelText: "Name",
                      hintText: "Name",
                    ),
                  ),
                  TextButton(
                    onPressed: onSearch,
                    child: Container(
                        padding:
                            EdgeInsets.symmetric(vertical: size.height * .02),
                        decoration: BoxDecoration(
                            color: kprimarylightcolor,
                            borderRadius: BorderRadius.circular(8)),
                        width: double.infinity,
                        child: const Center(
                            child: Text(
                          "Search Member",
                          style: TextStyle(color: Colors.white),
                        ))),
                  ),
                  userMap.isNotEmpty
                      ? ListTile(
                          onTap: () {},
                          leading: Icon(
                            Icons.account_box,
                          ),
                          title: Text(userMap['name']),
                          subtitle: Text(userMap['address']),
                        )
                      : Container(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
