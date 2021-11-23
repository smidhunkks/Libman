import 'package:flutter/material.dart';
import 'package:libman/Components/background.dart';
import 'package:libman/constants.dart';
import 'package:intl/intl.dart';

class AddMember extends StatefulWidget {
  AddMember({Key? key}) : super(key: key);

  @override
  State<AddMember> createState() => _AddMemberState();
}

class _AddMemberState extends State<AddMember> {
  final _formKey = GlobalKey<FormState>();
  final DateFormat formatter = DateFormat('yyyy-MM-dd');

  dynamic _selectedDate = DateTime.now();

  TextEditingController _dateController = new TextEditingController();
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? d = await showDatePicker(
      //we wait for the dialog to return
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2015),
      lastDate: DateTime(2050),
    );
    if (d != null) //if the user has selected a date
      setState(() {
        // we format the selected date and assign it to the state variable
        _selectedDate = d;
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Background(
        child: SingleChildScrollView(
          child: Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20.0,
                ),
                child: Column(
                  children: [
                    const Text(
                      "Add Member",
                      style: kscreentitle,
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Enter Name";
                        }
                      },
                      decoration: const InputDecoration(
                        labelText: "Name",
                        hintText: "Name",
                      ),
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Enter Phone";
                        }
                      },
                      decoration: const InputDecoration(
                        labelText: "Phone",
                        hintText: "Phone",
                      ),
                    ),
                    TextFormField(
                      maxLines: 3,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Enter Address";
                        }
                      },
                      decoration: const InputDecoration(
                        labelText: "Address",
                        hintText: "Address",
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Enter Ward";
                              }
                            },
                            decoration: const InputDecoration(
                              labelText: "Ward",
                              hintText: "Ward",
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: TextFormField(
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Enter PIN";
                              }
                            },
                            decoration: const InputDecoration(
                              labelText: "PIN Code ",
                              hintText: "PIN //eg:683513",
                            ),
                          ),
                        ),
                      ],
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Enter Place";
                        }
                      },
                      decoration: const InputDecoration(
                        labelText: "Place",
                        hintText: "Place",
                      ),
                    ),
                    Row(
                      children: [
                        Icon(Icons.date_range),
                        InkWell(
                          onTap: () {
                            _selectDate(context);
                          },
                          child: Container(
                            margin: EdgeInsets.symmetric(vertical: 20),
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.grey.withOpacity(.7),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              formatter.format(_selectedDate).toString(),
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        )
                        // DatePickerDialog(
                        //   initialDate: DateTime.now(),
                        //   firstDate: DateTime(2015),
                        //   lastDate: DateTime(2050),
                        // ),
                      ],
                    ),
                  ],
                ),
              )),
        ),
      ),
    );
  }
}
