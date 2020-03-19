import 'package:email_validator/email_validator.dart';
import 'package:finance_manager/pages/home.page.dart';
import 'package:finance_manager/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:finance_manager/utils/flutter_ui_utils.dart';
import 'package:finance_manager/services/http.services.dart';
import 'package:finance_manager/widgets/constants.widgets.dart';
import 'package:finance_manager/pages/signup.page.dart';

class LoginPage extends StatefulWidget {
  LoginPage({ Key key }) : super(key: key);
  
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String _email = '';
  String _password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.cyan[400],
      body: Container(
        decoration: BoxDecoration(
          gradient: RadialGradient(
            radius: 0.5,
            colors: [Colors.white24, Colors.cyan]
          )
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              flex: 3,
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 20.0, horizontal:30.0),
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    'KidiCard', 
                    style:TextStyle(
                      color:Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 40.0,
                    )
                  )
                )
              )
            ),
            Expanded(
              flex: 9,
              child: Center(
                child: Transform.rotate(
                  angle: -30 * 3.141 / 180,
                  child: Icon(
                    Icons.credit_card,
                    color: Colors.white,
                    size: 240.0
                  )
                )
              )
            ),
            Expanded(
              flex: 1,
              child: GestureDetector(
                child: Container(
                  color: Colors.white,
                  padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 5.0),
                  child: Align(
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(right: 10),
                          child: Icon(Icons.keyboard_arrow_up, color: Colors.black)
                        ),
                        Text(
                          'Login', 
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.w800
                          )
                        )
                      ]
                    )
                  )
                ),
                onTap: () => _loginModal(context),
                onVerticalDragStart: (details) => _loginModal(context)
              )
            )
          ]
        )
      )
    );
  }

  // The login modal function
  void _loginModal(BuildContext context) {
    // Reset the form
    setState(() {
      _email = '';
      _password = '';
    });

    showModalBottomSheet(
      context: context, 
      isScrollControlled: true, 
      builder: (BuildContext context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.7,
          child: _buildLogin()
        );
      }
    );
  }

  Widget _buildEmail() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text('Email', style: kLabelStyle),
        SizedBox(height:10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextFormField(
            keyboardType: TextInputType.emailAddress,
            style: TextStyle(color:Colors.black, fontFamily: 'Arial'),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(Icons.email, color: Colors.black),
              hintText: 'Enter Email...',
              hintStyle: kHintTextStyle
            ),
            onChanged: (String value) => setState(() => _email = value)
          )
        )
      ]
    );
  }

  Widget _buildPassword(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text('Password', style: kLabelStyle),
        SizedBox(height:10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextFormField(
            obscureText: true,
            style: TextStyle(color:Colors.black, fontFamily: 'Arial'),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(Icons.lock, color: Colors.black),
              hintText: 'Enter Password...',
              hintStyle: kHintTextStyle
            ),
            onChanged: (String value) => setState(() => _password = value)
          )
        )
      ]
    );
  }

  Widget _buildLogin() {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.black,
      appBar: AppBar(
        leading: GestureDetector(
          child: Icon(
            Icons.keyboard_arrow_down,
            color: Colors.black
          ),
          onTap: () => Navigator.of(context).pop()
        ),
        backgroundColor: Colors.white,
        title: Image.asset(AssetsPaths.MaxLogo, width: 70)
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.cyan[400],
              Colors.cyan[400],
              Colors.cyan[200],
              Colors.cyan[200],
            ],
            stops: [0.1, 0.4, 0.5, 0.7]
          )
        ),
        child: ListView(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 40),
              child: Column(
                children: <Widget> [
                  SizedBox(height: 30.0),
                  _buildEmail(),
                  SizedBox(height: 30.0),
                  _buildPassword(),
                  SizedBox(height:20.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.3,
                        child: RaisedButton(
                          child: Text('Sign Up'),
                          color: Colors.white,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (BuildContext context) => SignupPage()
                              )
                            );
                          }
                        )
                      ),
                      SizedBox(
                        child: RaisedButton(
                          child: Icon(Icons.arrow_forward),
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          onPressed: (EmailValidator.validate(_email) && _password.length > 4) ?
                            () async {
                              try {
                                Dialogs.showLoadingSpinner(context);
                                bool isLoggedIn = await HttpServices.login(emailPass: { 
                                  'email': _email, 
                                  'password': _password 
                                });

                                if(isLoggedIn) { 
                                  Dialogs.hideLoadingSpinner(context);
                                  Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                      builder: (BuildContext context) => HomePage()
                                    )
                                  );
                                } else { 
                                  Dialogs.hideLoadingSpinner(context);
                                  Dialogs.showAlert(context, 'There is no data to show');
                                }
                              } catch(ex) {
                                print('login ex: $ex');
                              }
                            }
                          :
                            null
                        )
                      )
                    ]
                  )
                ]
              )
            )
          ]
        )
      )
    );
  }
}