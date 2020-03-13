import 'package:finance_manager/pages/addcard.page.dart';
import 'package:finance_manager/pages/cards.page.dart';
import 'package:finance_manager/pages/chat.page.dart';
import 'package:finance_manager/pages/home.page.dart';
import 'package:finance_manager/pages/sendmoney.page.dart';
import 'package:finance_manager/services/http.services.dart';
import 'package:finance_manager/widgets/messages.widgets.dart';
import 'package:flutter/material.dart';
import 'package:finance_manager/pages/login.page.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';

void main() => runApp(AppRoot());

// UI responsible
class AppRoot extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      
      home: HomePage()
      //home: LoginPage()
    );
  }
}