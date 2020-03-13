import 'package:finance_manager/pages/login.page.dart';
import 'package:flutter/material.dart';

void main() => runApp(AppRoot());

// UI responsible
class AppRoot extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginPage()
    );
  }
}