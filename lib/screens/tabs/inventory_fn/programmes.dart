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
              const SizedBox(
                height: 20,
              ),
              Expanded(
                child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('programs')
                      .orderBy('Date')
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
                            "No Programmes found",
                            style: kcardtext,
                          ))
                        : ListView.builder(
                            //physics: BouncingScrollPhysics(),
                            itemCount: snapshot.data.docs.length,
                            itemBuilder: (context, index) {
                              return Container(
                                padding:
                                    const EdgeInsets.only(bottom: 10, left: 1),
                                //height: size.height * .1,
                                margin: const EdgeInsets.only(
                                    left: 8, top: 10, bottom: 5, right: 8),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(8),
                                    boxShadow: const [
                                      BoxShadow(
                                          color: Colors.black26,
                                          blurRadius: 30,
                                          spreadRadius: 2)
                                    ]),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        IconButton(
                                          onPressed: () {
                                            Navigator.of(context).push(
                                              MaterialPageRoute(
                                                builder: (ctx) => AddProgram(
                                                  id: snapshot
                                                      .data.docs[index].id,
                                                  programname:
                                                      snapshot.data.docs[index]
                                                          ['programname'],
                                                  programcategory:
                                                      snapshot.data.docs[index]
                                                          ['programcategory'],
                                                  participantcount:
                                                      snapshot.data.docs[index]
                                                          ['participantcount'],
                                                  date: snapshot
                                                      .data.docs[index]['Date']
                                                      .toDate(),
                                                ),
                                              ),
                                            );
                                          },
                                          icon: const Icon(Icons.edit),
                                        ),
                                        IconButton(
                                          onPressed: () async {
                                            return await showDialog(
                                              context: context,
                                              builder: (context) => AlertDialog(
                                                title: const Text(
                                                    "Confirm Delete."),
                                                content: const Text(
                                                    "Are you sure you want to Delete?"),
                                                actions: [
                                                  ElevatedButton(
                                                      onPressed: () {
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                      child:
                                                          const Text("Cancel")),
                                                  ElevatedButton(
                                                      onPressed: () async {
                                                        await FirebaseFirestore
                                                            .instance
                                                            .collection(
                                                                "programs")
                                                            .doc(snapshot.data
                                                                .docs[index].id)
                                                            .delete();
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                      child: const Text(
                                                          "Confirm")),
                                                ],
                                              ),
                                            );
                                          },
                                          icon: const Icon(Icons.delete),
                                        )
                                      ],
                                    ),
                                    ListTile(
                                      title: Text(
                                        "${snapshot.data.docs[index]['programname'].length > 16 ? snapshot.data.docs[index]['programname'].substring(0, 16) : snapshot.data.docs[index]['programname']}",
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
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
                                  ],
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
              builder: (_) => const AddProgram(),
            ),
          );
        },
        backgroundColor: kprimarycolor,
        child: const Icon(
          Icons.add,
        ),
      ),
    );
  }
}
