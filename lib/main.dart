import 'package:flutter/material.dart';
import 'package:libman/services/authservice.dart';
import 'package:libman/screens/auth/wrapper.dart';

import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    const MyApp(),
  );
}

// class MyApp extends StatelessWidget {
//   final _init = Firebase.initializeApp();
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder(
//       future: _init,
//       builder: (BuildContext context, AsyncSnapshot snapshot) {
//         if (snapshot.hasError) {
//           return ErrorWidget();
//         } else if (snapshot.hasData) {
//           return WelcomeScreen();
//           // return Login();
//         } else {
//           return Loading();
//         }
//       },
//     );
//   }
// }
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [Provider<Authservice>(create: (_) => Authservice())],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SafeArea(
          child: Wrapper(),
        ),
      ),
    );
  }
}

class ErrorWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        children: const [Icon(Icons.error), Text("Something went Wrong")],
      ),
    ));
  }
}

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
