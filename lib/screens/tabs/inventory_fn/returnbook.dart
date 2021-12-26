import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:libman/Components/background.dart';
import 'package:libman/Components/model/issued.dart';
import 'package:libman/Components/model/membership.dart';
import 'package:libman/constants.dart';
import 'package:intl/intl.dart';
import 'package:libman/services/userservice.dart';

class ReturnBook extends StatefulWidget {
  ReturnBook({Key? key}) : super(key: key);

  @override
  _ReturnBookState createState() => _ReturnBookState();
}

class _ReturnBookState extends State<ReturnBook> {
  final _returnformKey = GlobalKey<FormState>();
  final DateFormat formatter = DateFormat('dd-MM-yyyy');

  TextEditingController _bookid = TextEditingController();
  TextEditingController _memid = TextEditingController();
  TextEditingController _bookname = TextEditingController();
  TextEditingController _dateController = TextEditingController();

  List issueList = [0];

  void fetchIssues(String memId) {}
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Background(
        child: Padding(
          padding: EdgeInsets.only(left: 16, right: 16, top: size.height * .19),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Return/Renew",
                style: kscreentitle,
              ),
              TextFormField(
                controller: _memid,
                decoration: InputDecoration(
                  labelText: "Member Id",
                  suffixIcon: TextButton(
                    onPressed: () async {
                      print(_memid.text.toUpperCase());
                      if (_memid.text.isNotEmpty) {
                        final issuesnap = await FirebaseFirestore.instance
                            .collection('issue')
                            .doc(_memid.text.toUpperCase())
                            .collection('active')
                            .get();
                        setState(() {
                          issueList = issuesnap.docs.toList();
                        });
                      }
                    },
                    child: const Text("Validate"),
                  ),
                ),
              ),
              issueList[0] == 0
                  ? SizedBox(height: 1)
                  : Expanded(
                      child: ListView.builder(
                        itemCount: issueList.length,
                        itemBuilder: (context, index) => Container(
                          margin: EdgeInsets.symmetric(vertical: 10),
                          padding: EdgeInsets.all(12),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  DateTime.now()
                                              .difference(issueList[index]
                                                      ['timestamp']
                                                  .toDate())
                                              .inDays >
                                          14
                                      ? Text(
                                          "Due by ${(15 - DateTime.now().difference(issueList[index]['timestamp'].toDate()).inDays).abs()} days",
                                          style: kcardtext.copyWith(
                                              color: Colors.redAccent),
                                        )
                                      : Text(
                                          "Active",
                                          style: kcardtext.copyWith(
                                              color: Colors.green),
                                        ),
                                  Text(
                                    "#${issueList[index]['bookId']}",
                                    style: kcardtext.copyWith(fontSize: 18),
                                  ),
                                  Text(
                                    issueList[index]['bookName'],
                                    style: kscreentitle.copyWith(fontSize: 20),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Issued",
                                    style: kcardtext.copyWith(fontSize: 18),
                                  ),
                                  Text(
                                    formatter
                                        .format(issueList[index]['issuedate']
                                            .toDate())
                                        .toString(),
                                    style: kscreentitle.copyWith(fontSize: 15),
                                  )
                                ],
                              )
                            ],
                          ),
                          height: size.height * .15,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.white54,
                                  blurRadius: 20,
                                  offset: Offset(1, -1),
                                ),
                                BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 20,
                                  offset: Offset(-1, 1),
                                )
                              ],
                              borderRadius: BorderRadius.circular(8)),
                        ),
                      ),
                    )
            ],
          ),
        ),
      ),
    );
  }
}
