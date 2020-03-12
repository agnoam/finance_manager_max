import 'package:flutter/material.dart';
import 'package:finance_manager/widgets/constants.widgets.dart';
import 'package:finance_manager/services/http.services.dart';
import 'package:finance_manager/utils/flutter_ui_utils.dart';

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  String _username = '';
  String _password = '';
  String _email = '';
  String _fname = '';
  // function for the label and input of User
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
            keyboardType: TextInputType.text,
            style: TextStyle(color:Colors.black, fontFamily: 'Arial'),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.account_circle,
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

  //function for the label and input of use full name
    Widget _buildFname() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Full Name',
          style: kLabelStyle,
        ),
        SizedBox(height:10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextFormField(
            keyboardType: TextInputType.text,
            style: TextStyle(color:Colors.black, fontFamily: 'Arial'),
            onChanged: (String value){
              setState(() => _fname = value);
            },
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              hintText: 'Enter Full Name...',
              hintStyle: kHintTextStyle,
              prefixIcon: Icon(
                Icons.person,
                color: Colors.black
              )
            )
          )
        )
      ],
    );
  }

  // function for the label and input of Email
  Widget _buildEmail() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Email',
          style: kLabelStyle,
        ),
        SizedBox(height:10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextFormField(
            keyboardType: TextInputType.text,
            style: TextStyle(color:Colors.black, fontFamily: 'Arial'),
            onChanged: (String value){
              setState(() => _email = value);
            },
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              hintText: 'Enter Email...',
              hintStyle: kHintTextStyle,
              prefixIcon: Icon(
                Icons.email,
                color: Colors.black
              )
            )
          )
        )
      ],
    );
  }

  // function for the label and input of Password
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

  // Widget buildSignup() {
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
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
                  _buildFname(),
                  SizedBox(height: 30.0,),
                  _buildUser(),
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
                          onPressed: (){
                            Navigator.pop(context);
                          },
                          child: Text('Back'),
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          
                        ),
                      ),
                      SizedBox(
                        child: RaisedButton(
                          child: Text('Done'),
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          onPressed: () async {
                            if(_username.length > 0 && _password.length > 0) {
                              User logginedUser = 
                              await HttpServices.login(cred: {
                                'name': _fname,
                                'email': _email,
                                'password': _password,
                                'username': _username, 
                                });
                              
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
}