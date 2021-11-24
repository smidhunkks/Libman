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
  int selectedbloodgp = 0;
  int selectedcategory = 0;

  dynamic _selectedDate = DateTime.now();
  List<String> bloodgroup = [
    "A+ve",
    "A-ve",
    "B+ve",
    "B-ve",
    "AB+ve",
    "AB-ve",
    "O+ve",
    "O-ve"
  ];
  List<String> category = ["A", "B", "Deposit"];

  TextEditingController _dateController = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController ward = TextEditingController();
  TextEditingController pin = TextEditingController();
  TextEditingController place = TextEditingController();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? d = await showDatePicker(
      //we wait for the dialog to return
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2015),
      lastDate: DateTime(2050),
    );
    if (d != null) {
      //if the user has selected a date
      setState(() {
        // we format the selected date and assign it to the state variable
        _selectedDate = d;
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
                    controller: name,
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
                    controller: phone,
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
                    controller: address,
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
                          controller: ward,
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
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: TextFormField(
                          controller: pin,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Enter PIN";
                            }
                          },
                          decoration: const InputDecoration(
                            labelText: "PIN Code ",
                            hintText: "//eg:683513",
                          ),
                        ),
                      ),
                    ],
                  ),
                  TextFormField(
                    controller: place,
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
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      InkWell(
                        onTap: () {
                          _selectDate(context);
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text("DOB"),
                            Container(
                              // margin: EdgeInsets.symmetric(vertical: 20),
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              // decoration: BoxDecoration(
                              //   color: Colors.grey.withOpacity(.7),
                              //   borderRadius: BorderRadius.circular(10),
                              // ),
                              child: Text(
                                formatter.format(_selectedDate).toString(),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("Blood Group"),
                          DropdownButton(
                            value: selectedbloodgp,
                            items: List.generate(
                                bloodgroup.length,
                                (index) => DropdownMenuItem(
                                      child: Text(bloodgroup[index]),
                                      value: index,
                                    )),
                            onChanged: (int? value) {
                              setState(() {
                                selectedbloodgp = value!;
                              });
                            },
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          const Text("Category"),
                          DropdownButton(
                            hint: const Text("Category"),
                            value: selectedcategory,
                            items: List.generate(
                                category.length,
                                (index) => DropdownMenuItem(
                                      child: Text(category[index]),
                                      value: index,
                                    )),
                            onChanged: (int? value) {
                              print(value);
                              setState(() {
                                selectedcategory = value!;
                              });
                            },
                          ),
                        ],
                      )
                      // DatePickerDialog(5
                      //   initialDate: DateTime.now(),
                      //   firstDate: DateTime(2015),
                      //   lastDate: DateTime(2050),
                      // ),
                    ],
                  ),
                  TextButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        print("mwone set");
                      }
                    },
                    child: Container(
                        padding:
                            EdgeInsets.symmetric(vertical: size.height * .02),
                        decoration: BoxDecoration(
                            color: kprimarylightcolor,
                            borderRadius: BorderRadius.circular(8)),
                        width: double.infinity,
                        child: const Center(
                            child: Text(
                          "Add member",
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
