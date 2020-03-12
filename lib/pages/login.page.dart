import 'package:flutter/material.dart';
import 'package:finance_manager/utils/flutter_ui_utils.dart';
import 'package:finance_manager/services/http.services.dart';
import 'package:finance_manager/widgets/constants.widgets.dart';
import 'package:finance_manager/pages/signup.page.dart';

// Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => SignupPage()));

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String _username = '';
  String _password = '';

  //The login modal function

  void _loginModal(context) {
    showModalBottomSheet(context: context, isScrollControlled: true, builder: (BuildContext bc) {
      return Container(
        // height: MediaQuery.of(context).size.height * .8,
        child: _buildLogin(),
      );
    });
  }

  Widget _buildUser() {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'User',
            style: kLabelStyle,
          ),
          SizedBox(height:10.0),
          Container(
            alignment: Alignment.centerLeft,
            decoration: kBoxDecorationStyle,
            height: 60.0,
            child: TextFormField(
              onChanged: (String value){
                setState(() => _username = value);
              },
              keyboardType: TextInputType.emailAddress,
              style: TextStyle(color:Colors.black, fontFamily: 'Arial'),
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(top: 14.0),
                prefixIcon: Icon(
                  Icons.email,
                  color: Colors.black
                ),
                hintText: 'Enter User...',
                hintStyle: kHintTextStyle,
              ),
            ),
          ),
        ],
      );
  }

  Widget _buildPassword(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Password',
          style: kLabelStyle,
        ),
        SizedBox(height:10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextFormField(
            onChanged: (String value){
              setState(() => _password = value);
            },
            obscureText: true,
            style: TextStyle(color:Colors.black, fontFamily: 'Arial'),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.lock,
                color: Colors.black
              ),
              hintText: 'Enter Password...',
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLogin() {

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Container(child: Image.asset(
          'assets/images/max.png', width: 70.0, height:40.0)),
        backgroundColor: Colors.white,
      ),
      body: Stack(
          children: <Widget>[
              Container(
              height: double.infinity, 
              width: double.infinity, 
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
                  stops: [0.1, 0.4, 0.5, 0.7],
                )
              ),
              ),
              Container(
              height: double.infinity,
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 40.0,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: 30.0,),
                    _buildUser(),
                    SizedBox(height: 30.0),
                    _buildPassword(),
                    SizedBox(height:20.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.3,
                          child: RaisedButton(
                            onPressed: (){
                              Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => SignupPage()));
                            },
                            child: Text('Sign Up'),
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            
                          ),
                        ),
                        SizedBox(
                          child: RaisedButton(
                            child: Icon(Icons.arrow_forward),
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            onPressed: () async {
                              if(_username.length > 0 && _password.length > 0) {
                                User logginedUser = 
                                await HttpServices.login(cred: { 'username': _username, 'password': _password });
                                
                                logginedUser != null ? 
                                  Dialogs.showAlert(context, logginedUser.toString(), title: 'User Data')
                                : 
                                  Dialogs.showAlert(context, 'There is no data to show');
                              }
                            },
                          )
                        )
                      ],
                    ),
                  ]
                )
              )
            )
          ]
        )
    );
  }

@override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.cyan[400],
      body: Container(
        decoration: BoxDecoration(
          gradient: RadialGradient(
            radius: 0.5,
            colors: [
              Colors.white24,
              Colors.cyan,
            ],
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
                  child: Text('name', 
                    style:TextStyle(
                      color:Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 40.0,
                    )
                  ),
                ),
              ),
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
                    ),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: FlatButton(
                onPressed: () {
                  _loginModal(context);
                },
                color: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 5.0),
                child: Align(
                  alignment: Alignment.center,
                  child: Text('Login', 
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w800,
                    )
                  )
                )
              )
            )
          ]
        )
      )
    );
  }
}
