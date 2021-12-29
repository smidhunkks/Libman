import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:libman/Components/background.dart';
import 'package:libman/Components/model/issued.dart';
import 'package:libman/Components/model/membership.dart';
import 'package:libman/constants.dart';
import 'package:intl/intl.dart';
import 'package:libman/screens/tabs/inventory_fn/addbook.dart';
import 'package:libman/services/bookservice.dart';
import 'package:libman/services/userservice.dart';

class Issuebook extends StatefulWidget {
  Issuebook({Key? key}) : super(key: key);

  @override
  _IssuebookState createState() => _IssuebookState();
}

class _IssuebookState extends State<Issuebook> {
  final String _setDate = "Choose a date";
  final _issueformKey = GlobalKey<FormState>();

  final DateFormat formatter = DateFormat('dd-MM-yyyy');
  int _counter = 0;

  DateTime _selectedDate = DateTime.now();
  DateTime fromDate =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
  DateTime toDate =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day)
          .add(const Duration(days: 15));
  //DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);

  final TextEditingController _dateController = TextEditingController();
  TextEditingController mem_id = TextEditingController();
  TextEditingController name = TextEditingController();
  final TextEditingController _bookid = TextEditingController();
  final TextEditingController _bookname = TextEditingController();
  final TextEditingController _duedateController = TextEditingController();

  Future<DateTime> _selectDate(
      BuildContext context, DateTime _selectedDate) async {
    DateTime? datePicker = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2015),
      lastDate: DateTime(2050),
    );
    if (datePicker != null && datePicker != _selectedDate) {
      //if the user has selected a date
      setState(() {
        // we format the selected date and assign it to the state variable
        _selectedDate = datePicker;

        print(
          formatter.format(_selectedDate).toString(),
        );
      });
    }
    return (_selectedDate);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Background(
        child: SingleChildScrollView(
          child: Form(
            key: _issueformKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20.0,
              ),
              child: Column(
                children: [
                  const Text(
                    "Issue a Book",
                    style: kscreentitle,
                  ),
                  const SizedBox(
                    width: 10.0,
                  ),
                  TextFormField(
                    controller: mem_id,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Enter Membership Id";
                      }
                    },
                    decoration: InputDecoration(
                      labelText: "Membership ID",
                      hintText: "Membership ID",
                      suffixIcon: TextButton(
                        onPressed: () async {
                          if (mem_id.text.isNotEmpty) {
                            final memdetail = await FirebaseFirestore.instance
                                .collection('member')
                                .doc(mem_id.text.toUpperCase())
                                .get();

                            if (memdetail.exists) {
                              setState(() {
                                name.text = memdetail['name'];
                              });
                            } else {
                              final snackbar = SnackBar(
                                content: const Text("No User Found"),
                                action: SnackBarAction(
                                  label: 'dismiss',
                                  onPressed: () {},
                                ),
                              );
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackbar);
                              print("No user found");
                            }
                          }
                        },
                        child: const Text("Validate"),
                      ),
                    ),
                  ),
                  TextFormField(
                    controller: name,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "No member found";
                      }
                    },
                    readOnly: true,
                    decoration: const InputDecoration(
                      labelText: "Name",
                      hintText: "Name",
                    ),
                  ),
                  TextFormField(
                    controller: _bookid,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Enter Book ID";
                      }
                    },
                    decoration: InputDecoration(
                      labelText: "Book ID",
                      hintText: "Book ID",
                      suffixIcon: TextButton(
                        onPressed: () async {
                          if (_bookid.text.isNotEmpty) {
                            final bookdetail = await FirebaseFirestore.instance
                                .collection('books')
                                .doc(_bookid.text.toUpperCase())
                                .get();

                            if (bookdetail.exists) {
                              setState(() {
                                _bookname.text = bookdetail['bookname'];
                              });
                            } else {
                              final snackbar = SnackBar(
                                content: const Text("No Book Found"),
                                action: SnackBarAction(
                                  label: 'dismiss',
                                  onPressed: () {},
                                ),
                              );
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackbar);
                              print("No book found");
                            }

                            print("Validated");
                          }
                        },
                        child: const Text("Validate"),
                      ),
                    ),
                  ),
                  TextFormField(
                    controller: _bookname,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "No book found";
                      }
                    },
                    readOnly: true,
                    decoration: const InputDecoration(
                      labelText: "Book Name",
                      hintText: "Book Name",
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () async {
                          fromDate = await _selectDate(context, fromDate);
                          fromDate =
                              DateTime.now().difference(fromDate).inDays < 0
                                  ? DateTime.now()
                                  : fromDate;
                          setState(() {
                            toDate = fromDate.add(Duration(days: 15));
                          });
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text("Issue Date"),
                            Container(
                              // margin: EdgeInsets.symmetric(vertical: 20),
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              // decoration: BoxDecoration(
                              //   color: Colors.grey.withOpacity(.7),
                              //   borderRadius: BorderRadius.circular(10),
                              // ),
                              child: Text(
                                formatter.format(fromDate).toString(),
                              ),
                            ),
                          ],
                        ),
                      ),
                      InkWell(
                        onTap: () async {
                          toDate = await _selectDate(context, toDate);
                          setState(() {
                            toDate =
                                DateTime.now().difference(toDate).inDays > 0
                                    ? DateTime.now().add(Duration(days: 14))
                                    : toDate;
                          });
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text("Due Date"),
                            Container(
                              // margin: EdgeInsets.symmetric(vertical: 20),
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              // decoration: BoxDecoration(
                              //   color: Colors.grey.withOpacity(.7),
                              //   borderRadius: BorderRadius.circular(10),
                              // ),
                              child: Text(
                                formatter.format(toDate).toString(),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  // TextFormField(
                  //   controller: _dateController,
                  //   onTap: () async {
                  //     fromDate = await _selectDate(context, fromDate);
                  //     setState(() {
                  //       toDate = fromDate.add(Duration(days: 15));
                  //       _duedateController.text = toDate.toString();
                  //     });
                  //     // setState(() {});
                  //   },

                  //   decoration: InputDecoration(
                  //     // labelText: "Issue Date",
                  //     hintText: (formatter.format(fromDate).toString()),
                  //   ),
                  //   //TODO taking input to give to db and hinttext label text transition
                  // ),
                  // TextFormField(
                  //   controller: _duedateController,

                  //   onTap: () async {
                  //     toDate = await _selectDate(context, toDate);

                  //     print(_duedateController.text);
                  //   },

                  //   decoration: InputDecoration(
                  //     // labelText: "Issue Date",
                  //     hintText: (formatter.format(toDate).toString()),
                  //   ),
                  //   //TODO taking input to give to db and hinttext label text transition
                  //   // set different controllers for both date
                  // ),
                  const SizedBox(
                    height: 15.0,
                  ),
                  TextButton(
                    onPressed: () async {
                      if (_issueformKey.currentState!.validate()) {
                        bool? issuestatus = await BookService()
                            .issueBook(
                          Issued(
                              bookId: _bookid.text,
                              bookName: _bookname.text,
                              memId: mem_id.text.toUpperCase(),
                              name: name.text,
                              date: fromDate,
                              duedate: toDate),
                        )
                            .then((value) {
                          _bookid.clear();
                          _bookname.clear();
                          mem_id.clear();
                          name.clear();
                          final snackbar = SnackBar(
                            backgroundColor: Colors.greenAccent,
                            content: const Text(
                              "Issue Successful",
                              style: TextStyle(color: Colors.black),
                            ),
                            action: SnackBarAction(
                              textColor: Colors.black,
                              label: 'dismiss',
                              onPressed: () {},
                            ),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackbar);
                          //Navigator.of(context).pop();
                        }).onError((error, stackTrace) {
                          final snackbar = SnackBar(
                            backgroundColor: Colors.redAccent,
                            content: const Text(
                              "Issue Failed",
                              style: TextStyle(color: Colors.white),
                            ),
                            action: SnackBarAction(
                              textColor: Colors.white,
                              label: 'dismiss',
                              onPressed: () {},
                            ),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackbar);
                        });
                      }
                    },
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(vertical: size.height * .02),
                      decoration: BoxDecoration(
                          color: kprimarylightcolor,
                          borderRadius: BorderRadius.circular(10)),
                      width: double.infinity,
                      child: const Center(
                        child: Text(
                          "Issue Book",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
