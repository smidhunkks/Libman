import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:libman/Components/background.dart';

class IssueHistory extends StatelessWidget {
  const IssueHistory({Key? key, this.Id, this.activeIssue, this.issuehistory})
      : super(key: key);
  final String? Id;
  final Map? activeIssue;
  final List? issuehistory;
  @override
  Widget build(BuildContext context) {
    print(issuehistory);
    return Scaffold(
      body: Background(
        child: Center(
          child: Text("$Id"),
        ),
      ),
    );
  }
}
