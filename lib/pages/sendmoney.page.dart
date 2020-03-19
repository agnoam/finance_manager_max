import 'package:flutter/material.dart';
import 'package:finance_manager/utils/flutter_ui_utils.dart';
import 'package:flutter/services.dart';

class SendMoney extends StatefulWidget {

  @override
  _SendMoneyState createState() => _SendMoneyState();
}

class _SendMoneyState extends State<SendMoney> {
  double _amount = 0;
  String _pinCode;
  String _destID;

  String _currentPIN = "";
  String _pinOne = "";
  String _pinTwo = "";
  String _pinThree = "";
  String _pinFour = "";

  FocusNode _first;
  FocusNode _sec;
  FocusNode _third;
  FocusNode _last;

  @override
  void initState() {
    super.initState();

    _first = FocusNode();
    _sec = FocusNode();
    _third = FocusNode();
    _last = FocusNode();
  }

  @override
  void dispose() {
    _first.dispose();
    _sec.dispose();
    _third.dispose();
    _last.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Container(
          color: HexColor('#5dcbc7'),
          child: Column(
            children: <Widget>[
              SizedBox(height: MediaQuery.of(context).size.height * 0.10),
              _buildPlain(
                label: 'How much?',
                onChange: (newVal) => setState(() => _destID = newVal)
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              _buildPlain(
                label: 'Who to?',
                onChange: (newVal) => setState(() => _destID = newVal)
              ),
              Container(
                alignment: Alignment(0, 0.5),
                padding: EdgeInsets.symmetric(horizontal: 16),
              ),
              Column(
                children: <Widget>[
                  Text(
                    'Security PIN', 
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.bold
                    )
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                  _buildPinRow(
                    focusNode1: _first,
                    onChange1: (String newVal) => setState(()  {
                      if(newVal.length == 1 && _currentPIN.length < 1) {
                        _pinOne = newVal;
                        _currentPIN += _pinOne;
                        print(_currentPIN);
                        _sec.requestFocus();
                      }
                    }),
                    focusNode2: _sec,
                    onChange2: (String newVal) => setState(()  {
                      if(_currentPIN.length == 1 && newVal.length == 1) {
                        _pinTwo = newVal;
                        _currentPIN += _pinTwo;
                        print(_currentPIN);

                        _third.requestFocus();
                      } else if(newVal.isEmpty) {
                        _first.requestFocus();
                      }
                    }),
                    focusNode3: _third,
                    onChange3: (String newVal) => setState(() { 
                      if(_currentPIN.length == 2 && newVal.length == 1) {
                        _pinThree = newVal;
                        _currentPIN += _pinThree;
                        print(_currentPIN);
                        
                        _last.requestFocus();
                      } else if(newVal.isEmpty) {
                        _sec.requestFocus();
                      }
                    }),
                    focusNode4: _last,
                    onChange4: (String newVal) => setState(() { 
                      if(_currentPIN.length == 3 && newVal.length == 1){
                        _pinFour = newVal;
                        _currentPIN += _pinFour;
                        print(_currentPIN);
                      } else if(newVal.isEmpty) {
                        _third.requestFocus();
                      }
                    })
                  )
                ]
              )
            ]
          )
        )
      )
    );
  }

  _buildPInput(Function change, FocusNode focusNode) {
    return Container(
      alignment: Alignment.center,
      height: 60,
      width: 60,
      child: TextField(
        focusNode: focusNode,
        inputFormatters:[LengthLimitingTextInputFormatter(1)],
        textInputAction: TextInputAction.next,
        onChanged: change,
        textAlign: TextAlign.center,
        cursorColor: HexColor('#ff6a64'),
        keyboardType: TextInputType.number,
        strutStyle: StrutStyle(fontSize: 30.0),
        style: TextStyle(color:Colors.black, fontSize: 30),
        decoration: InputDecoration(
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: HexColor('#ff6a64'))),
          focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: HexColor('#ff6a64')))
        )
        // obscureText: true,
      )
    );
  }

  // Function for PIN Code inputs
  Widget _buildPinRow({ 
    Function onChange1, FocusNode focusNode1, 
    Function onChange2, FocusNode focusNode2, 
    Function onChange3, FocusNode focusNode3,
    Function onChange4, FocusNode focusNode4
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            _buildPInput(onChange1, focusNode1),
            _buildPInput(onChange2, focusNode2),
            _buildPInput(onChange3, focusNode3),
            _buildPInput(onChange4, focusNode4)
          ]
        )
      ]
    );
  }

  // function for the label and input of a plain input
  Widget _buildPlain({ Function onChange, String label }) {
    double _storeWidth = MediaQuery.of(context).size.width;

    return Container(
      height: 80.0,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: _storeWidth * 0.05),
        child: TextField(
          style: TextStyle(fontSize: 30.0),
          cursorColor: HexColor('#ff6a64'),
          strutStyle: StrutStyle(fontSize: 30.0),
          decoration: InputDecoration(
            labelText: label,
            labelStyle: TextStyle(fontSize: 40.0, color: HexColor('#ff6a64')),
            contentPadding: EdgeInsets.only(top: -5),
            enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: HexColor('#ff6a64'))),
            focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: HexColor('#ff6a64')))
          ),
          onChanged: onChange,
        )
      )
    );
  }

  //clear one pin back function
  // _clearPin() {
  //   if(pinIndex == 0) {
  //     pinIndex = 0;
  //   } else if(pinIndex == 4) {
  //     _setPin(pinIndex, "");
  //     currentPin[pinIndex-1] = "";
  //     pinIndex--;
  //   }else {
  //     _setPin(pinIndex, "");
  //     currentPin[pinIndex-1] = "";
  //     pinIndex--;
  //   }
  // }
  //set the number on the input according to the index
  // _pinIndexSetup(String text) {
  //   if(pinIndex == 0){
  //     pinIndex = 1;
  //   }else if(pinIndex < 4) {
  //     pinIndex++;
  //   }
  //   _setPin(pinIndex, text);
  //   currentPin[pinIndex-1] = text;
  //   String strPin = "";
  //   currentPin.forEach((e) {
  //     strPin += e;
  //   });
  //   if(pinIndex == 4) {
  //     print(strPin);
  //   }

  // }

//   _setPin(int n, String text) {
//     switch(n) {
//       case 1:
//         pinOneController.text = text;
//       break;
//       case 2:
//         pinTwoController.text = text;
//       break;
//       case 3:
//         pinThreeController.text = text;
//       break;
//       case 4:
//         pinFourController.text = text;
//       break;
//     }
//   }
}