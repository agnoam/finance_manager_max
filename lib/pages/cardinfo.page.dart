import 'package:finance_manager/pages/cards.page.dart';
import 'package:flutter/material.dart';
import 'package:finance_manager/utils/flutter_ui_utils.dart';
import 'package:finance_manager/widgets/creditcard.widgets.dart';


class CardInfo extends StatefulWidget {
final String cardNumber;
final String expiryDate;
final String cardHolderName;
final String cvvCode;

  const CardInfo({Key key, this.cardNumber='1234 5678 9101 2345', this.expiryDate='03/23', this.cardHolderName='Name', this.cvvCode='343'}) : super(key: key);

  @override
  _CardInfoState createState() => _CardInfoState();
}

class _CardInfoState extends State<CardInfo> {


Widget page(context) { 
  return Material(
    child: Container(
      child: Column(
        children: <Widget>[
          Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              CreditCard(
                cardNumber: widget.cardNumber, 
                expiryDate: widget.expiryDate, 
                cardHolderName: widget.cardHolderName, 
                cvvCode: widget.cvvCode,
                height: 160,
                width: 350
              )
              //insert real card info here^ 
            ]
          ),
            Column(
              children:<Widget>[
                Text('Card holder name:' ,style: TextStyle(fontSize: 20,color: Colors.black)),
                TextField(
                  textAlign: TextAlign.center,
                  enabled: false,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: this.widget.cardHolderName),
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black
                    )
                  )
                ]
              ),
              Column(
                  children:<Widget>[
                    Text('Card number:',style: TextStyle(fontSize: 20,color: Colors.black)),
                    TextField(
                      textAlign: TextAlign.center,
                      enabled: false,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: this.widget.cardNumber
                      ),
                      style: TextStyle(fontSize: 20,color: Colors.black)
                    ), 
                  ]
               ),
               Column(
                  children:<Widget>[
                    Text('cvv code:',style: TextStyle(fontSize: 20,color: Colors.black)),
                    TextField(
                      textAlign: TextAlign.center,
                      enabled: false,decoration: InputDecoration(
                        border: InputBorder.none,hintText: this.widget.cvvCode),
                        style: TextStyle(fontSize: 20,color: Colors.black)),]
               ),

               Column(
                  children:<Widget>[
                    Text('Expiration date:',style: TextStyle(fontSize: 20,color: Colors.black)),
                    TextField( 
                      textAlign: TextAlign.center,
                      enabled: false,
                      decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: this.widget.expiryDate),
                      style: TextStyle(fontSize: 20,color: Colors.black)),])
            ],
          ),
        )
      );
  }


   @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: HexColor('#5dcbc7'),
        centerTitle: true,
        title: Row(children:<Widget>[Text('Cards'),
        IconButton(
        icon: Icon(Icons.settings),
        onPressed: (){},)]
          ),
      
      
        leading: GestureDetector(
          onTap: ()
          {
          Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => CardsPage()));
          },
          child:Icon(Icons.arrow_back,)
          
          ),
          
      ),
      body: Stack(
        children: <Widget> [
          page(context)
          
        ]
      )
    );
  }
}