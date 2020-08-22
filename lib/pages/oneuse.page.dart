import 'dart:math';
import 'package:flutter/material.dart';
import 'package:finance_manager/utils/flutter_ui_utils.dart';
import 'package:finance_manager/widgets/creditcard.widgets.dart';

class Oneuse extends StatefulWidget {

  @override
  _OneuseState createState() => _OneuseState();
}

class _OneuseState extends State<Oneuse> {
  String _cardNumber = '0000 0000 0000 0000';
  final random = Random();

  Widget page(BuildContext context) { 
    return Material(
      color: HexColor('#3399ff'),
      child: Column(
        children: <Widget>[ 
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[ 
                CreditCard(
                  cardNumber: _cardNumber, 
                  expiryDate: '03/26', 
                  cardHolderName: 'Kobi Miz', 
                  cvvCode: '397',
                  height: MediaQuery.of(context).size.height * 0.30,
                  width: MediaQuery.of(context).size.width * 8,
                  bgColor: HexColor('#5dcbc7'),
                  infoPage: true
                ),
              ]
            ),
          ),
          Expanded(
            child: Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.05),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[ 
                  SizedBox(height: 5),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: SizedBox(
                      child: Text(
                        'Get a One-time use credit card number for buying food or shopping online',
                        style: TextStyle(
                          fontSize: 22,
                          color: Colors.grey[350].withOpacity(0.7)
                        )
                      ),
                    ),
                  ),
                  SizedBox(height: 45),
                  SizedBox(
                    width: double.infinity,
                    child: FlatButton.icon(
                      onPressed: () {
                        setState(() {
                          _cardNumber = random.nextIntOfDigits(9).toString();
                          print(_cardNumber);
                        });
                      },
                      icon: Icon(Icons.account_balance_wallet, color: Colors.white,),
                      color: Colors.grey.withOpacity(0.1),
                      label: Padding(
                        padding: EdgeInsets.symmetric(
                          vertical:MediaQuery.of(context).size.height * 0.02
                          ),
                        child: Text(
                          'Get a One-time use number', 
                          style: TextStyle(
                            fontSize: 22,
                            color: Colors.white
                          ),
                        ),
                      )
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                  SizedBox(
                    child: Text(
                      _cardNumber,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        letterSpacing: 1
                      ),
                    ),
                  )
                ]
              ),
            ),
          )
        ]
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Colors.cyan,
      //   centerTitle: true,
      //   title: Row(
      //     children:<Widget>[
      //       Text('Cards'),
      //       IconButton(
      //         icon: Icon(Icons.settings),
      //         onPressed: (){}
      //       )
      //     ]
      //   ),
      //   leading: GestureDetector(
      //     child:Icon(Icons.arrow_back),
      //     onTap: () {
      //       Navigator.of(context).push(
      //         MaterialPageRoute(builder: (BuildContext context) => CardsPage())
      //       );
      //     }
      //   )
      // ),
      body: Container(
        child: page(context),
      )
    );
  }
}

extension RandomOfDigits on Random {
  /// Generates a non-negative random integer with a specified number of digits.
  ///
  /// Supports [digitCount] values between 1 and 9 inclusive.
  int nextIntOfDigits(int digitCount) {
    assert(1 <= digitCount && digitCount <= 9);
    int min = digitCount == 1 ? 0 : pow(10, digitCount - 1);
    int max = pow(10, digitCount);
    return min + nextInt(max - min);
  }
}