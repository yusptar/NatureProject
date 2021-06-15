import 'package:uas/pages/home_page.dart';
import 'package:uas/pages/register_page.dart';
import 'package:flutter/material.dart';
import 'package:uas/service/sign_in.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.fill,
              image:
                  NetworkImage('https://wallpapercave.com/wp/wp7168094.png')),
        ),
        //color: Colors.white,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Mountain & Waterfall',
                      style: TextStyle(color: Colors.white, fontSize: 30),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      'Database',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 35,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 28),
              _signInEmail(),
              _signInButton(),
              _registerButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _signInEmail() {
    return Container(
      width: 300,
      child: Column(
        children: [
          TextFormField(
            controller: emailController,
            decoration: InputDecoration(
              labelText: 'Enter Email Address',
              labelStyle: TextStyle(color: Colors.white, fontSize: 15),
              icon: Icon(Icons.email, color: Colors.white),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Colors.white),
              ),
            ),
          ),
          SizedBox(height: 20),
          TextFormField(
            obscureText: true,
            controller: passwordController,
            decoration: InputDecoration(
              labelText: 'Enter Password',
              labelStyle: TextStyle(color: Colors.white, fontSize: 15),
              icon: Icon(Icons.input, color: Colors.white),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Colors.white),
              ),
            ),
          ),
          SizedBox(height: 15),
          Container(
            margin: EdgeInsets.all(20),
            child: OutlineButton(
              splashColor: Colors.white,
              onPressed: () {
                signInWithEmail(emailController.text, passwordController.text)
                    .then((result) {
                  if (result != null) {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) {
                          return HomePage();
                        },
                      ),
                    );
                  }
                });
              },
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40)),
              highlightElevation: 0,
              borderSide: BorderSide(color: Colors.white),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: Text(
                        'Log in ',
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.white,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _signInButton() {
    return OutlineButton(
      splashColor: Colors.black,
      onPressed: () {
        signInWithGoogle().then((result) {
          if (result != null) {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) {
                  return HomePage();
                },
              ),
            );
          }
        });
      },
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
      highlightElevation: 0,
      borderSide: BorderSide(color: Colors.white, style: BorderStyle.solid),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            /*Image(
                image: NetworkImage(
                    'https://www.freepnglogos.com/uploads/google-logo-png/google-logo-icon-png-transparent-background-osteopathy-16.png'),
                height: 35.0),*/
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                'Sign in with Google ',
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.white,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _registerButton() {
    return FlatButton(
      child: Text(
        "Don't have an account? Sign up here",
        style: TextStyle(color: Colors.white, fontSize: 10),
      ),
      onPressed: () async {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => RegisterPage()));
      },
    );
  }
}
