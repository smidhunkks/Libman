import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:libman/constants.dart';
import 'package:libman/screens/Welcome/welcome.dart';
import 'package:libman/screens/drawer/memberapproval.dart';
import 'package:libman/services/authservice.dart';
import 'package:provider/provider.dart';

import 'package:libman/screens/tabs/inventory.dart';
import 'package:libman/screens/tabs/membership.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({
    Key? key,
    /*this.email*/
  }) : super(key: key);

  //final String? email;

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int _selectedIndex = 0;

  static const List<Widget> _pages = <Widget>[
    Inventory(),
    Membership(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final authservice = Provider.of<Authservice>(context);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: kprimarycolor,
        actions: [
          IconButton(
              iconSize: 30,
              onPressed: () async {
                await authservice.Signout();
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (ctx) => const WelcomeScreen()));
              },
              icon: const Icon(
                Icons.power_settings_new_outlined,
                color: Colors.white,
              ))
        ],
      ),
      drawer: Drawer(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 8),
              width: double.infinity,
              height: size.height * .18,
              color: kprimarycolor,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 30,
                    child: Icon(Icons.person),
                  ),
                  Text(
                    "${FirebaseAuth.instance.currentUser!.email}",
                    style: kcardtext.copyWith(
                        color: Colors.white, fontWeight: FontWeight.w500),
                  )
                ],
              ),
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.only(left: 8),
                //color: Colors.amber,
                child: ListView(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => const ApprovalList(),
                          ),
                        );
                      },
                      child: const Text("Membership Approval"),
                    ),
                    const Divider(
                      color: Colors.black54,
                      endIndent: 20,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: const Text("Library Stats"),
                    ),
                    const Divider(
                      color: Colors.black54,
                      endIndent: 20,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: const Text("Support"),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
      body: Container(
        width: double.infinity,
        color: kprimarycolor,
        padding: const EdgeInsets.only(top: 9),
        child: Container(
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20))),
          child: Center(
            child: _pages[_selectedIndex],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        // selectedFontSize: 15,
        selectedIconTheme: const IconThemeData(color: kprimarycolor, size: 30),
        selectedItemColor: kprimarycolor,

        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.inventory_2),
            label: 'Inventory',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.group_add),
            label: 'Membership',
          ),
        ],

        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
