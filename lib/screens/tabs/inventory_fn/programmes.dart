import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:libman/Components/background.dart';
import 'package:libman/constants.dart';
import 'package:libman/screens/tabs/inventory_fn/addprogram.dart';
import 'package:intl/intl.dart';

class Programs extends StatelessWidget {
  const Programs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final DateFormat formatter = DateFormat('dd-MM-yyyy');

    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Background(
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  "Programs",
                  style: kscreentitle.copyWith(color: Colors.black45),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Expanded(
                child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('programs')
                      .snapshots(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.hasError) {
                      return const Text("Something Went Wrong");
                    }
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Padding(
                        padding: EdgeInsets.all(40),
                        child: CircularProgressIndicator(),
                      );
                    }
                    return snapshot.data!.docs.length == 0
                        ? const Center(
                            child: Text(
                            "No Book found",
                            style: kcardtext,
                          ))
                        : ListView.builder(
                            itemCount: snapshot.data.docs.length,
                            itemBuilder: (context, index) {
                              return Container(
                                height: size.height * .1,
                                margin: EdgeInsets.only(
                                    left: 10, top: 10, bottom: 5, right: 10),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(8),
                                    boxShadow: const [
                                      BoxShadow(
                                          color: Colors.black26,
                                          blurRadius: 30,
                                          spreadRadius: 2)
                                    ]),
                                child: ListTile(
                                  title: Text(
                                    "${snapshot.data.docs[index]['programname']}",
                                    style: kcardtext.copyWith(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 23,
                                    ),
                                  ),
                                  subtitle: Text(
                                    "Category : ${snapshot.data.docs[index]['programcategory']}",
                                    style: kcardtext.copyWith(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 15,
                                    ),
                                  ),
                                  trailing: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Participant Count : ${snapshot.data.docs[index]['participantcount']}",
                                        style: kcardtext.copyWith(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14,
                                        ),
                                      ),
                                      Text(
                                        "Program Date : ${formatter.format(snapshot.data.docs[index]['Date'].toDate())}",
                                        style: kcardtext.copyWith(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            });
                  },
                ),
              )
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => AddProgram(),
            ),
          );
        },
        backgroundColor: kprimarycolor,
        child: Icon(
          Icons.add,
        ),
      ),
    );
  }
}
