import 'package:flutter/material.dart';
import 'package:libman/Components/background.dart';
import 'package:libman/constants.dart';
import 'package:intl/intl.dart';
import 'package:libman/screens/tabs/membership_fn/editmember.dart';

class MemberDetails extends StatelessWidget {
  const MemberDetails(
      {Key? key, this.memberData, this.action, this.deleteaction})
      : super(key: key);

  final dynamic memberData;
  final Widget? action;
  final Widget? deleteaction;

  @override
  Widget build(BuildContext context) {
    final DateFormat formatter = DateFormat('dd-MM-yyyy');
    return Scaffold(
      body: Background(
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Member details",
                    style: kscreentitle.copyWith(color: Colors.grey),
                  ),
                  deleteaction != null ? deleteaction! : Container(),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                "Id : ${memberData.id}",
                style: kcardtext.copyWith(fontSize: 20),
              ),
              Text(
                "Name :  ${memberData['name']}",
                style: kcardtext.copyWith(
                    fontSize: 23, fontWeight: FontWeight.w500),
              ),
              //status ?? status!,
              const SizedBox(
                height: 10,
              ),
              const Divider(
                color: Colors.black87,
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    child: Row(
                      children: [
                        Text(
                          "DOB : ",
                          style: kcardtext.copyWith(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          '${formatter.format(memberData['dob'].toDate())}',
                          style: kcardtext.copyWith(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        )
                      ],
                    ),
                  ),
                  InkWell(
                    child: Row(
                      children: [
                        Text(
                          'Bloodgroup : ',
                          style: kcardtext.copyWith(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          '${memberData['bloodgroup']}',
                          style: kcardtext.copyWith(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Address :",
                style: kcardtext.copyWith(
                    fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Text(
                "${memberData['address']}",
                style: kcardtext.copyWith(
                    fontSize: 18, fontStyle: FontStyle.italic),
              ),
              Text(
                "${memberData['place']}",
                style: kcardtext.copyWith(
                    fontSize: 18, fontStyle: FontStyle.italic),
              ),

              Text(
                "${memberData['postoffice']}",
                style: kcardtext.copyWith(
                    fontSize: 18, fontStyle: FontStyle.italic),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Ward : ${memberData['wardno']}",
                style: kcardtext.copyWith(
                    fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Icon(Icons.phone),
                  Text(
                    " ${memberData['phone']}  ",
                    style: kcardtext.copyWith(fontSize: 18),
                  ),
                ],
              ),
              // Text(
              //   "Status :  ",
              //   style: kcardtext.copyWith(fontSize: 18),
              // ),

              const SizedBox(
                height: 40,
              ),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  //color: kprimarycolor,
                  border: Border.all(width: 2, color: kprimarycolor),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: TextButton(
                  onPressed: () async {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => EditMember(
                          pin: memberData['postoffice'],
                          ward: memberData['wardno'],
                          phone: memberData['phone'],
                          name: memberData['name'],
                          address: memberData['address'],
                          dob: memberData['dob'].toDate(),
                          bloodgroup: memberData['bloodgroup'],
                          place: memberData['place'],
                          category: memberData['membergroup'],
                          joindate: memberData['joindate'].toDate(),
                          id: memberData.id,
                        ),
                      ),
                    );
                  },
                  child: Text(
                    "Edit",
                    style: kcardtext.copyWith(
                      color: Colors.black,
                      fontSize: 17,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              action != null ? action! : Container(),
              // approve ?? approve!,
            ],
          ),
        ),
      ),
    );
  }
}
