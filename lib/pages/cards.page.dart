import 'package:finance_manager/pages/home.page.dart';
import 'package:finance_manager/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:finance_manager/utils/flutter_ui_utils.dart';
import 'package:finance_manager/widgets/creditcard.widgets.dart';


class CardsPage extends StatefulWidget {

  @override
  _CardsPageState createState() => _CardsPageState();
}

class _CardsPageState extends State<CardsPage> {
  List<CreditCard> cards = [
    CreditCard(cardNumber: '1234 5678 9101 2345', expiryDate: '03/23', 
      cardHolderName: 'Name', cvvCode: '343',height:160,width:350),
    CreditCard(cardNumber: '1234 5678 9101 2345', expiryDate: '03/23', 
      cardHolderName: 'Name', cvvCode: '343',height:160,width:350),
    CreditCard(cardNumber: '1234 5678 9101 2345', expiryDate: '03/23', 
      cardHolderName: 'Name', cvvCode: '343',height:160,width:350)
  ];
  
  Widget page(context) { 
    return Material(
      child: Container(
        child: ListView.builder(
          itemCount: AppVariables.NumberOfCards,
          itemBuilder: (context, index) {
            return cards[index];
          }
        )
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: HexColor('#5dcbc7'),
        centerTitle: true,
        title: Row(children:<Widget>[
          Text('Cards'),
          Align(
          alignment: Alignment.topRight,
          child:IconButton(icon:Icon(Icons.add) ,onPressed: () {})
        )
        ]
          ),

        leading: GestureDetector(
          onTap: ()
          {
          Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => HomePage()));
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