import 'package:finance_manager/pages/cards.page.dart';
import 'package:finance_manager/utils/constants.dart';
import 'package:finance_manager/widgets/onoff_button.widgets.dart';
import 'package:flutter/material.dart';
import 'package:finance_manager/utils/flutter_ui_utils.dart';
import 'package:finance_manager/widgets/creditcard.widgets.dart';

import 'calc.page.dart';


class CardRequest extends StatefulWidget {

  @override
  _CardRequestState createState() => _CardRequestState();
}

class _CardRequestState extends State<CardRequest> {
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
                  cardNumber: '1234 5678 9012 3456', 
                  expiryDate: '00/00', 
                  cardHolderName: 'NAME', 
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
                        'Active Cards: 3/5',
                        style: TextStyle(
                          fontSize: 22,
                          color: Colors.white
                        )
                      ),
                    ),
                  ),
                  SizedBox(height: 95),
                  SizedBox(
                    width: double.infinity,
                    child: FlatButton.icon(
                      onPressed: () {
                        // Navigator.of(context).push(
                        //   MaterialPageRoute(builder: (BuildContext context) => Calc())
                        // );
                      },
                      icon: Icon(Icons.account_balance_wallet, color: Colors.white),
                      color: Colors.grey.withOpacity(0.1),
                      label: Padding(
                        padding: EdgeInsets.symmetric(
                          vertical:MediaQuery.of(context).size.height * 0.02
                          ),
                        child: Text(
                          'Send request for new card', 
                          style: TextStyle(
                            fontSize: 22,
                            color: Colors.white
                          ),
                        ),
                      )
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02,),
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