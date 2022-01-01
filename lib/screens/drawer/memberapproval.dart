import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:libman/Components/background.dart';
import 'package:libman/constants.dart';
import 'package:libman/screens/tabs/membership_fn/memberdetails.dart';

class ApprovalList extends StatelessWidget {
  const ApprovalList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Background(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Stock Register",
                  style: kscreentitle.copyWith(color: Colors.black45),
                ),
                SizedBox(
                  height: 20,
                ),
                StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('member')
                        .snapshots(),
                    builder: (context, AsyncSnapshot snapshot) {
                      if (snapshot.hasError) {
                        return const Text("Something Went Wrong");
                      }
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Padding(
                          padding: EdgeInsets.all(40),
                          child: CircularProgressIndicator(),
                        );
                      }
                      return snapshot.data!.docs.length == 0
                          ? const Center(
                              child: Text(
                              "No Pending Membership Found",
                              style: kcardtext,
                            ))
                          : Expanded(child: pendingFilter(snapshot));
                    })
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget pendingFilter(AsyncSnapshot<dynamic> snapshot) {
    List pendingList = [];
    for (var item in snapshot.data.docs) {
      if (!item['isVerified']) {
        pendingList.add(item);
      }
    }
    return MemberlistCard(pendingList);
  }

  ListView MemberlistCard(List<dynamic> _socialListItems) {
    return ListView.builder(
        itemCount: _socialListItems.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (ctx) => MemberDetails(
                    approve: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: kprimarycolor,
                        //border: Border.all(width: 2, color: kprimarycolor),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: TextButton(
                        onPressed: () async {
                          FirebaseFirestore.instance
                              .collection('member')
                              .doc(_socialListItems[index].id)
                              .update({"isVerified": true}).then(
                                  (value) => Navigator.of(context).pop());
                        },
                        child: Text(
                          "Approve",
                          style: kcardtext.copyWith(
                            color: Colors.white,
                            fontSize: 17,
                          ),
                        ),
                      ),
                    ),
                    memberData: _socialListItems[index],
                  ),
                ),
              );
            },
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 10),
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
              //color: Colors.cyan[50],
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: const [
                    BoxShadow(
                        color: Colors.black26, blurRadius: 30, spreadRadius: 2)
                  ]),
              //elevation: 5.0,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            " ${_socialListItems[index]['name']}",
                            style: kcardtext.copyWith(
                                fontWeight: FontWeight.w500,
                                fontSize: 20,
                                color: Colors.black87),
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.home,
                                color: Colors.black54,
                              ),
                              Text(
                                "${_socialListItems[index]['address']}",
                                style: kcardtext.copyWith(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black54,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Text(
                        '${_socialListItems[index].id}',
                        style: kcardtext.copyWith(
                          fontSize: 18,
                          color: kprimarylightcolor,
                        ),
                      )
                    ],
                  ),
                  const Text(
                    "Tap to view details",
                    style: kcardtext,
                  )
                ],
              ),
            ),
          );
        });
  }
}
