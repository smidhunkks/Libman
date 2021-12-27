import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:libman/Components/background.dart';
import 'package:libman/constants.dart';

class Issuedetails extends StatelessWidget {
  final String? memId;
  final String? bookId;
  final String? bookname;
  final String? issuedate;
  final String? duedate;
  final Widget? status;
  final String? memname;
  const Issuedetails(
      {Key? key,
      this.memId,
      this.bookId,
      this.bookname,
      this.issuedate,
      this.duedate,
      this.status,
      this.memname})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Background(
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Issue details",
                style: kscreentitle.copyWith(color: Colors.grey),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                "Book Id : $bookId ",
                style: kcardtext.copyWith(fontSize: 20),
              ),
              Text(
                "Book Name : $bookname ",
                style: kcardtext.copyWith(
                    fontSize: 23, fontWeight: FontWeight.w500),
              ),
              status ?? status!,
              const SizedBox(
                height: 10,
              ),
              const Divider(
                color: Colors.black87,
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                "Member Id : $memId",
                style: kcardtext.copyWith(fontSize: 18),
              ),
              Text(
                "Member Name : $memname",
                style: kcardtext.copyWith(fontSize: 18),
              ),
              const SizedBox(
                height: 10,
              ),
              const Divider(
                color: Colors.black,
              ),
              Text(
                "Issue Date : $issuedate ",
                style: kcardtext.copyWith(fontSize: 18),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                "Due Date : $duedate ",
                style: kcardtext.copyWith(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Colors.redAccent),
              ),
              const SizedBox(
                height: 10,
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  //color: kprimarycolor,
                  border: Border.all(width: 2, color: kprimarycolor),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: TextButton(
                  onPressed: () {},
                  child: Text(
                    "Renew",
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
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: kprimarycolor,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: TextButton(
                  onPressed: () {},
                  child: Text(
                    "Return",
                    style: kcardtext.copyWith(
                      color: Colors.white,
                      fontSize: 17,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
