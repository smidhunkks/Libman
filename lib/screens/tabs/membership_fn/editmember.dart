import 'package:flutter/material.dart';
import 'package:libman/Components/background.dart';
import 'package:libman/Components/model/membership.dart';
import 'package:libman/constants.dart';
import 'package:intl/intl.dart';
import 'package:libman/services/userservice.dart';

class EditMember extends StatefulWidget {
  EditMember(
      {Key? key,
      this.dob,
      this.joindate,
      this.name,
      this.address,
      this.ward,
      this.pin,
      this.place,
      this.phone,
      this.category,
      this.bloodgroup,
      this.id})
      : super(key: key);
  final DateTime? dob;
  final DateTime? joindate;
  final String? name;
  final String? address;
  final int? ward;
  final int? pin;
  final String? place;
  final int? phone;
  final String? category;
  final String? bloodgroup;
  final String? id;

  @override
  State<EditMember> createState() => _EditMemberState();
}

class _EditMemberState extends State<EditMember> {
  final _formKey = GlobalKey<FormState>();
  final DateFormat formatter = DateFormat('dd-MM-yyyy');
  int selectedbloodgp = 0;
  int selectedcategory = 0;

  dynamic _selectedDate = DateTime.now();
  dynamic _joiningDate = DateTime.now();

  TextEditingController _dateController = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController ward = TextEditingController();
  TextEditingController pin = TextEditingController();
  TextEditingController place = TextEditingController();

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
    // TODO: implement initState
    name.text = widget.name ?? widget.name!;
    phone.text = widget.phone.toString();
    address.text = widget.address ?? widget.address!;
    ward.text = widget.ward.toString();
    pin.text = widget.ward.toString();
    place.text = widget.pin.toString();
    phone.text = widget.phone.toString();
    selectedcategory = category.indexOf(widget.category!);
    selectedbloodgp = bloodgroup.indexOf(widget.bloodgroup!);
    super.initState();
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
                    keyboardType: TextInputType.phone,
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
                          keyboardType: TextInputType.number,
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
                          keyboardType: TextInputType.number,
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    //scrossAxisAlignment: CrossAxisAlignment.baseline,
                    children: [
                      Expanded(
                        flex: 4,
                        child: TextFormField(
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
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        flex: 2,
                        child: InkWell(
                          onTap: () async {
                            final tempJoin = await _selectDate(context);
                            setState(() {
                              _joiningDate = tempJoin;
                            });
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 20,
                              ),
                              const Text("Join Date"),
                              Container(
                                // margin: EdgeInsets.symmetric(vertical: 20),
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                // decoration: BoxDecoration(
                                //   color: Colors.grey.withOpacity(.7),
                                //   borderRadius: BorderRadius.circular(10),
                                // ),
                                child: Text(
                                  formatter.format(_joiningDate).toString(),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      InkWell(
                        onTap: () async {
                          final tempDob = await _selectDate(context);
                          setState(() {
                            _selectedDate = tempDob;
                          });
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
                    ],
                  ),
                  TextButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        //print("mwone set");
                        UserService()
                            .updateMember(
                          Member(
                              name.text,
                              int.parse(phone.text),
                              address.text,
                              int.parse(pin.text),
                              int.parse(ward.text),
                              place.text,
                              _selectedDate,
                              bloodgroup[selectedbloodgp],
                              category[selectedcategory],
                              _joiningDate,
                              widget.id!,
                              false,
                              _joiningDate),
                        )
                            .then((value) {
                          name.clear();
                          phone.clear();
                          address.clear();
                          ward.clear();
                          place.clear();
                          Navigator.of(context).pop();
                        });
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
                          "Add/Update member",
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
