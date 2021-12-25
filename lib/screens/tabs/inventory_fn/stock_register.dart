import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:libman/Components/background.dart';
import 'package:libman/constants.dart';
import 'package:libman/screens/tabs/inventory_fn/addbook.dart';

class StockRegister extends StatelessWidget {
  const StockRegister({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int _bookcount = 0;
    final bookInfo =
        FirebaseFirestore.instance.collection("books").orderBy("bookId");

    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Background(
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  "Stock Register",
                  style: kscreentitle.copyWith(color: Colors.black45),
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  width: double.infinity,
                  margin:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 30),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: const [
                      BoxShadow(
                          color: Colors.black26,
                          blurRadius: 30,
                          spreadRadius: 2),
                    ],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(child: Text("Total Books:${_bookcount}")),
                ),
              ),
              Expanded(
                flex: 2,
                child: StreamBuilder(
                  stream: bookInfo.snapshots(),
                  builder: (context, AsyncSnapshot snapshot) {
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
                            // style: kcardlighttext,
                          ))
                        : ListView.separated(
                            itemBuilder: (context, index) {
                              return Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 8),
                                padding: const EdgeInsets.all(12),
                                width: double.infinity,
                                height: size.height * .2,
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
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        IconButton(
                                            onPressed: () {
                                              print("pressed edit");
                                            },
                                            icon: const Icon(Icons.edit)),
                                        IconButton(
                                            onPressed: () async {
                                              print("pressed edit");
                                              return await showDialog(
                                                context: context,
                                                builder: (context) =>
                                                    AlertDialog(
                                                  title:
                                                      Text("Confirm Delete."),
                                                  content: Text(
                                                      "Are you sure you want to Delete?"),
                                                  actions: [
                                                    ElevatedButton(
                                                        onPressed: () {
                                                          Navigator.of(context)
                                                              .pop();
                                                        },
                                                        child: Text("Cancel")),
                                                    ElevatedButton(
                                                        onPressed: () async {
                                                          FirebaseFirestore
                                                              .instance
                                                              .collection(
                                                                  "books")
                                                              .doc(snapshot
                                                                  .data
                                                                  .docs[index]
                                                                      ["bookId"]
                                                                  .toString())
                                                              .delete()
                                                              .then((value) =>
                                                                  Navigator.of(
                                                                          context)
                                                                      .pop());
                                                        },
                                                        child: Text("Confirm")),
                                                  ],
                                                ),
                                              );
                                            },
                                            icon: const Icon(Icons.delete)),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        CircleAvatar(
                                          radius: 35,
                                          backgroundColor: kprimarycolor,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                "#Id",
                                                style: kcardtext.copyWith(
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Text(
                                                "${snapshot.data.docs[index]['bookId']}",
                                                style: kcardtext.copyWith(
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 20,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              snapshot.data.docs[index]
                                                  ["bookname"],
                                              style: kscreentitle.copyWith(
                                                  fontSize: 20),
                                            ),
                                            Text(
                                              "Author : ${snapshot.data.docs[index]["bookauthor"]}",
                                              style: kscreentitle.copyWith(
                                                  fontSize: 15,
                                                  color: Colors.black54,
                                                  fontStyle: FontStyle.italic),
                                            ),
                                            Text(
                                              "Category : ${snapshot.data.docs[index]["bookauthor"]}",
                                              style: kscreentitle.copyWith(
                                                  fontSize: 15,
                                                  color: Colors.black54),
                                            ),
                                          ],
                                        ),
                                        Expanded(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              Text(
                                                "Shelf No",
                                                style: kscreentitle.copyWith(
                                                    fontSize: 15,
                                                    color: Colors.black54),
                                              ),
                                              Text(
                                                snapshot.data.docs[index]
                                                    ["shelfno"],
                                                style: kscreentitle.copyWith(
                                                    fontSize: 15,
                                                    color: Colors.black54),
                                              ),
                                              Text(
                                                "Rs ${snapshot.data.docs[index]["price"]}",
                                                style: kscreentitle.copyWith(
                                                    fontSize: 15,
                                                    color: Colors.black54),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              );
                              // ListTile(
                              //   leading: CircleAvatar(
                              //     radius: 30,
                              //     backgroundColor: kprimarycolor,
                              //     child:
                              //         Text(snapshot.data.docs[index]["bookId"]),
                              //   ),
                              //   title:
                              //       Text(snapshot.data.docs[index]["bookname"]),
                              // );
                            },
                            separatorBuilder: (context, index) =>
                                const SizedBox(
                                  height: 20,
                                ),
                            itemCount: snapshot.data.docs.length);
                  },
                ),
              )
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => AddBook(),
          ),
        ),
        backgroundColor: kprimarycolor,
        tooltip: "Add Book",
        child: const Icon(Icons.add),
      ),
    );
  }
}
