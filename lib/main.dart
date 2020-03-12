import 'package:finance_manager/pages/home.page.dart';
import 'package:flutter/material.dart';
import 'package:finance_manager/pages/login.page.dart';

void main() => runApp(AppRoot());

// UI responsible
class AppRoot extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // home: HomePage()
      home: LoginPage()
    );
  }
}