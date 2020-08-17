import 'package:finance_manager/pages/cards.page.dart';
import 'package:finance_manager/utils/constants.dart';
import 'package:finance_manager/widgets/onoff_button.widgets.dart';
import 'package:flutter/material.dart';
import 'package:finance_manager/utils/flutter_ui_utils.dart';
import 'package:finance_manager/widgets/creditcard.widgets.dart';

import 'calc.page.dart';


class CardInfo extends StatefulWidget {
final String cardNumber;
final String expiryDate;
final String cardHolderName;
final String cvvCode;

  const CardInfo({Key key, this.cardNumber='4448 3551 7873 1819', this.expiryDate='03/23',
  this.cardHolderName='Yehuda Daniel', this.cvvCode='343',}) : super(key: key);

  @override
  _CardInfoState createState() => _CardInfoState();
}

class _CardInfoState extends State<CardInfo> {
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
                  cardNumber: widget.cardNumber, 
                  expiryDate: widget.expiryDate, 
                  cardHolderName: widget.cardHolderName, 
                  cvvCode: widget.cvvCode,
                  height: MediaQuery.of(context).size.height * 0.30,
                  width: MediaQuery.of(context).size.width * 8,
                  bgColor: HexColor('#ff6a64')
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
                  SizedBox(
                    width: double.infinity,
                    child: FlatButton.icon(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (BuildContext context) => Calc())
                        );
                      },
                      icon: Icon(Icons.account_balance_wallet),
                      color: Colors.grey.withOpacity(0.1),
                      label: Padding(
                        padding: EdgeInsets.symmetric(
                          vertical:MediaQuery.of(context).size.height * 0.02
                          ),
                        child: Text(
                          'Recharge Card', 
                          style: TextStyle(
                            fontSize: 22
                          ),
                        ),
                      )
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02,),
                  SizedBox(
                    width: double.infinity,
                    child: FlatButton.icon(
                      onPressed: () {},
                      icon: Icon(Icons.account_balance_wallet),
                      color: Colors.grey.withOpacity(0.1),
                      label: Padding(
                        padding: EdgeInsets.symmetric(
                          vertical:MediaQuery.of(context).size.height * 0.02
                          ),
                        child: Text(
                          'Disable Card', 
                          style: TextStyle(
                            fontSize: 22
                          ),
                        ),
                      )
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02,),
                  SizedBox(
                    width: double.infinity,
                    child: FlatButton.icon(
                      onPressed: () {},
                      icon: Icon(Icons.account_balance_wallet),
                      color: Colors.grey.withOpacity(0.1),
                      label: Padding(
                        padding: EdgeInsets.symmetric(
                          vertical:MediaQuery.of(context).size.height * 0.02
                          ),
                        child: Text(
                          'Withraw From', 
                          style: TextStyle(
                            fontSize: 22
                          ),
                        ),
                      )
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02,),
                  SizedBox(
                    width: double.infinity,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children:<Widget>[
                        Text(
                          'Charge on Permission', 
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold
                          )
                        ), 
                        CrazySwitch()
                      ]
                    )
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