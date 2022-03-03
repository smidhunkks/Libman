import 'package:flutter/material.dart';
import 'package:libman/Components/background.dart';
import 'package:libman/constants.dart';
import 'package:intl/intl.dart';

class IssueHistory extends StatelessWidget {
  const IssueHistory(
      {Key? key, this.Id, this.activeIssue, this.issuehistory, this.bookName})
      : super(key: key);
  final String? Id;
  final String? bookName;
  final Map<String, dynamic>? activeIssue;
  final List? issuehistory;
  @override
  Widget build(BuildContext context) {
    final DateFormat formatter = DateFormat('dd-MM-yyyy');
    Size size = MediaQuery.of(context).size;
    // print(issuehistory);
    return Scaffold(
      body: Background(
        child: SafeArea(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            width: double.infinity,
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Issue History : $bookName",
                  style: kscreentitle.copyWith(color: Colors.grey),
                ),
                const Divider(
                  color: Colors.black87,
                  endIndent: 15,
                ),
                issuehistory!.isNotEmpty
                    ? Expanded(
                        child: ListView.builder(
                          itemCount: issuehistory!.length,
                          itemBuilder: (BuildContext context, index) {
                            return Container(
                              margin: const EdgeInsets.symmetric(vertical: 10),
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8),
                                  boxShadow: const [
                                    BoxShadow(
                                        color: Colors.black26,
                                        blurRadius: 30,
                                        spreadRadius: 2)
                                  ]),
                              child: ListTile(
                                isThreeLine: true,
                                subtitle: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                        "issued on : ${formatter.format(issuehistory![index]['issuedate'].toDate())}",
                                        style: kcardtext.copyWith(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w500)),
                                    Text(
                                        "Return on : ${formatter.format(issuehistory![index]['returndate'].toDate())}",
                                        style: kcardtext.copyWith(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w500))
                                  ],
                                ),
                                trailing: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text("Mem Id",
                                        style:
                                            kcardtext.copyWith(fontSize: 15)),
                                    Text("${issuehistory![index]['memId']}",
                                        style:
                                            kcardtext.copyWith(fontSize: 20)),
                                  ],
                                ),
                                title: Text(
                                    "${issuehistory![index]['memberName']}"),
                              ),
                            );
                            // return Container(
                            //   margin: const EdgeInsets.all(8),
                            //   padding: const EdgeInsets.all(8),
                            //   height: size.height * .15,
                            //   decoration: BoxDecoration(
                            //       color: Colors.white,
                            //       borderRadius: BorderRadius.circular(8),
                            //       boxShadow: const [
                            //         BoxShadow(
                            //             color: Colors.black26,
                            //             blurRadius: 30,
                            //             spreadRadius: 2)
                            //       ]),
                            //   child:
                            //       Text("${issuehistory![index]['memberName']}"),
                            // );
                          },
                        ),
                      )
                    : const Text(
                        "No issue history found",
                        style: kcardtext,
                      )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
