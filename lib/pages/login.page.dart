import 'package:flutter/material.dart';
import 'package:finance_manager/services/http.services.dart';
import 'package:finance_manager/widgets/appCard.widgets.dart';

class LoginPage extends StatefulWidget {
  LoginPage({ Key key }): super(key: key);
  
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String _username = '';
  String _password = '';
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            AppCard(
              child: Center(
                child: Text(
                  'Login Now', 
                  style: TextStyle(fontSize: 32.0),
                  textAlign: TextAlign.center
                )
              )
            ),
            AppCard(
              child: Container(
                margin: EdgeInsets.only(top: 20.0),
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      decoration: InputDecoration(labelText: "Username"),
                      onChanged: (String value) {
                        setState(() => _username = value);
                      }
                    ),
                    TextFormField(
                      decoration: InputDecoration(labelText: "Password"),
                      onChanged: (String password) {
                        setState(() {
                          _password = password;
                        });
                      }
                    ),
                    Container(
                      width: double.infinity,
                      margin: EdgeInsets.only(top: 20.0),
                      child: FlatButton(
                        padding: EdgeInsets.all(20.0),
                        color: Colors.blue,
                        textColor: Colors.white,
                        child: Text("Login"),
                        onPressed: () async {
                          if(_username.length > 0 && _password.length > 0) {
                            bool isLogined =  await HttpServices.login(user: User(_username, _password));
                            print(isLogined ? 'Yay !' : 'Boozzz !');
                          }
                        }
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      child: FlatButton(
                        child: Text("Forgot Password"),
                        onPressed: () {}
                      )
                    )
                  ]
                )
              )
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                GestureDetector(
                  child: Container(
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width - 50,
                    height: 50,
                    color: Colors.blue,
                    child: Text("Signup", style: TextStyle(color: Colors.white))
                  ),
                  onTap: () {
                    
                  }
                )
              ]
            )
          ]
        )
      )
    );
  }
}