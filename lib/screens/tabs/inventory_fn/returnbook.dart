import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:libman/Components/background.dart';
import 'package:libman/Components/model/membership.dart';
import 'package:libman/constants.dart';
import 'package:intl/intl.dart';
import 'package:libman/services/userservice.dart';
class ReturnBook extends StatefulWidget {
  ReturnBook({Key? key}) : super(key: key);

  @override
  _ReturnBookState createState() => _ReturnBookState();
}

class _ReturnBookState extends State<ReturnBook> {

    final _returnformKey = GlobalKey<FormState>();


  TextEditingController _bookid = TextEditingController();
  TextEditingController _bookname = TextEditingController();
    TextEditingController _dateController = TextEditingController();

  final DateFormat formatter = DateFormat('dd-MM-yyyy');
  DateTime _selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {

    DateTime? datePicker = await showDatePicker(

    context: context,
    initialDate: _selectedDate,
    firstDate: DateTime(2015),
    lastDate: DateTime(2050),

    );
    if (datePicker != null && datePicker != _selectedDate) {
      
      setState(() {
        _selectedDate = datePicker;
        print(formatter.format(_selectedDate).toString(),);
      });
    }



  }




  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Background(
        child: SingleChildScrollView(
          child: Form(
            key: _returnformKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20.0,
              ),
              child: Column(
                children: [
                  const Text(
                    "Return Book",
                    style: kscreentitle,
                  ),
                  const SizedBox(
                    width: 10.0,
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
              onTap:(){
                setState((){
                 _selectDate(context);
                });

              },

              decoration: InputDecoration(
                // labelText: "Return Date",
                hintText:(formatter.format(_selectedDate).toString()),
                ),
            //TODO taking input to give to db and hinttext label text transition

            ),

                  const SizedBox(
                    height: 15.0,
                  ),
                  TextButton(
                    onPressed: () async {
                      
                      }
                    ,
                    child: Container(
                        padding:
                            EdgeInsets.symmetric(vertical: size.height * .02),
                        decoration: BoxDecoration(
                            color: kprimarylightcolor,
                            borderRadius: BorderRadius.circular(10)),
                        width: double.infinity,
                        child: const Center(
                            child: Text(
                          "Update Return ",
                          style: TextStyle(color: Colors.white),
                        ))),
                  ),
                ],
              ),
            ),
          ),
        ),
    ),
    );
  }
}