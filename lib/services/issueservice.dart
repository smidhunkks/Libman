import 'package:cloud_firestore/cloud_firestore.dart' as store;
import 'package:libman/Components/model/issued.dart';

class IssueService {
  final _firestore = store.FirebaseFirestore.instance;

  Future<void> issueBook(Issued issue) async {
    //collection to be defined
    await _firestore.collection('issuedbook').doc("First").set({
      "memId": issue.memId,
      "name":issue.name,
      "bookId": issue.bookId,
      "bookName": issue.bookName,
      "issueDate": issue.issueDate,
      "returnDate": issue.returnDate,
      "timestamp": DateTime.now()
    }).then((value) => print("Issue Book success"));
  }
}
