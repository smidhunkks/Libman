import 'package:cloud_firestore/cloud_firestore.dart' as store;
import 'package:libman/Components/model/book.dart';

class BookService {
  final _firestore = store.FirebaseFirestore.instance;

  Future<void> addBook(Book book) async {
    await _firestore.collection('books').doc(book.bookId).set({
      "bookId": book.bookId,
      "bookname": book.bookname,
      "bookauthor": book.bookauthor,
      "price": book.price,
      "bookcategory": book.bookcategory,
      "shelno": book.shelfno,
      "timestamp": DateTime.now()
    }).then((value) => print("Book addition success"));
  }
}
