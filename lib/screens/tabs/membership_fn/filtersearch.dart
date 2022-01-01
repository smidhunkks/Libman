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

  bool _isSearch = true;
  String _searchText = "";

  List _socialListItems = [];
  List _searchListItems = [];

  @override
  void initState() {
    super.initState();

    _socialListItems = [];
    Future.delayed(Duration.zero, () async {
      final memfetch =
          await FirebaseFirestore.instance.collection('member').get();
      setState(() {
        _socialListItems = memfetch.docs.toList();
      });
    });

    _socialListItems.sort();
  }

  _HomeScreenState() {
    _searchEdit.addListener(
      () {
        if (_searchEdit.text.isEmpty) {
          setState(
            () {
              _isSearch = true;
              _searchText = "";
            },
          );
        } else {
          setState(
            () {
              _isSearch = false;
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
            margin: const EdgeInsets.only(left: 10.0, right: 10.0, top: 30.0),
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
                _searchBox(),
                const SizedBox(
                  height: 20,
                ),
                _isSearch ? _listView(_socialListItems) : _searchListView()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _searchBox() {
    return Container(
      //decoration: BoxDecoration(border: Border.all(width: 1.0)),
      child: TextFormField(
        controller: _searchEdit,
        decoration: const InputDecoration(
          prefixIcon: Icon(Icons.search),
          hintText: "Search",
          //hintStyle: new TextStyle(color: Colors.grey[300]),
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _listView(dynamic _socialListItems) {
    return Flexible(
      child: ListView.builder(
          itemCount: _socialListItems.length,
          itemBuilder: (BuildContext context, int index) {
            return MemberlistCard(index, _socialListItems);
          }),
    );
  }

  GestureDetector MemberlistCard(int index, List<dynamic> _socialListItems) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (ctx) => MemberDetails(
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

      if (item['name'].toLowerCase().contains(_searchText.toLowerCase())) {
        _searchListItems.add(item);
      }
    }
    return _listView(_searchListItems);
  }
}
