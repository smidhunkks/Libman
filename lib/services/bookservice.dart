import 'package:cloud_firestore/cloud_firestore.dart' as store;
import 'package:libman/Components/model/book.dart';
import 'package:libman/Components/model/issued.dart';

class BookService {
  final _firestore = store.FirebaseFirestore.instance;

  Future<bool> addBook(Book book) async {
    final addcheck = await _firestore
        .collection('books')
        .where('bookId', isEqualTo: book.bookId)
        .get();
    print(addcheck.docs);
    if (addcheck.docs.isEmpty) {
      await _firestore.collection('books').doc(book.bookId.toString()).set({
        "bookId": book.bookId,
        "bookname": book.bookName,
        "bookauthor": book.bookauthor,
        "price": book.price,
        "bookcategory": book.bookcategory,
        "shelfno": book.shelfno,
        "timestamp": DateTime.now()
      });
      return true;
    }

    return false;
  }

  Future<bool> issueBook(Issued issue) async {
    final issuecheck = await _firestore
        .collection('issue')
        .where('bookId', isEqualTo: issue.bookId)
        .get();
    if (issuecheck.docs.isEmpty) {
      await _firestore.collection('issue').doc().set({
        "bookId": issue.bookId,
        "bookName": issue.bookName,
        "memberName": issue.name,
        "memId": issue.memId,
        "issuedate": issue.date,
        "timestamp": DateTime.now(),
        "duedate": issue.duedate
      });
      return true;
    }
    return false;
  }
}
