import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:libman/Components/background.dart';
import 'package:libman/constants.dart';
import 'package:libman/screens/tabs/membership_fn/memberdetails.dart';

class FilterSearch extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<FilterSearch> {
  final _searchEdit = TextEditingController();
  bool togglevalue = false;
  bool _isSearch = false;
  String _searchText = "";

  List _socialListItems = [];
  List _searchListItems = [];

  // @override
  // void initState() {
  //   super.initState();

  //   _socialListItems = [];
  //   // Future.delayed(Duration.zero, () async {
  //   //   final memfetch =
  //   //       await FirebaseFirestore.instance.collection('member').get();
  //   //   setState(() {
  //   //     _socialListItems = memfetch.docs.toList();
  //   //   });
  //   // });

  //   _socialListItems.sort();
  // }

  _HomeScreenState() {
    _searchEdit.addListener(
      () {
        if (_searchEdit.text.isEmpty) {
          setState(
            () {
              //togglevalue = false;
              _isSearch = false;
              _searchText = "";
            },
          );
        } else {
          setState(
            () {
              //togglevalue = false;
              _isSearch = true;
              _searchText = _searchEdit.text;
            },
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);

          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
            setState(() {
              _isSearch = false;
            });
          }
        },
        child: Background(
          child: SafeArea(
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Member List",
                    style: kscreentitle.copyWith(color: Colors.grey),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Expanded(child: _searchBox()),
                      !togglevalue
                          ? Text("Active",
                              style: kcardtext.copyWith(fontSize: 15))
                          : Text("Expired",
                              style: kcardtext.copyWith(fontSize: 15)),
                      Switch(
                          value: togglevalue,
                          onChanged: (value) {
                            setState(() {
                              togglevalue = value;
                            });
                          }),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Expanded(
                    child: StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection('member')
                          .snapshots(),
                      builder: (context, AsyncSnapshot snapshot) {
                        if (snapshot.hasError) {
                          return const Text("Something Went Wrong");
                        }

                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Padding(
                            padding: EdgeInsets.all(40),
                            child: CircularProgressIndicator(),
                          );
                        }

                        return snapshot.data!.docs.length == 0
                            ? const Center(
                                child: Text(
                                "No Member found",
                                style: kcardtext,
                              ))
                            : _isSearch
                                ? _searchListView(snapshot)
                                : expireActivetoggler(snapshot);
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _searchBox() {
    return TextFormField(
      controller: _searchEdit,
      decoration: const InputDecoration(
        prefixIcon: Icon(Icons.search),
        hintText: "Search",
        //hintStyle: new TextStyle(color: Colors.grey[300]),
      ),
      textAlign: TextAlign.center,
    );
  }

  Widget _listView(dynamic _socialListItems) {
    return _socialListItems.length != 0
        ? ListView.builder(
            itemCount: _socialListItems.length,
            itemBuilder: (BuildContext context, int index) {
              // return MemberlistCard(index, _socialListItems);
              return _socialListItems[index]['isVerified']
                  ? MemberlistCard(index, _socialListItems)
                  : Container(); //Uncomment this code to display verified members only
            })
        : const Center(
            child: Text("No Members Found"),
          );
  }

  GestureDetector MemberlistCard(int index, List<dynamic> _socialListItems) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (ctx) => MemberDetails(
              deleteaction: IconButton(
                onPressed: () async {
                  return await showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text("Confirm Delete."),
                      content: const Text("Are you sure you want to Delete?"),
                      actions: [
                        ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text("Cancel")),
                        ElevatedButton(
                            onPressed: () async {
                              await FirebaseFirestore.instance
                                  .collection('member')
                                  .doc(_socialListItems[index].id)
                                  .delete()
                                  .then((value) => Navigator.of(context).pop())
                                  .then((value) => Navigator.of(context).pop());
                            },
                            child: const Text("Confirm")),
                      ],
                    ),
                  );

                  // final issuehistory = await FirebaseFirestore.instance
                  //     .collection('issue-history')
                  //     .where('bookId', isEqualTo: widget.Id)
                  //     .get();
                  // if (issuehistory.docs.isNotEmpty) {
                  //   Navigator.of(context).push(
                  //     MaterialPageRoute(
                  //       builder: (ctx) => IssueHistory(
                  //         Id: widget.Id,
                  //         activeIssue: status,
                  //         issuehistory: issuehistory.docs.toList(),
                  //         bookName: widget.bookName,
                  //       ),
                  //     ),
                  //   );
                  // } else {
                  //   final snackbar = SnackBar(
                  //     backgroundColor: Colors.redAccent,
                  //     content: const Text(
                  //       "No issue hsitory found",
                  //       style: TextStyle(color: Colors.white),
                  //     ),
                  //     action: SnackBarAction(
                  //       textColor: Colors.white,
                  //       label: 'dismiss',
                  //       onPressed: () {},
                  //     ),
                  //   );
                  //   ScaffoldMessenger.of(context).showSnackBar(snackbar);
                  // }
                },
                icon: const Icon(
                  Icons.delete,
                  size: 30,
                ),
                tooltip: "Delete",
              ),
              memberData: _socialListItems[index],
              action: togglevalue
                  ? Container(
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
                              .update({"lastrenew": DateTime.now()}).then(
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
                    )
                  : null,
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
              BoxShadow(color: Colors.black26, blurRadius: 30, spreadRadius: 2)
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
  }

  Widget _searchListView(AsyncSnapshot<dynamic> snapshot) {
    _searchListItems = [];
    for (var item in snapshot.data.docs) {
      //var item = _socialListItems[i];
      //if (item['isVerified']) {
      if (item['name'].toLowerCase().contains(_searchText.toLowerCase())) {
        _searchListItems.add(item);
      }
      // }
    }
    print("searchlist item : ${_searchListItems} searchtext $_searchText");
    return _listView(_searchListItems);
  }

  Widget expireActivetoggler(AsyncSnapshot<dynamic> snapshot) {
    List filteredList = [];

    if (togglevalue) {
      // print(mode);
      for (var snapitem in snapshot.data.docs) {
        if (DateTime.now().difference(snapitem["lastrenew"].toDate()).inDays >
            365) {
          filteredList.add(snapitem);
        }
      }
      print(filteredList);
      return _listView(filteredList);
    } else {
      for (var snapitem in snapshot.data.docs) {
        if (DateTime.now().difference(snapitem["lastrenew"].toDate()).inDays <=
            365) {
          filteredList.add(snapitem);
        }
      }
      print(filteredList);
      return _listView(filteredList);
    }
  }
}
