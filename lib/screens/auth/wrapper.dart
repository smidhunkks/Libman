import 'package:flutter/material.dart';
import 'package:libman/Components/model/user.dart';
import 'package:libman/screens/Welcome/welcome.dart';
import 'package:libman/services/authservice.dart';
import 'package:libman/screens/dashboard/dashboard.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authservice = Provider.of<Authservice>(context);

    return StreamBuilder<User?>(
      stream: authservice.user,
      builder: (_, AsyncSnapshot snapshot) {
        try {
          if (snapshot.connectionState == ConnectionState.active) {
            return snapshot.data == null
                ? WelcomeScreen()
                : Dashboard(
                    email: snapshot.data.email,
                  );
          } else {
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        } catch (e) {
          print(e);
          return Center(
            child: Text("error"),
          );
        }
      },
    );
  }
}
