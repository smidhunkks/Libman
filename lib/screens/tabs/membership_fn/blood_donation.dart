import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:libman/Components/background.dart';
import 'package:libman/constants.dart';
import 'package:url_launcher/url_launcher.dart';

class BloodDonorList extends StatelessWidget {
  const BloodDonorList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    TextEditingController searchstring = TextEditingController();
    final donorInfo = FirebaseFirestore.instance.collection("member");
    return Scaffold(
      body: Background(
          child: SafeArea(
        child: Column(
          //mainAxisSize: MainAxisSize.max,
          children: [
            Text(
              "Blood Donation",
              style: TextStyle(
                  fontSize: size.width * .07,
                  fontFamily: "RedHat",
                  fontWeight: FontWeight.w600,
                  color: Colors.black.withOpacity(.5)),
            ),
            SizedBox(
              height: 20,
            ),
            Expanded(
              child: StreamBuilder(
                  stream: donorInfo.snapshots(),
                  builder: (ctx, AsyncSnapshot snapshot) {
                    if (snapshot.hasError) {
                      return const Text("Something went wrong");
                    }
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    }
                    return snapshot.data!.docs.length == 0
                        ? const Center(
                            child: Text(
                            "No Donor found",
                            // style: kcardlighttext,
                          ))
                        : ListView.separated(
                            itemBuilder: (context, index) => ListTile(
                                  title:
                                      Text(snapshot.data.docs[index]['name']),
                                  leading: CircleAvatar(
                                    backgroundColor: kprimarycolor,
                                    radius: 50,
                                    //backgroundImage: Icon(Icons.bloodtype),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Center(
                                        child: Text(snapshot.data.docs[index]
                                            ['bloodgroup']),
                                      ),
                                    ),
                                  ),
                                  trailing: IconButton(
                                    icon: Icon(Icons.call),
                                    onPressed: () {
                                      launch(
                                          'tel:${snapshot.data.docs[index]["phone"]}');
                                    },
                                  ),
                                ),
                            separatorBuilder: (context, index) => SizedBox(
                                  height: 20,
                                ),
                            itemCount: snapshot.data.docs.length);
                  }),
            ),
          ],
        ),
      )),
    );
  }
}
