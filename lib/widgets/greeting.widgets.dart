import 'dart:ffi';

import 'package:finance_manager/pages/cardinfo.page.dart';
import 'package:finance_manager/utils/constants.dart';
import 'package:finance_manager/utils/flutter_ui_utils.dart';
import 'package:flutter/material.dart';

class Greeting extends StatefulWidget {

  const Greeting({
    this.key,
    @required this.name,
  }):super(key:key);

  final Key key;
  final String name;
  @override
  _Greeting createState() => _Greeting();
}
class _Greeting extends State<Greeting> {
  Widget buildGreeting (String greeting) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Text(
        greeting,
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.white), ), );
  }
  @override
  Widget build(BuildContext context) {
    var hour = DateTime.now().hour;
    String name = widget.name;
    if (hour>=0 && hour <=5 || hour>=20 && hour <=23) {
      return buildGreeting (" לילה טוב $name" );
    } else if (hour>=6 && hour <=11) {
      return buildGreeting ("בוקר טוב $name" );
    } else if (hour>=12 && hour <=15) {
      return buildGreeting ("צהריים טובים $name" );
    } else if (hour>=16 && hour <=17) {
      return buildGreeting ("אחר צהריים טובים $name" );
    } else if (hour>=18 && hour <=19) {
      return buildGreeting ("ערב טוב $name" );
    }
  }
}