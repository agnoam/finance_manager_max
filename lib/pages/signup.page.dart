import 'package:flutter/material.dart';
import 'package:finance_manager/widgets/constants.widgets.dart';

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  String _firstname = '';
  String _lastname = '';
  String _username = ''; //-
  String _email = ''; //-
  String _password = ''; //-
  String _city = '';
  String _country = '';
  String _pinCode = '';
  String _postalCode = '';
  String _addressLine = '';
  
  //function for two inputs in one row

    Widget _buildTwoInOne(String title, List<String> hint, List<String>data) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          title,
          style: kLabelStyle,
        ),
        SizedBox(height:10.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[ 
            Container(
              alignment: Alignment.centerLeft,
              decoration: kBoxDecorationStyle,
              height: 60.0,
              width: 160,
              child: TextFormField(
                onChanged: (String value){
                  setState(() => data[0] = value);
                },
                keyboardType: TextInputType.text,
                style: TextStyle(color:Colors.black, fontFamily: 'Arial'),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(vertical: 14.0, horizontal: 14.0),
                  hintText: '${hint[0]}...',
                  hintStyle: kHintTextStyle,
                ),
              ),
            ),
            Container(
              alignment: Alignment.centerLeft,
              decoration: kBoxDecorationStyle,
              height: 60.0,
              width: 160,
              child: TextFormField(
                onChanged: (String value){
                  setState(() => data[1] = value);
                },
                keyboardType: TextInputType.text,
                style: TextStyle(color:Colors.black, fontFamily: 'Arial'),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(vertical: 14.0, horizontal: 14.0),
                  hintText: '${hint[1]}...',
                  hintStyle: kHintTextStyle,
                ),
              ),
            ),
          ]
        ),
      ],
    );
  }


  // function for the label and input of User
  Widget _buildPlain(String title, String vari, String hint) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          title,
          style: kLabelStyle,
        ),
        SizedBox(height:10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextFormField(
            onChanged: (String value){
              setState(() => vari = value);
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
              hintText: 'Enter ${hint}...',
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
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
              child: ListView(
                children: <Widget>[
                  SizedBox(height: 20.0,),
                  _buildTwoInOne('Full Name', ['First name', 'Last name'], [_firstname, _lastname]),
                  SizedBox(height: 20.0,),
                  _buildPlain('Username', _username, 'Username'),
                  SizedBox(height: 20.0,),
                  _buildPlain('Email', _email, 'Email'),
                  SizedBox(height: 20.0),
                  _buildPassword(),
                  SizedBox(height: 20.0),
                  _buildTwoInOne('Location', ['Enter City...', 'Enter Country...'], [_city, _country]),
                  SizedBox(height:20.0),
                  _buildTwoInOne('Location', ['Pin Code...', 'Postal Code...'], [_pinCode, _postalCode]),
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
                          onPressed: ()=>null,
                          // onPressed: () async {
                          //   if(_username.length > 0 && _password.length > 0 && _email.length > 0 && _fname.length > 0) {
                          //     NewUserCred signedUpUser = await HttpServices.signup(
                          //       userCred: NewUserCred(NewUserData(
                          //         password: _password, pinCode: _pinCode
                          //       ), NewUserInfo(
                          //         addressLine: _addressLine,
                          //         email: _email,
                          //         city: _city,
                          //         country: _country,
                          //         postalCode: _postalCode,
                          //         firstname: _firstname,
                          //         lastname: _lastname
                          //       ))
                          //     );
                              
                          //     signedUpUser != null ? 
                          //       Dialogs.showAlert(context, signedUpUser.toString(), title: 'User Data')
                          //     : 
                          //       Dialogs.showAlert(context, 'There is no data to show');
                          //   }
                          // },
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