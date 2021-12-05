import 'package:flutter/material.dart';
import 'package:libman/Components/background.dart';
import 'package:libman/Components/model/book.dart';
import 'package:libman/constants.dart';
import 'package:libman/services/bookservice.dart';

class AddBook extends StatefulWidget {
  const AddBook({Key? key}) : super(key: key);

  @override
  State<AddBook> createState() => _AddBookState();
}

int? _selectedvalue = 0;

class _AddBookState extends State<AddBook> {
  @override
  Widget build(BuildContext context) {
    final _formkey = GlobalKey<FormState>();
    TextEditingController id = TextEditingController();
    TextEditingController bookName = TextEditingController();
    TextEditingController author = TextEditingController();
    TextEditingController publisher = TextEditingController();
    TextEditingController price = TextEditingController();
    TextEditingController shelfno = TextEditingController();

    return Scaffold(
      body: Background(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 20),
            child: Form(
              key: _formkey,
              child: Column(
                children: [
                  Text(
                    "Add Book",
                    style: kscreentitle,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          controller: id,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Enter BookId";
                            }
                          },
                          decoration: const InputDecoration(
                            labelText: "BookId",
                            hintText: "BookId",
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: TextFormField(
                          controller: shelfno,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Enter Shelfno";
                            }
                          },
                          decoration: const InputDecoration(
                            labelText: "Shelfno",
                            hintText: "Shelfno",
                          ),
                        ),
                      ),
                    ],
                  ),
                  TextFormField(
                    controller: bookName,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Enter Book Name";
                      }
                    },
                    decoration: const InputDecoration(
                      labelText: "Book Name",
                      hintText: "Book Name",
                    ),
                  ),
                  TextFormField(
                    controller: author,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Enter Author Name";
                      }
                    },
                    decoration: const InputDecoration(
                      labelText: "Author Name",
                      hintText: "Author Name",
                    ),
                  ),
                  TextFormField(
                    controller: publisher,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Enter Publisher Name";
                      }
                    },
                    decoration: const InputDecoration(
                      labelText: "Publisher Name",
                      hintText: "Publisher Name",
                    ),
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    controller: price,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Enter Price";
                      }
                    },
                    decoration: const InputDecoration(
                      labelText: "Price",
                      hintText: "Price",
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Book Category",
                        style: kcardtext,
                      ),
                      DropdownButton(
                          value: _selectedvalue,
                          onChanged: (int? value) {
                            setState(() {
                              _selectedvalue = value;
                            });
                          },
                          items: List.generate(bookCateg.length, (index) {
                            return DropdownMenuItem(
                              child: Text(bookCateg[index]),
                              value: index,
                            );
                          })), //[DropdownMenuItem(child: Text("data"))]),
                    ],
                  ),
                  Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: kprimarycolor,
                          borderRadius: BorderRadius.circular(8)),
                      child: TextButton(
                          onPressed: () async {
                            if (_formkey.currentState!.validate()) {
                              await BookService()
                                  .addBook(
                                Book(
                                  bookId: id.text,
                                  bookname: bookName.text,
                                  bookauthor: author.text,
                                  bookcategory: bookCateg[_selectedvalue!],
                                  price: double.parse(price.text),
                                  shelfno: shelfno.text,
                                ),
                              )
                                  .then((value) {
                                id.clear();
                                bookName.clear();
                                author.clear();
                                price.clear();
                                shelfno.clear();
                                Navigator.of(context).pop();
                              });
                            }
                          },
                          child: Text(
                            "Add Book",
                            style: TextStyle(color: Colors.white),
                          )))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
