import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:libman/Components/background.dart';

import 'package:libman/constants.dart';
import 'package:intl/intl.dart';
import 'package:libman/screens/tabs/inventory_fn/issuedetails.dart';

class ReturnBook extends StatefulWidget {
  const ReturnBook({Key? key}) : super(key: key);

  @override
  _ReturnBookState createState() => _ReturnBookState();
}

class _ReturnBookState extends State<ReturnBook> {
  final DateFormat formatter = DateFormat('dd-MM-yyyy');

  TextEditingController _bookid = TextEditingController();
  TextEditingController _memid = TextEditingController(text: "VPL");
  TextEditingController _bookname = TextEditingController();
  TextEditingController _dateController = TextEditingController();

  List issueList = [0];
  late QuerySnapshot gissuesnap;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Background(
        child: Padding(
          padding: EdgeInsets.only(left: 16, right: 16, top: size.height * .13),
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
                            .where('memId',
                                isEqualTo: _memid.text.toUpperCase())
                            .get();
                        // await FirebaseFirestore.instance
                        // .collection('issue')
                        // .doc(_memid.text.toUpperCase())
                        // .collection('active')
                        // .get();

                        if (issuesnap.docs.isNotEmpty) {
                          setState(() {
                            issueList = issuesnap.docs.toList();
                          });
                        } else {
                          setState(() {
                            issueList = [0];
                          });
                          final snackbar = SnackBar(
                            content: const Text("No Active Issues Found"),
                            action: SnackBarAction(
                              label: 'dismiss',
                              onPressed: () {},
                            ),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackbar);
                        }
                      }
                    },
                    child: const Text("Validate"),
                  ),
                ),
              ),
              issueList[0] == 0
                  ? SizedBox(height: 1)
                  : Expanded(
                      child: StreamBuilder<Object>(
                          stream: FirebaseFirestore.instance
                              .collection('issue')
                              .where('memId',
                                  isEqualTo: _memid.text.toUpperCase())
                              .snapshots(),
                          builder: (context, AsyncSnapshot snapshot) {
                            if (snapshot.hasError) {
                              return const Text("Something went wrong");
                            }
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return CircularProgressIndicator();
                            }
                            return snapshot.data.docs.length == 0
                                ? const Center(
                                    child: Text(
                                    "No Active Issues found",
                                    // style: kcardlighttext,
                                  ))
                                : ListView.builder(
                                    itemCount: snapshot.data.docs.length,
                                    itemBuilder: (context, index) =>
                                        GestureDetector(
                                      onTap: () {
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (ctx) => Issuedetails(
                                              docId:
                                                  snapshot.data.docs[index].id,
                                              memId: snapshot.data.docs[index]
                                                  ['memId'],
                                              bookname: snapshot
                                                  .data.docs[index]["bookName"],
                                              bookId: snapshot.data.docs[index]
                                                  ["bookId"],
                                              issuedate: formatter
                                                  .format(snapshot.data
                                                      .docs[index]['issuedate']
                                                      .toDate())
                                                  .toString(),
                                              duedate: formatter
                                                  .format(snapshot.data
                                                      .docs[index]['duedate']
                                                      .toDate())
                                                  .toString(),
                                              status: DateTime.now()
                                                          .difference(snapshot
                                                              .data
                                                              .docs[index]
                                                                  ['duedate']
                                                              .toDate())
                                                          .inDays >
                                                      0
                                                  ? Text(
                                                      "Due by ${(DateTime.now().difference(snapshot.data.docs[index]['duedate'].toDate()).inDays)} days",
                                                      style: kcardtext.copyWith(
                                                        color: Colors.redAccent,
                                                        fontSize: 20,
                                                      ),
                                                    )
                                                  : Text(
                                                      "Active",
                                                      style: kcardtext.copyWith(
                                                        color: Colors.green,
                                                        fontSize: 20,
                                                      ),
                                                    ),
                                              memname: snapshot.data.docs[index]
                                                  ['memberName'],
                                            ),
                                          ),
                                        );
                                      },
                                      child: Container(
                                        margin: const EdgeInsets.symmetric(
                                            vertical: 10),
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20, vertical: 12),
                                        child: Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    DateTime.now()
                                                                .difference(snapshot
                                                                    .data
                                                                    .docs[index]
                                                                        [
                                                                        'duedate']
                                                                    .toDate())
                                                                .inDays >
                                                            0
                                                        ? Text(
                                                            "Due by ${(DateTime.now().difference(snapshot.data.docs[index]['duedate'].toDate()).inDays)} days",
                                                            style: kcardtext
                                                                .copyWith(
                                                                    color: Colors
                                                                        .redAccent),
                                                          )
                                                        : Text(
                                                            "Active",
                                                            style: kcardtext
                                                                .copyWith(
                                                                    color: Colors
                                                                        .green),
                                                          ),
                                                    Text(
                                                      "#${snapshot.data.docs[index]['bookId']}",
                                                      style: kcardtext.copyWith(
                                                          fontSize: 18),
                                                    ),
                                                    Text(
                                                      snapshot.data.docs[index]
                                                          ['bookName'],
                                                      style:
                                                          kscreentitle.copyWith(
                                                              fontSize: 20),
                                                      overflow:
                                                          TextOverflow.fade,
                                                    ),
                                                  ],
                                                ),
                                                Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      "Due",
                                                      style: kcardtext.copyWith(
                                                          fontSize: 18),
                                                    ),
                                                    Text(
                                                      formatter
                                                          .format(snapshot
                                                              .data
                                                              .docs[index]
                                                                  ['duedate']
                                                              .toDate())
                                                          .toString(),
                                                      style:
                                                          kscreentitle.copyWith(
                                                              fontSize: 15),
                                                    )
                                                  ],
                                                ),
                                              ],
                                            ),
                                            Align(
                                              alignment: Alignment.bottomCenter,
                                              child: Text(
                                                "Tap to view details",
                                                style: kcardtext.copyWith(
                                                    color: Colors.black87),
                                              ),
                                            ),
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
                                            borderRadius:
                                                BorderRadius.circular(8)),
                                      ),
                                    ),
                                  );
                          }),
                    )
            ],
          ),
        ),
      ),
    );
  }
}
