import 'package:finance_manager/pages/home.page.dart';
import 'package:flutter/material.dart';
import 'package:finance_manager/utils/flutter_ui_utils.dart';
import 'package:finance_manager/widgets/creditcard.widgets.dart';


class CardsPage extends StatefulWidget {

  @override
  _CardsPageState createState() => _CardsPageState();
}

class _CardsPageState extends State<CardsPage> {


Widget page(context) { 
    return Material(
        child: Container(
          child: Column(
            children: <Widget>[
           
              Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  CreditCard(cardNumber: '1234 5678 9101 2345', expiryDate: '03/23', cardHolderName: 'Name', cvvCode: '343',height:160,width:350),
                  CreditCard(cardNumber: '1234 5678 9101 2345', expiryDate: '03/23', cardHolderName: 'Name', cvvCode: '343',height:160,width:350),
                  CreditCard(cardNumber: '1234 5678 9101 2345', expiryDate: '03/23', cardHolderName: 'Name', cvvCode: '343',height:160,width:350),

                  //insert real card info here^ 
                  SizedBox(height: 5.0),
                ]
              )
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