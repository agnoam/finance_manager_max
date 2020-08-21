import 'dart:ffi';

import 'package:finance_manager/pages/cardinfo.page.dart';
import 'package:finance_manager/utils/constants.dart';
import 'package:finance_manager/utils/flutter_ui_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';

class CreditCard extends StatefulWidget {
  const CreditCard({
    @required this.infoPage,
    @required this.cardNumber,
    @required this.expiryDate,
    @required this.cardHolderName,
    @required this.cvvCode,
    this.height,
    this.width,
    @required this.bgColor,
    this.key,
  })  :super(key: key);

  final Key key;
  final String cardNumber;
  final String expiryDate;
  final String cardHolderName;
  final String cvvCode;
  final double height;
  final double width;
  final Color bgColor;
  final bool infoPage;

  @override
  _CreditCard createState() => _CreditCard();
}
class _CreditCard extends State<CreditCard> {
  Widget _buildCard(
    String cardHolderName, 
    String cardNumber,
    String expiryDate, 
    String cvvCode, 
    double height, 
    double width,
    Color bgColor,
    bool infoPage
  ){
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
                  cardbgColor: bgColor,
                ),
                Padding(
                  padding: EdgeInsets.only(top: 25, left: 25), 
                  child: Image.asset(AssetsPaths.MaxLogo, scale: MediaQuery.of(context).size.width / 60)
                ),
                Positioned(
                  bottom: 25,
                  right: 25,
                  child: Image.asset(AssetsPaths.VisaLogo, scale: MediaQuery.of(context).size.width / 30)
                ),
                Positioned(
                  top: 25,
                  right: 25,
                  child: InkWell(
                    child: Icon(
                      Icons.info_outline, 
                      color: Colors.black, 
                      size: 30.0
                    ),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (BuildContext context) => CardInfo(expiryDate:expiryDate, cvvCode:cvvCode, cardNumber:cardNumber, cardHolderName:cardHolderName, cardColor:bgColor))
                      );
                    }
                  )
                )
              ]
            )
          )
        ]
      )
    );
  }
  Widget _buildCardNoInfoButton(
    String cardHolderName, 
    String cardNumber,
    String expiryDate, 
    String cvvCode, 
    double height, 
    double width,
    Color bgColor,
    bool infoPage
  ){
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
                  cardbgColor: bgColor,
                ),
                Padding(
                  padding: EdgeInsets.only(top: 25, left: 25), 
                  child: Image.asset(AssetsPaths.MaxLogo, scale: MediaQuery.of(context).size.width / 60)
                ),
                Positioned(
                  bottom: 25,
                  right: 25,
                  child: Image.asset(AssetsPaths.VisaLogo, scale: MediaQuery.of(context).size.width / 30)
                ),
              ]
            )
          )
        ]
      )
    );
  }
  @override
  Widget build(BuildContext context) {
    if (widget.infoPage == true) {
      return _buildCardNoInfoButton(
      widget.cardHolderName,
      widget.cardNumber,
      widget.expiryDate,
      widget.cvvCode,
      widget.height,
      widget.width,
      widget.bgColor,
      widget.infoPage
    );
    } else {
    return _buildCard(
      widget.cardHolderName,
      widget.cardNumber,
      widget.expiryDate,
      widget.cvvCode,
      widget.height,
      widget.width,
      widget.bgColor,
      widget.infoPage
    );
    }
  }
}