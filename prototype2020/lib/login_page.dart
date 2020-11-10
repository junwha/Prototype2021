import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.blueGrey[800],
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/login_background.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        padding: EdgeInsets.fromLTRB(50, 80, 50, 100),
        child: Container(
          color: Colors.white.withOpacity(0.5),
          padding: EdgeInsets.all(20),
          child: Column(
            children: <Widget>[
              SizedBox(height: 10),
              Image(
                image: AssetImage("images/logo.jpg"),
                width: 150,
                height: 150,
              ),
              SizedBox(height: 20),
              Text(
                "Trip Builder",
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
              Form(
                key: _formKey,
                //https://flutter.dev/docs/cookbook/forms/validation : Documentation which is needed when build login form with back-end
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 20),
                    TextFormField(
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: EdgeInsets.all(1.0),
                        hintText: "I.d",
                        border: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.white, width: 2.0),
                          borderRadius: BorderRadius.circular(50),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.white, width: 2.0),
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: EdgeInsets.all(1.0),
                        hintText: "password",
                        border: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.white, width: 2.0),
                          borderRadius: BorderRadius.circular(50),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.white, width: 2.0),
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                      obscureText: true,
                    ),
                    SizedBox(height: 10),
                    SizedBox(
                      width: double.maxFinite,
                      height: 50,
                      child: RaisedButton(
                        onPressed: () {},
                        child: Text(
                          "Log-in",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.normal),
                        ),
                        color: Colors.teal[400],
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: <Widget>[
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      '신규 회원가입',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      'ID/비밀번호 찾기',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
