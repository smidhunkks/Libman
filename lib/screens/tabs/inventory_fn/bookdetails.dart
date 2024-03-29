import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:libman/Components/background.dart';
import 'package:libman/constants.dart';
import 'package:libman/screens/tabs/inventory_fn/editbook.dart';
import 'package:libman/screens/tabs/inventory_fn/issuehistory.dart';

class Booketails extends StatefulWidget {
  const Booketails(
      {Key? key,
      this.Id,
      this.bookName,
      this.bookauthor,
      this.price,
      this.shelfno,
      this.category,
      this.publisher})
      : super(key: key);

  final String? Id;
  final String? bookName;
  final String? bookauthor;
  final double? price;
  final String? shelfno;
  final String? category;
  final String? publisher;

  @override
  State<Booketails> createState() => _BooketailsState();
}

class _BooketailsState extends State<Booketails> {
  Map<String, dynamic> status = {"status": false};
  @override
  void initState() {
    Future.delayed(Duration.zero, () async {
      status = await statusCheck(widget.Id);
      setState(() {
        status = status;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool isIssued = false;
    return Scaffold(
      body: Background(
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Book details",
                    style: kscreentitle.copyWith(color: Colors.grey),
                  ),
                  IconButton(
                    onPressed: () async {
                      final issuehistory = await FirebaseFirestore.instance
                          .collection('issue-history')
                          .where('bookId', isEqualTo: widget.Id)
                          .get();
                      if (issuehistory.docs.isNotEmpty) {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (ctx) => IssueHistory(
                              Id: widget.Id,
                              activeIssue: status,
                              issuehistory: issuehistory.docs.toList(),
                              bookName: widget.bookName,
                            ),
                          ),
                        );
                      } else {
                        final snackbar = SnackBar(
                          backgroundColor: Colors.redAccent,
                          content: const Text(
                            "No issue history found",
                            style: TextStyle(color: Colors.white),
                          ),
                          action: SnackBarAction(
                            textColor: Colors.white,
                            label: 'dismiss',
                            onPressed: () {},
                          ),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackbar);
                      }
                    },
                    icon: const Icon(
                      Icons.history,
                      size: 30,
                    ),
                    tooltip: "Issue History",
                  )
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                "Book Id : ${widget.Id} ",
                style: kcardtext.copyWith(fontSize: 20),
              ),
              Text(
                "Book Name : ${widget.bookName} ",
                style: kcardtext.copyWith(
                    fontSize: 23, fontWeight: FontWeight.w500),
              ),
              //status ?? status!,
              const SizedBox(
                height: 10,
              ),
              const Divider(
                color: Colors.black87,
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                "Author Name : ${widget.bookauthor}",
                style: kcardtext.copyWith(fontSize: 18),
              ),
              Text(
                "Price : ${widget.price} ",
                style: kcardtext.copyWith(fontSize: 18),
              ),
              Text(
                "Shelf No : ${widget.shelfno} ",
                style: kcardtext.copyWith(fontSize: 18),
              ),
              Text(
                "Category : ${widget.category} ",
                style: kcardtext.copyWith(fontSize: 18),
              ),
              Row(
                children: [
                  Text(
                    "Status : ",
                    style: kcardtext.copyWith(fontSize: 20),
                  ),
                  status["status"]
                      ? Text(
                          "Stock In",
                          style: kcardtext.copyWith(
                              color: Colors.green,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        )
                      : Text(
                          "Issued to ${status['memberName']}(${status['memId']})",
                          style: kcardtext.copyWith(
                            color: Colors.redAccent,
                            fontSize: 20,
                          ),
                        ),
                ],
              ),
              const SizedBox(
                height: 40,
              ),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  //color: kprimarycolor,
                  border: Border.all(width: 2, color: kprimarycolor),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: TextButton(
                  onPressed: () async {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (ctx) => EditBook(
                          id: widget.Id,
                          author: widget.bookauthor,
                          bookName: widget.bookName,
                          category: widget.category,
                          price: widget.price,
                          shelfno: widget.shelfno,
                          publisher: widget.publisher,
                        ),
                      ),
                    );
                  },
                  child: Text(
                    "Edit",
                    style: kcardtext.copyWith(
                      color: Colors.black,
                      fontSize: 17,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: kprimarycolor,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: TextButton(
                  onPressed: () async {
                    if (status["status"]) {
                      return await showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text("Confirm Delete."),
                          content:
                              const Text("Are you sure you want to Delete?"),
                          actions: [
                            ElevatedButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text("Cancel")),
                            ElevatedButton(
                                onPressed: () async {
                                  await FirebaseFirestore.instance
                                      .collection("books")
                                      .doc(widget.Id)
                                      .delete()
                                      .then((value) =>
                                          Navigator.of(context).pop())
                                      .then((value) =>
                                          Navigator.of(context).pop());
                                },
                                child: const Text("Confirm")),
                          ],
                        ),
                      );
                    } else {
                      final snackbar = SnackBar(
                        content: const Text("Book Already in Issue"),
                        action: SnackBarAction(
                          label: 'dismiss',
                          onPressed: () {},
                        ),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackbar);
                    }
                  },
                  child: Text(
                    "Delete",
                    style: kcardtext.copyWith(
                      color: Colors.white,
                      fontSize: 17,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Future<Map<String, dynamic>> statusCheck(String? Id) async {
  final statuscheck = await FirebaseFirestore.instance
      .collection('issue')
      .where('bookId', isEqualTo: Id)
      .get();
  if (statuscheck.docs.isEmpty) {
    return {"status": true};
  } else {
    return {
      "status": false,
      "memberName": statuscheck.docs[0].data()['memberName'],
      "memId": statuscheck.docs[0].data()['memId']
    };
  }
}
