class Book {
  final int bookId;
  final String bookName;
  final String bookauthor;
  final String bookcategory;
  final double price;
  final String shelfno;
  final String? publisher;

  Book({
    required this.bookId,
    required this.bookName,
    required this.bookauthor,
    required this.bookcategory,
    required this.price,
    required this.shelfno,
    this.publisher,
  });
}
