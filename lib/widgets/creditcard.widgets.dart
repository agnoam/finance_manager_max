import 'dart:ffi';

import 'package:finance_manager/pages/cardinfo.page.dart';
import 'package:finance_manager/utils/constants.dart';
import 'package:finance_manager/utils/flutter_ui_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';

class CreditCard extends StatefulWidget {
  const CreditCard({
    Key key,
    @required this.cardNumber,
    @required this.expiryDate,
    @required this.cardHolderName,
    @required this.cvvCode,
    this.height,
    this.width,
  })  :super(key: key);

  final String cardNumber;
  final String expiryDate;
  final String cardHolderName;
  final String cvvCode;
  final double height;
  final double width;

  @override
  _CreditCard createState() => _CreditCard();
}
class _CreditCard extends State<CreditCard>
{
        Widget _buildCard(String cardHolderName, String cardNumber,String expiryDate, String cvvCode, double height, double width){
    return Container(
      child: Stack(
        children: <Widget> [
          Container(
            alignment: Alignment.center,
            child: Stack(
              children: <Widget>[
                CreditCardWidget(
                  width: width ,height: height,
                  cardHolderName: cardHolderName,
                  cardNumber: cardNumber,
                  expiryDate: expiryDate, 
                  cvvCode: cvvCode,
                  textStyle:TextStyle(color: HexColor('#4F524D'),fontSize:20),
                  showBackView: false,
                  cardbgColor: HexColor('#5dcbc7'),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 25, left: 25), 
                  child: Image.asset(AssetsPaths.MaxLogo, scale: MediaQuery.of(context).size.width / 60)
                ),
                Padding(
                  padding: EdgeInsets.only(top: 130, left: 270), 
                  child: Image.asset(AssetsPaths.VisaLogo, scale: MediaQuery.of(context).size.width / 30)
                ),
                Padding(
                  padding: EdgeInsets.only(top: 25, left: 320), 
                  child: InkWell(
                    child: Icon(
                      Icons.info_outline, 
                      color: Colors.black, 
                      size: 30.0
                    ),
                    onTap: () {
                     Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => CardInfo()));
                    },
                  ),
                )
              ]
            )
          )
        ]
      )
    );
  }
  @override
  Widget build(BuildContext context) {

    return _buildCard(this.widget.cardHolderName,this.widget.cardNumber,this.widget.expiryDate,this.widget.cvvCode,this.widget.height,this.widget.width);

}
}