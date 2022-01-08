import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:libman/Components/background.dart';
import 'package:libman/constants.dart';
import 'package:intl/intl.dart';

class AddProgram extends StatefulWidget {
  const AddProgram(
      {Key? key,
      this.programname,
      this.programcategory,
      this.participantcount,
      this.date,
      this.id})
      : super(key: key);
  final String? programname;
  final String? programcategory;
  final String? participantcount;
  final DateTime? date;
  final String? id;

  @override
  State<AddProgram> createState() => _AddProgramState();
}

class _AddProgramState extends State<AddProgram> {
  TextEditingController programname = TextEditingController();
  TextEditingController programcategory = TextEditingController();
  TextEditingController participantcount = TextEditingController();
  bool isEdit = false;

  final DateFormat formatter = DateFormat('dd-MM-yyyy');

  dynamic _programDate = DateTime.now();

  Future<DateTime> _selectDate(BuildContext context) async {
    final DateTime? d = await showDatePicker(
      //we wait for the dialog to return
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1949),
      lastDate: DateTime(2050),
    );
    if (d != null) {
      //if the user has selected a date
      return d;
      // setState(() {
      //   // we format the selected date and assign it to the state variable
      //   _selectedDate = d;
      // });
    } else {
      return DateTime.now();
    }
  }

  @override
  void initState() {
    programname.text = widget.programname == null ? "" : widget.programname!;
    programcategory.text =
        widget.programcategory == null ? "" : widget.programcategory!;
    participantcount.text =
        widget.participantcount == null ? "" : widget.participantcount!;
    _programDate = widget.date == null ? DateTime.now() : widget.date!;
    isEdit = widget.programname == null ? false : true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _formkey = GlobalKey<FormState>();
    return Scaffold(
      body: Background(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20),
            child: Form(
              key: _formkey,
              child: Column(
                children: [
                  const Text(
                    "Add Program",
                    style: kscreentitle,
                  ),
                  TextFormField(
                    controller: programname,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Enter Program Name";
                      }
                    },
                    decoration: const InputDecoration(
                      labelText: "Program Name",
                      hintText: "Program Name",
                    ),
                  ),
                  TextFormField(
                    controller: programcategory,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Enter Category";
                      }
                    },
                    decoration: const InputDecoration(
                      labelText: "Category",
                      hintText: "Category",
                    ),
                  ),
                  TextFormField(
                    controller: participantcount,
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Enter Participant Count";
                      }
                    },
                    decoration: const InputDecoration(
                      labelText: "Participant Count",
                      hintText: "Participant Count",
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: InkWell(
                      onTap: () async {
                        final tempDob = await _selectDate(context);
                        setState(
                          () {
                            _programDate = tempDob;
                          },
                        );
                      },
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text("Program Date : "),
                          Container(
                            // margin: EdgeInsets.symmetric(vertical: 20),
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            // decoration: BoxDecoration(
                            //   color: Colors.grey.withOpacity(.7),
                            //   borderRadius: BorderRadius.circular(10),
                            // ),
                            child: Text(
                              formatter.format(_programDate).toString(),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: kprimarycolor,
                        borderRadius: BorderRadius.circular(8)),
                    child: TextButton(
                      onPressed: () async {
                        if (_formkey.currentState!.validate()) {
                          if (isEdit) {
                            FirebaseFirestore.instance
                                .collection('programs')
                                .doc(widget.id)
                                .update({
                              "programname": programname.text,
                              "programcategory": programcategory.text,
                              "participantcount": participantcount.text,
                              "Date": _programDate,
                              "timestamp": DateTime.now()
                            }).then(
                              (value) => Navigator.of(context).pop(),
                            );
                          } else {
                            FirebaseFirestore.instance
                                .collection('programs')
                                .doc()
                                .set({
                              "programname": programname.text,
                              "programcategory": programcategory.text,
                              "participantcount": participantcount.text,
                              "Date": _programDate,
                              "timestamp": DateTime.now()
                            }).then(
                              (value) => Navigator.of(context).pop(),
                            );
                          }
                        }
                      },
                      child: Text(
                        isEdit ? "Update program" : "Add Program",
                        style: TextStyle(color: Colors.white),
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
