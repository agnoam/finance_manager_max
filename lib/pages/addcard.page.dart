import 'package:finance_manager/pages/cards.page.dart';
import 'package:flutter/material.dart';

class AddCardPage extends StatefulWidget{
  @override
    _AddCardPageState createState() => _AddCardPageState();
}
class _AddCardPageState extends State<AddCardPage>{
bool _isCollapsed = true;
  double screenWidth, screenHeight;
  final Duration duration = Duration(milliseconds: 300);
Widget page (context)
  { 
    /*return Row(
      
      children: <Widget>[
        Column(children: <Widget>[
          Text("Card owner name:"),
          TextField(
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: 'name'
              ),
              )
        ],)
        
      ],

    );*/
    return Row(
      children: <Widget>[
          Text("Card owner name:"),
          TextField(
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: 'name'
              ),
              ),
      ],

    );
  
  }
   @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    screenHeight = size.height;
    screenWidth = size.width;
    return Scaffold(
      body: Stack(
        children: <Widget>[
          page(context),

          ],
      )
    );
  }
}