import 'package:flutter/material.dart';
import 'package:libman/screens/Welcome/welcome.dart';
import 'package:libman/screens/auth/authservice.dart';
import 'package:provider/provider.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({Key? key}) : super(key: key);

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
      body: Container(
        child: Center(child: Text("Logged in.||Dashboard")),
      ),
    );
  }
}
