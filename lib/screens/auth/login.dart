import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController email = new TextEditingController() ;
  TextEditingController password = new TextEditingController();



  @override
  void initState() {
    email = TextEditingController();
    password = TextEditingController();
    super.initState();
    
  }

  @override
  void dispose(){
    email.dispose();
    password.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: 
          Column(
            children:[
              Text(
                "Welcome Back", style: TextStyle(
                  fontSize:22,
                  fontWeight: FontWeight.bold,
                 ),
              ),
               SizedBox(height:20),
               Text(
                "Sign in to continue", style: TextStyle(
                  fontSize:14,
                  ),
              ),
            ], 
         
      ),
    
  ),
    );
}
}