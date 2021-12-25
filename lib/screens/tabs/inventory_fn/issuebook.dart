import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:libman/Components/background.dart';
import 'package:libman/Components/model/membership.dart';
import 'package:libman/constants.dart';
import 'package:intl/intl.dart';
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
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);

  TextEditingController _dateController = TextEditingController();
  TextEditingController mem_id = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController _bookid = TextEditingController();
  TextEditingController _bookname = TextEditingController();
  TextEditingController _duedateController = TextEditingController();

void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  Future<DateTime> _selectDate(BuildContext context, DateTime _selectedDate) async {
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
    return(_selectedDate);
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
                    decoration: InputDecoration(
                      labelText: "Membership ID",
                      hintText: "Membership ID",
                      suffixIcon: TextButton(
                        onPressed: () async {
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
                        },
                        child: const Text("Validate"),
                      ),
                    ),
                  ),
                  TextFormField(
                    controller: name,
                    readOnly: true,
                    decoration: const InputDecoration(
                      labelText: "Name",
                      hintText: "Name",
                    ),
                  ),
                  TextFormField(
                    controller: _bookid,
                    decoration: InputDecoration(
                      labelText: "Book ID",
                      hintText: "Book ID",
                      suffixIcon: TextButton(
                        onPressed: () async {
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
                        },
                        child: const Text("Validate"),
                      ),
                    ),
                  ),
                  TextFormField(
                    controller: _bookname,
                    readOnly: true,
                    decoration: const InputDecoration(
                      labelText: "Book Name",
                      hintText: "Book Name",
                    ),
                  ),
                  TextFormField(
                    controller: _dateController,
                    onTap: () async {
                        
                      fromDate = await _selectDate(context, fromDate);
                      setState(() {});
                        
                      
                    },

                    decoration: InputDecoration(
                      // labelText: "Issue Date",
                      hintText: (formatter.format(fromDate).toString()),
                    ),
                    //TODO taking input to give to db and hinttext label text transition
                  ),
                  TextFormField(
                    controller: _duedateController,
                    onTap: () async {
                      toDate = await _selectDate(context, toDate);
                      setState(() {});
                      print(_duedateController.text);
                    },

                    decoration: InputDecoration(
                      // labelText: "Issue Date",
                      hintText: (formatter.format(toDate).toString()),
                    ),
                    //TODO taking input to give to db and hinttext label text transition
                    // set different controllers for both date
                  ),
                  const SizedBox(
                    height: 15.0,
                  ),
                  TextButton(
                    onPressed: () async {
                      if (_issueformKey.currentState!.validate()) {
                        print("mwone set");
                        // UserService()
                        //     .addMember(
                        //   Member(
                        //       name.text,
                        //       int.parse(phone.text),
                        //       address.text,
                        //       int.parse(pin.text),
                        //       int.parse(ward.text),
                        //       place.text,
                        //       _selectedDate,
                        //       bloodgroup[selectedbloodgp],
                        //       category[selectedcategory],
                        //       DateTime.now(),
                        //       "VPL0001",
                        //       false),
                        // )
                        //     .then((value) {
                        //   name.clear();
                        //   phone.clear();
                        //   address.clear();
                        //   ward.clear();
                        //   place.clear();
                        //   Navigator.of(context).pop();
                        // });
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
                        ))),
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
