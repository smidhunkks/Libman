import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:libman/Components/background.dart';
import 'package:libman/constants.dart';
import 'package:libman/services/exportservice.dart';

class LibraryStats extends StatelessWidget {
  const LibraryStats({Key? key}) : super(key: key);

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
                "Library Stats",
                style: kscreentitle.copyWith(color: Colors.black45),
              ),
              Divider(color: Colors.black54),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: kprimarycolor,
                        borderRadius: BorderRadius.circular(8)),
                    child: TextButton(
                      onPressed: () async {
                        var memberSnapshot = await FirebaseFirestore.instance
                            .collection('member')
                            .get();
                        var memberList = memberSnapshot.docs.toList();
                        ExportService().createExcel('members.xlsx', memberList);
                      },
                      child: Row(
                        children: [
                          Icon(
                            Icons.download,
                            color: Colors.white,
                          ),
                          Text(
                            "Member List",
                            style: kcardtext.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: kprimarycolor,
                        borderRadius: BorderRadius.circular(8)),
                    child: TextButton(
                      onPressed: () async {
                        var bookSnapshot = await FirebaseFirestore.instance
                            .collection('books')
                            .get();

                        var bookList = bookSnapshot.docs.toList();
                        // bookList.first.data().forEach((key, value) { })
                        print(bookList.first.data());
                        ExportService().createExcel('books.xlsx', bookList);
                        //  print("Books List : $memberList");
                      },
                      child: Row(
                        children: [
                          Icon(
                            Icons.download,
                            color: Colors.white,
                          ),
                          Text(
                            "Book List",
                            style: kcardtext.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
