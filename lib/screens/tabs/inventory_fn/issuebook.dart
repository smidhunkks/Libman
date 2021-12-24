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

  final String _setDate="Choose a date";
  final _issueformKey = GlobalKey<FormState>();

  final DateFormat formatter = DateFormat('yyyy-MM-dd');
  

  DateTime _selectedDate = DateTime.now();

  TextEditingController _dateController = TextEditingController();
  TextEditingController mem_id = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController _bookid = TextEditingController();
  TextEditingController _bookname = TextEditingController();
  TextEditingController _duedateController = TextEditingController();


  Future<void> _selectDate(BuildContext context) async {
    
    DateTime? datePicker = await showDatePicker(
    
    context: context,
    initialDate: _selectedDate,
    firstDate: DateTime(2015),
    lastDate: DateTime(2050),

    // builder: (BuildContext context, Widget child){
    //   return Theme(
    //     data: ThemeData(
    //       primaryColor:kprimarycolor,
    //       // primarySwatch accentColor
    //     ),
    //     child: child,

    //   );

    // }
    );
    if (datePicker != null && datePicker != _selectedDate) {
      //if the user has selected a date
      setState(() {
        // we format the selected date and assign it to the state variable
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
                  SizedBox(
                    width:10.0,
                  ),
                  TextFormField(
                    controller: mem_id,
                    
                    decoration: const InputDecoration(
                      labelText: "Membership ID",
                      hintText: "Membership ID",
                    ),
                  ),
                  TextFormField(
                   
                    controller: name,
                    
                    decoration: const InputDecoration(
                      labelText: "Name",
                      hintText: "Name",
                    ),
                  ),

                  TextFormField(
                   
                    controller: _bookid,
                    
                    decoration: const InputDecoration(
                      labelText: "Book ID",
                      hintText: "Book ID",
                    ),
                  ),
                   TextFormField(
                   
                    controller: _bookname,
                    
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
                // labelText: "Issue Date",
                hintText:(formatter.format(_selectedDate).toString()),
                ),
            //TODO taking input to give to db and hinttext label text transition
            
            ),

            TextFormField(
              controller: _duedateController,
              onTap:(){
                setState((){
                 _selectDate(context);
                 
                });
               print(_duedateController.text);
              },
              
              decoration: InputDecoration(
                // labelText: "Issue Date",
                hintText:(formatter.format(_selectedDate).toString()),
                ),
            //TODO taking input to give to db and hinttext label text transition
            // set different controllers for both date
            
            ),
            SizedBox(height:15.0,),
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