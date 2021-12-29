import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:libman/Components/background.dart';
import 'package:libman/constants.dart';

class Issuedetails extends StatelessWidget {
  final String? docId;
  final String? memId;
  final String? bookId;
  final String? bookname;
  final String? issuedate;
  final String? duedate;
  final Widget? status;
  final String? memname;
  const Issuedetails(
      {Key? key,
      this.memId,
      this.bookId,
      this.bookname,
      this.issuedate,
      this.duedate,
      this.status,
      this.memname,
      this.docId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Background(
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Issue details",
                style: kscreentitle.copyWith(color: Colors.grey),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                "Book Id : $bookId ",
                style: kcardtext.copyWith(fontSize: 20),
              ),
              Text(
                "Book Name : $bookname ",
                style: kcardtext.copyWith(
                    fontSize: 23, fontWeight: FontWeight.w500),
              ),
              status ?? status!,
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
                "Member Id : $memId",
                style: kcardtext.copyWith(fontSize: 18),
              ),
              Text(
                "Member Name : $memname",
                style: kcardtext.copyWith(fontSize: 18),
              ),
              const SizedBox(
                height: 10,
              ),
              const Divider(
                color: Colors.black,
              ),
              Text(
                "Issue Date : $issuedate ",
                style: kcardtext.copyWith(fontSize: 18),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                "Due Date : $duedate ",
                style: kcardtext.copyWith(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Colors.redAccent),
              ),
              const SizedBox(
                height: 10,
              ),
              const SizedBox(
                height: 10,
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
// await FirebaseFirestore.instance
//                         .collection('issue')
//                         .doc(memId)
//                         .collection('active')
//                         .doc(bookId)
//                         .update(
//                       {
//                         'duedate': DateTime.now().add(
//                           const Duration(days: 14),
//                         ),
//                         'timestamp': DateTime.now()
//                       },

                    final renewfetch = await FirebaseFirestore.instance
                        .collection('issue')
                        .where("memId", isEqualTo: memId)
                        .where('bookId', isEqualTo: bookId)
                        .get();
                    if (renewfetch.docs.isNotEmpty) {
                      await FirebaseFirestore.instance
                          .collection('issue')
                          .doc(renewfetch.docs.toList()[0].id)
                          .update(
                        {
                          'duedate': DateTime.now().add(
                            const Duration(days: 14),
                          ),
                          'timestamp': DateTime.now()
                        },
                      ).then((value) {
                        final snackbar = SnackBar(
                          content: const Text(
                            "Renew Successful",
                            style: TextStyle(color: Colors.black),
                          ),
                          backgroundColor: Colors.greenAccent,
                          action: SnackBarAction(
                            label: 'dismiss',
                            textColor: Colors.black,
                            onPressed: () {},
                          ),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackbar);
                        Navigator.of(context).pop();
                      }).onError((error, stackTrace) {
                        final snackbar = SnackBar(
                          content: const Text("Error Occured while Renewing"),
                          action: SnackBarAction(
                            label: 'dismiss',
                            onPressed: () {},
                          ),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackbar);
                      });
                    }
                  },
                  child: Text(
                    "Renew",
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
                    print("Return");
                    final tempIssue = await FirebaseFirestore.instance
                        .collection('issue')
                        .doc(docId)
                        .get();

                    await FirebaseFirestore.instance
                        .collection('issue-history')
                        .add({
                      "bookId": tempIssue.data()!['bookId'],
                      "bookName": tempIssue.data()!['bookName'],
                      "memId": tempIssue.data()!['memId'],
                      "memberName": tempIssue.data()!['memberName'],
                      "issuedate": tempIssue.data()!['issuedate'],
                      "duedate": tempIssue.data()!['duedate'],
                      "returndate": DateTime.now()
                    }).then((value) {
                      FirebaseFirestore.instance
                          .collection('issue')
                          .doc(docId)
                          .delete()
                          .then((value) => Navigator.of(context).pop());
                    });
                  },
                  child: Text(
                    "Return",
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
