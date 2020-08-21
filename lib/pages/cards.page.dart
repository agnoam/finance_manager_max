import 'package:finance_manager/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:finance_manager/utils/flutter_ui_utils.dart';
import 'package:finance_manager/widgets/creditcard.widgets.dart';


class CardsPage extends StatefulWidget {

  @override
  _CardsPageState createState() => _CardsPageState();
}

class _CardsPageState extends State<CardsPage> {

  
  Widget page(context) { 
    
    Size size = MediaQuery.of(context).size;

    List<CreditCard> cards = [
      CreditCard(cardNumber: '1234 6546 9101 5445', expiryDate: '05/26', 
        cardHolderName: 'Name', cvvCode: '343',height:size.height /3.33, width:size.width * 8, bgColor: HexColor('FFE551'),infoPage: false),
      CreditCard(cardNumber: '1234 5678 9101 2345', expiryDate: '03/23', 
        cardHolderName: 'Name', cvvCode: '343',height:size.height /3.33, width:size.width * 8, bgColor: HexColor('#5dcbc7'), infoPage: false),
      CreditCard(cardNumber: '1234 5678 9101 2345', expiryDate: '03/23', 
        cardHolderName: 'Name', cvvCode: '343',height:size.height /3.33, width:size.width * 8, bgColor: HexColor('#ff6a64'), infoPage: false),
    ];

    return Material(
      child: Container(
        color: HexColor('#3399ff'),
        padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height * 0.05),
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
      // appBar: AppBar(
      //   backgroundColor: Colors.cyan,
      //   centerTitle: true,
      //   title: Row(children:<Widget>[
      //     Text('Card'),
      //     Align(
      //     alignment: Alignment.centerRight,
      //     child:IconButton(icon:Icon(Icons.add) ,onPressed: () {})
      //   )
      //   ]
      //     ),

      //   leading: GestureDetector(
      //     onTap: () {
      //       Navigator.pop(context);
      //     },
      //     child:Icon(Icons.arrow_back,)
      //   ),
          
      // ),
      
      body: Stack(
        children: <Widget> [
          page(context)
        ]
      )
    );
  }
}