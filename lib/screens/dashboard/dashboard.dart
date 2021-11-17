import 'package:flutter/material.dart';
import 'package:libman/Components/background.dart';
import 'package:libman/constants.dart';
import 'package:libman/screens/Welcome/welcome.dart';
import 'package:libman/screens/auth/authservice.dart';
import 'package:provider/provider.dart';
import 'package:libman/constants.dart';
import 'package:libman/screens/tabs/inventory.dart';
import 'package:libman/screens/tabs/membership.dart';

class Dashboard extends StatefulWidget {
  Dashboard({Key? key}) : super(key: key);

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

    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
            onTap: () async {
              await authservice.Signout();
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (ctx) => WelcomeScreen()));
            },
            child: Icon(Icons.logout_outlined)),
      ),
      body: Center(
        child: _pages.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        // selectedFontSize: 15,
        selectedIconTheme: IconThemeData(color: kprimarycolor, size: 30),
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
