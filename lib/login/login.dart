import 'package:flutter/material.dart';
import 'package:responsi_praktpm/main.dart';
import 'package:responsi_praktpm/screens/splash_screen.dart';


class LoginPage extends StatefulWidget{

  LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String username = "";
  String password = "";
  bool isLoginSuccess = true;


  @override
  Widget build(BuildContext context){
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blueGrey,
          title: Text("Login Page"),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              _showImage(),
              _usernameField(),
              _passwordField(),
              _loginButton(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _usernameField() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: TextFormField(
        enabled: true,
        onChanged: (value){
          username = value;
        },
        decoration: InputDecoration(
            hintText: 'Username',
            contentPadding: const EdgeInsets.all(8.0),
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(8.0)),
              borderSide: BorderSide(color: Colors.deepPurple),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(8.0)),
              borderSide: BorderSide(color: (isLoginSuccess) ? Colors.deepPurple : Colors.red),
            )
        ),
      ),
    );
  }

  Widget _passwordField() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: TextFormField(
        enabled: true,
        onChanged: (value){
          password = value;
        },
        obscureText: true,
        decoration: InputDecoration(
            hintText: 'Password',
            contentPadding: const EdgeInsets.all(8.0),
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(8.0)),
              borderSide: BorderSide(color: Colors.deepPurple),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(8.0)),
              borderSide: BorderSide(color: (isLoginSuccess) ? Colors.deepPurple : Colors.red),
            )
        ),
      ),
    );
  }

  Widget _loginButton(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      width: MediaQuery.of(context).size.width,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: (isLoginSuccess) ? Colors.grey : Colors.red,
          onPrimary: Colors.white,
        ),

        onPressed: () async {
          String text = "tpmmenyenangkan";
          if(password == "yangbener"){
            setState(() {
              text = "Login Success";
              isLoginSuccess = true;
            });
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SplashScreen()),
            );
          }else{
            setState(() {
              text = "Login Failed";
              isLoginSuccess = false;
            });
          }

          SnackBar snackBar = SnackBar(
              content: Text(text)
          );

          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        },
        child: const Text('Login'),
      ),
    );
  }

  Widget _showImage() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 30),
      child:  Container(
        width: 170,
        height: 170,
        margin: EdgeInsets.only(bottom: 50),
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/logo.png')
            )
        ),
      ),

    );
  }
}