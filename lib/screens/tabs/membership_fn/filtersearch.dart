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
              _isSearch = false;
              _searchText = "";
            },
          );
        } else {
          setState(
            () {
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
      body: Background(
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
                      if (snapshot.connectionState == ConnectionState.waiting) {
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
                              ? _searchListView()
                              : expireActivetoggler(snapshot, togglevalue);
                    },
                  ),
                )
              ],
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
              return MemberlistCard(index, _socialListItems);
              // return _socialListItems[index]['isVerified']
              //     ? MemberlistCard(index, _socialListItems)
              //     : Container(); //Uncomment this code to display verified members only
            })
        : const Center(
            child: Text("No Expired Members Found"),
          );
  }

  GestureDetector MemberlistCard(int index, List<dynamic> _socialListItems) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (ctx) => MemberDetails(
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

  Widget _searchListView() {
    _searchListItems = [];
    for (int i = 0; i < _socialListItems.length; i++) {
      var item = _socialListItems[i];
      //if (item['isVerified']) {
      if (item['name'].toLowerCase().contains(_searchText.toLowerCase())) {
        _searchListItems.add(item);
      }
      // }
    }
    return _listView(_searchListItems);
  }

  Widget expireActivetoggler(AsyncSnapshot<dynamic> snapshot, bool mode) {
    List filteredList = [];
    print(mode);
    if (mode) {
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
