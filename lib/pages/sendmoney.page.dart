import 'package:finance_manager/services/http.services.dart';
import 'package:finance_manager/widgets/animatedbutton.widgets.dart';
import 'package:flutter/material.dart';
import 'package:finance_manager/utils/flutter_ui_utils.dart';
import 'package:flutter/services.dart';

class SendMoney extends StatefulWidget {
  SendMoney({
    Key key,
  }) : super(key: key);

  @override
  _SendMoneyState createState() => _SendMoneyState();
}

class _SendMoneyState extends State<SendMoney> {
  double _amount = 0;
  String _destID;
  bool setanim = false;

  String _currentPIN = "";
  String _pinOne = "";
  String _pinTwo = "";
  String _pinThree = "";
  String _pinFour = "";

  FocusNode _first;
  FocusNode _sec;
  FocusNode _third;
  FocusNode _last;

  final TextEditingController _passwordController = TextEditingController();

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

  _passwordController.dispose();

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
                onChange: (newVal) => setState(() => _amount = double.parse(newVal)),
                typeis: TextInputType.number
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              _buildPlain(
                label: 'Who to?',
                onChange: (newVal) => setState(() => _destID = newVal),
                typeis: TextInputType.text
              ),
              Container(
                alignment: Alignment(0, 0.5),
                padding: EdgeInsets.symmetric(horizontal: 16),
              ),
              Column(
                children: <Widget>[
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                  Text(
                    'Security PIN', 
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.bold
                    )
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),
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
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.15),
                  RaisedButton(
                    color: HexColor('#ff6a64'),
                    onPressed: () async {
                      bool transfered = await HttpServices.transferMoney(_destID, _amount, _currentPIN);
                      if(transfered) {
                        Dialogs.showAlert(
                          context, 
                          'Money Transfered successfuly', 
                          onResolve: () => Navigator.of(context).pop()
                        );
                      } else {
                        Dialogs.showAlert(
                          context, 
                          'Money transfer failed', 
                          onResolve: () => Navigator.of(context).pop()
                        );
                      }
                    },
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal:MediaQuery.of(context).size.width * 0.3,
                        vertical:MediaQuery.of(context).size.height * 0.01
                        ),
                      child: Text(
                        'Send', 
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 30
                        )
                      ),
                    )
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                  AnimatedButton(
                    onTap: () async {
                      // bool transfered = await HttpServices.transferMoney(_destID, _amount, _currentPIN);
                      // if(_destID.length > 0 && _amount.toString().length > 0 && _currentPIN.length > 0) {
                      //   if(transfered) {
                      //     Dialogs.showAlert(
                      //       context, 
                      //       'Money Transfered successfuly', 
                      //       onResolve: () => Navigator.of(context).pop()
                      //     );
                      //   } else {
                      //     Dialogs.showAlert(
                      //       context, 
                      //       'Money transfer failed', 
                      //       onResolve: () => Navigator.of(context).pop()
                      //     );
                      //   }
                      // }
                    },
                    animationDuration: Duration(milliseconds: 2000),
                    initialText: "Done",
                    finalText: "Sent!",
                    iconData: Icons.check,
                    iconSize: 32.0,
                    buttonStyle: ButtonStyle(
                      primaryColor: HexColor('#ff6a64'),
                      secondaryColor: Colors.white,
                      elevation: 5,
                      initialTextStyle: TextStyle(
                        fontSize: 22.0,
                        color: Colors.white,
                      ),
                      finalTextStyle: TextStyle(
                        fontSize: 22.0,
                        color: HexColor('#ff6a64'),
                      ),
                      borderRadius: 10.0,
                    ),
                  ),
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
        ),
        obscureText: true
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
  Widget _buildPlain({ Function onChange, String label, TextInputType typeis, }) {
    double _storeWidth = MediaQuery.of(context).size.width;

    return Container(
      height: 80.0,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: _storeWidth * 0.05),
        child: TextField(
          keyboardType: typeis,
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
}