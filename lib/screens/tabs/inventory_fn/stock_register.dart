import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:libman/Components/background.dart';
import 'package:libman/constants.dart';
import 'package:libman/screens/tabs/inventory_fn/addbook.dart';

class StockRegister extends StatelessWidget {
  const StockRegister({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bookInfo = FirebaseFirestore.instance.collection("books");
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
                  child: Center(child: Text("Total Books:1000")),
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
                      return Container(
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
                              return ListTile(
                                title:
                                    Text(snapshot.data.docs[index]["bookname"]),
                              );
                            },
                            separatorBuilder: (context, index) => SizedBox(
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
        child: Icon(Icons.add),
      ),
    );
  }
}
