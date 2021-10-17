import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:libman/screens/auth/login.dart';

// void main()=> runApp(MaterialApp(home:Homepage(),));

// class Homepage extends StatefulWidget {
  
//   @override
//   _HomepageState createState() => _HomepageState();
// }

// class _HomepageState extends State<Homepage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar:AppBar(
//         backgroundColor:Colors.blue,
//         title: Text('Sign In Page'),
//       ),

//     );
//   }
// }

void main()=> runApp(MyApp());

class MyApp extends StatelessWidget {
 
  @override
  Widget build(BuildContext context) {
    final _init = Firebase.initializeApp();
    return FutureBuilder(
      future: _init,
      builder:(BuildContext context, AsyncSnapshot snapshot){
        if(snapshot.hasError){
          return ErrorWidget();
        }else if(snapshot.hasData){
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            home: Login(),
          );
        }else{
          return Loading();
        }
      },

    );
  }
}

class ErrorWidget extends StatelessWidget {
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children:[
            Icon(Icons.error),
            Text("Something went Wrong")
          ],
        ),
      )
    );
  }
}

class Loading extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Center(
        child: CircularProgressIndicator(),

      ),
    );
  }
}