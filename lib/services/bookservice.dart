import 'package:cloud_firestore/cloud_firestore.dart' as store;
import 'package:libman/Components/model/book.dart';
import 'package:libman/Components/model/issued.dart';

class BookService {
  final _firestore = store.FirebaseFirestore.instance;

  Future<void> addBook(Book book) async {
    await _firestore.collection('books').doc(book.bookId.toString()).set({
      "bookId": book.bookId,
      "bookname": book.bookname,
      "bookauthor": book.bookauthor,
      "price": book.price,
      "bookcategory": book.bookcategory,
      "shelfno": book.shelfno,
      "timestamp": DateTime.now()
    }).then((value) => print("Book addition success"));
  }

  Future<void> issueBook(Issued issue) async {
    await _firestore
        .collection('issue')
        .doc(issue.memId)
        .collection('active')
        .doc()
        .set({
          "bookId": issue.bookId,
          "bookName": issue.bookName,
          "memId": issue.memId,
          "issuedate": issue.date,
          "timestamp": DateTime.now()
        })
        .then(
          (value) => print("Issue Success"),
        )
        .onError(
          (error, stackTrace) => print("error"),
        );
  }
}
