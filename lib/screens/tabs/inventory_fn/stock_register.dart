import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:libman/Components/background.dart';
import 'package:libman/Components/model/issued.dart';
import 'package:libman/constants.dart';
import 'package:libman/screens/tabs/inventory_fn/addbook.dart';
import 'package:libman/screens/tabs/inventory_fn/bookdetails.dart';

class StockRegister extends StatefulWidget {
  const StockRegister({Key? key}) : super(key: key);

  @override
  State<StockRegister> createState() => _StockRegisterState();
}

class _StockRegisterState extends State<StockRegister> {
  int _bookcount = 0;
  bool togglevalue = false;
  dynamic issueList = [];
  @override
  void initState() {
    Future.delayed(Duration.zero, () async {
      final issueListTemp =
          await FirebaseFirestore.instance.collection('issue').get();

      setState(() {
        issueList = issueListTemp.docs.toList();
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
              const SizedBox(
                height: 40,
              ),
              Row(
                children: [
                  const SizedBox(
                    width: 10,
                  ),
                  !togglevalue
                      ? Text("Stock in",
                          style: kcardtext.copyWith(fontSize: 20))
                      : Text("Stock out",
                          style: kcardtext.copyWith(fontSize: 20)),
                  Switch(
                      value: togglevalue,
                      onChanged: (value) {
                        setState(() {
                          togglevalue = value;
                        });
                      }),
                ],
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
                        : stockOut(snapshot, togglevalue);
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
            builder: (context) => const AddBook(),
          ),
        ),
        backgroundColor: kprimarycolor,
        tooltip: "Add Book",
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget stockOut(AsyncSnapshot<dynamic> snapshot, bool mode) {
    List filteredList = [];
    if (mode) {
      for (var snapitem in snapshot.data.docs) {
        for (var item in issueList) {
          if (snapitem['bookId'].toString() == item['bookId']) {
            filteredList.add(snapitem);
          }
        }
      }
      return stockList(filteredList);
    } else {
      if (issueList.length != 0) {
        for (var snapitem in snapshot.data.docs) {
          bool flag = false;

          for (var item in issueList) {
            if (snapitem['bookId'].toString() == item['bookId']) {
              flag = true;
              break;
            }
          }
          if (flag == false) {
            filteredList.add(snapitem);
          }
        }
      }
    }
    print(filteredList);
    return stockList(filteredList);
  }

  Widget stockList(List snapshot) {
    return snapshot.length != 0
        ? ListView.separated(
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (ctx) => Booketails(
                        Id: snapshot[index].id,
                        bookName: snapshot[index]['bookName'],
                        bookauthor: snapshot[index]['bookauthor'],
                        price: snapshot[index]['price'],
                        shelfno: snapshot[index]['shelfno'],
                        category: snapshot[index]["bookcategory"],
                      ),
                    ),
                  );
                },
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 8),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 16),
                  width: double.infinity,
                  //height: size.height * .18,
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
                    //mainAxisSize: MainAxisSize.max,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 35,
                            backgroundColor: kprimarycolor,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "#Id",
                                  style: kcardtext.copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  "${snapshot[index]['bookId']}",
                                  style: kcardtext.copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                snapshot[index]["bookName"],
                                style: kscreentitle.copyWith(fontSize: 20),
                              ),
                              Text(
                                "Author : ${snapshot[index]["bookauthor"]}",
                                style: kscreentitle.copyWith(
                                    fontSize: 15,
                                    color: Colors.black54,
                                    fontStyle: FontStyle.italic),
                              ),
                              Text(
                                "Category : ${snapshot[index]["bookcategory"]}",
                                style: kscreentitle.copyWith(
                                    fontSize: 15, color: Colors.black54),
                              ),
                            ],
                          ),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  "Shelf No",
                                  style: kscreentitle.copyWith(
                                      fontSize: 15, color: Colors.black54),
                                ),
                                Text(
                                  snapshot[index]["shelfno"],
                                  style: kscreentitle.copyWith(
                                      fontSize: 15, color: Colors.redAccent),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                      Text(
                        "Tap to view",
                        style: kcardtext.copyWith(
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
            separatorBuilder: (context, index) => const SizedBox(
                  height: 20,
                ),
            itemCount: snapshot.length)
        : Center(
            child: Text("No Stock out found"),
          );
  }
}
