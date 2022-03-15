import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:libman/Components/background.dart';
import 'package:libman/constants.dart';

class RoleManagement extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Background(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Registered Users",
                style: kscreentitle.copyWith(color: Colors.black45),
              ),
              Divider(color: Colors.black54),
              const SizedBox(
                height: 20,
              ),
              StreamBuilder(
                stream:
                    FirebaseFirestore.instance.collection('users').snapshots(),
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
                  return snapshot.hasData
                      ? Expanded(
                          child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              //border: Border.all(width: 2, color: kprimarycolor),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: ListView.builder(
                              itemCount: snapshot.data!.docs.length,
                              itemBuilder: (ctx, index) {
                                print(snapshot.data.docs);
                                if (FirebaseAuth.instance.currentUser!.email !=
                                    snapshot.data.docs[index].id) {
                                  return ListTile(
                                    title: Text(
                                        snapshot.data!.docs[index]['email']),
                                    trailing: TextButton(
                                      onPressed: () {},
                                      child: Text("data"),
                                    ),
                                  );
                                } else {
                                  return ListTile(
                                    title: Text(
                                        snapshot.data!.docs[index]['email']),
                                  );
                                }
                              },
                            ),
                          ),
                        )
                      : Container();
                },
              )
              // Container(
              //   width: double.infinity,
              //   padding: EdgeInsets.all(8),
              //   margin: EdgeInsets.all(10),
              //   height: MediaQuery.of(context).size.height * .4,
              //   decoration: BoxDecoration(
              //       borderRadius: BorderRadius.circular(8),
              //       boxShadow: [
              //         BoxShadow(blurRadius: 10, color: Colors.black26)
              //       ],
              //       color: Colors.white),
              //   child: Column(
              //     children: [
              //       Text("data"),
              //     ],
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
