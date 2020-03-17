import 'package:finance_manager/pages/login.page.dart';
import 'package:finance_manager/services/http.services.dart';
import 'package:finance_manager/utils/constants.dart';
import 'package:finance_manager/utils/flutter_ui_utils.dart';
import 'package:flutter/material.dart';
import 'package:finance_manager/widgets/constants.widgets.dart';
import 'package:email_validator/email_validator.dart';

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  String _firstname = '';
  String _lastname = '';
  String _email = '';
  String _password = '';
  String _city = '';
  String _country = '';
  String _pinCode = '';
  String _postalCode = '';
  String _addressLine = '';
  String _repeat = '';
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Container(
          child: Image.asset(AssetsPaths.MaxLogo, width: 70.0, height:40.0)
        )
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
            )
          ),
          Container(
            height: double.infinity,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 40.0),
              child: ListView(
                children: <Widget>[
                  SizedBox(height: 20.0),
                  _buildTwoInOne(
                    title: 'Full Name', 
                    hint: ['First name','Last name'],
                    onChange1: (newVal) => setState(() => _firstname = newVal),
                    onChange2: (newVal) => setState(() => _lastname = newVal)
                  ),
                  SizedBox(height: 20.0,),
                  _buildPlain(
                    title: 'Email', 
                    hint: 'Enter Email..',
                    onChange: (newVal) => setState(() => _email = newVal)
                  ),
                  SizedBox(height: 20.0),
                  _buildPassword(),
                  SizedBox(height: 20.0),
                  _buildPlain(
                    title: 'Repeat', 
                    hint: 'Repeat password...',
                    onChange: (newVal) => setState(() => _repeat = newVal)
                  ),
                  SizedBox(height: 20.0),
                  _buildTwoInOne(
                    title: 'Location', 
                    hint: ['Enter City...','Enter Country...'],
                    onChange1: (newVal) => setState(() => _city = newVal),
                    onChange2: (newVal) => setState(() => _country = newVal)
                  ),
                  SizedBox(height:20.0),
                  _buildTwoInOne(
                    title: 'Location', 
                    hint: ['Pin Code...','Postal Code...'],
                    onChange1: (newVal) => setState(() => _pinCode = newVal),
                    onChange2: (newVal) => setState(() => _postalCode = newVal)
                  ),
                  SizedBox(height:20.0),
                  _buildPlain(
                    title: 'Address', 
                    hint: 'Enter Address..',
                    onChange: (newVal) => setState(() => _addressLine = newVal)
                  ),
                  SizedBox(height: 20.0,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.3,
                        child: RaisedButton(
                          child: Text('Back'),
                          color: Colors.white,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                          onPressed: () {
                            Navigator.pop(context);
                          }
                        )
                      ),
                      SizedBox(
                        child: RaisedButton(
                          child: Text('Done'),
                          color: Colors.white,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                          onPressed: () async {
                            Dialogs.showLoadingSpinner(context);
                            if(check()) {
                              NewUserCred user = await HttpServices.signup(
                                userCred: NewUserCred(
                                  NewUserData(password: _password, pinCode: _pinCode),
                                  NewUserInfo(
                                    firstname: _firstname,
                                    lastname: _lastname,
                                    email: _email,
                                    city: _city,
                                    country: _country,
                                    postalCode: _postalCode,
                                    addressLine: _addressLine
                                  )
                                )
                              );
                              Dialogs.hideLoadingSpinner(context);
                              Dialogs.showAlert(context, "fuck");
                              if(user == null) { 
                                Dialogs.hideLoadingSpinner(context);
                                Dialogs.showAlert(context, 'success');
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder:(BuildContext context) => LoginPage())
                                );
                              } else { 
                                Dialogs.hideLoadingSpinner(context);
                                Dialogs.showAlert(context, 'There is no data to show');
                              }
                            } else {
                              Dialogs.hideLoadingSpinner(context);
                              Dialogs.showAlert(context, "Please check again all fields");
                            }
                          }
                        )
                      )
                    ]
                  )
                ]
              )
            )
          )
        ]
      )
    );
  }

  //function for two inputs in one row
  Widget _buildTwoInOne({ String title, List<String> hint, Function onChange1, Function onChange2 }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(title, style: kLabelStyle),
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
                onChanged: onChange1,
                keyboardType: TextInputType.text,
                style: TextStyle(color:Colors.black, fontFamily: 'Arial'),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(vertical: 14.0, horizontal: 14.0),
                  hintText: '${hint[0]}...',
                  hintStyle: kHintTextStyle,
                )
              )
            ),
            Container(
              alignment: Alignment.centerLeft,
              decoration: kBoxDecorationStyle,
              height: 60.0,
              width: 160,
              child: TextFormField(
                onChanged: onChange2,
                keyboardType: TextInputType.text,
                style: TextStyle(color:Colors.black, fontFamily: 'Arial'),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(vertical: 14.0, horizontal: 14.0),
                  hintText: '${hint[1]}...',
                  hintStyle: kHintTextStyle,
                )
              )
            )
          ]
        )
      ]
    );
  }


  // function for the label and input of a plain input
  Widget _buildPlain({ String title, Function onChange, String hint }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(title, style: kLabelStyle),
        SizedBox(height:10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextFormField(
            onChanged: onChange,
            keyboardType: TextInputType.text,
            style: TextStyle(color:Colors.black, fontFamily: 'Arial'),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(Icons.account_circle, color: Colors.black),
              hintText: 'Enter $hint...',
              hintStyle: kHintTextStyle,
            )
          )
        )
      ]
    );
  }

  // function for the label and input of the Password
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
            onChanged: (String value){
              setState(() => _password = value);
            },
            obscureText: true,
            style: TextStyle(color:Colors.black, fontFamily: 'Arial'),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(Icons.lock, color: Colors.black),
              hintText: 'Enter Password...',
              hintStyle: kHintTextStyle,
            )
          )
        )
      ]
    );
  }
  //checks if all of the input's values are valid and return true if they are
  bool check() {
    bool res = true;
    if(_firstname.length < 2) {
      print('firstname is not valid');
      res = false;
    }
    if(_lastname.length < 2) {
      print('lastname is not valid');
      res = false;
    }
    if(!EmailValidator.validate(_email)) {
      print('email is not valid');
      res = false;
    }
    if(_password.length < 6  && _password != _repeat) {
      print('password is not valid');
      res = false;
    }
    if(_city.length < 3 ) {
      print('city is not valid');
      res = false;
    }
    if(_country.length < 3 ) {
      print('country is not valid');
      res = false;
    }
    if(_pinCode.length < 4 ) {
      print('pinCode is not valid');
      res = false;
    }
    if(_postalCode.length < 3 ) {
      print('postal code is not valid');
      res = false;
    }
    if(_addressLine.length < 4 ) {
      print('address line is not valid');
      res = false;
    }
    return res;
  }
  //-------------------------------------------

}