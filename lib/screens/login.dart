import 'package:flutter/material.dart';

import 'package:hexcolor/hexcolor.dart';

import 'package:provider/provider.dart';
import '../providers/User.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LogInScreen extends StatelessWidget {
  static const spinkit = SpinKitRotatingCircle(
    color: Colors.white,
    size: 50.0,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Stack(children: [
            Container(
              height: MediaQuery.of(context).size.height,
              child: Image.asset(
                "images/logInoffice.jpg",
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 200, left: 200),
              child: Image.asset(
                "images/Logo.png",
              ),
            ),
          ]),
          AuthCard()
        ],
      ),
    ));
  }
}

class AuthCard extends StatefulWidget {
  @override
  _AuthState createState() => _AuthState();
}

class _AuthState extends State<AuthCard> {
  final GlobalKey<FormState> _formKey = GlobalKey();

  Map<String, String> _authData = {
    'email': '',
    'password': '',
  };

  final _passwordController = TextEditingController();

  void _submit() {
    if (!_formKey.currentState.validate()) {
      return;
    }

    _formKey.currentState.save();

    Provider.of<User>(context, listen: false)
        .logIn(_authData['email'], _authData['password']);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Log In",
            style: TextStyle(
                fontSize: 50,
                color: HexColor("#222C4A"),
                fontWeight: FontWeight.bold),
          ),
          Text(
            "Welcome to RealTime,",
            style: TextStyle(
              fontSize: 20,
              color: Colors.grey,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 200),
            child: Container(
              width: 800,
              height: 400,
              child: Card(
                margin: EdgeInsets.only(top: 30, right: 20),
                elevation: 3,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                child: Container(
                  padding: EdgeInsets.all(50),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                            decoration: const InputDecoration(
                                icon: Icon(Icons.person), labelText: "Email"),
                            keyboardType: TextInputType.emailAddress,
                            onSaved: (value) {
                              _authData['email'] = value;
                            }),
                        TextFormField(
                          obscureText: true,
                          controller: _passwordController,
                          decoration: const InputDecoration(
                            icon: Icon(Icons.lock),
                            labelText: "Password",
                          ),
                          onSaved: (value) {
                            _authData['password'] = value;
                          },
                        ),
                        Container(
                          padding: EdgeInsets.all(50),
                          child: RaisedButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                                side: BorderSide(
                                    color: Color.fromRGBO(0, 160, 227, 1))),
                            onPressed: () {
                              _submit();
                            },
                            padding: EdgeInsets.all(10.0),
                            color: HexColor("#222C4A"),
                            textColor: Colors.white,
                            child:
                                Text("Log In", style: TextStyle(fontSize: 15)),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
