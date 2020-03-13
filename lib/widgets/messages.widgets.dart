import 'dart:ffi';

import 'package:finance_manager/pages/cardinfo.page.dart';
import 'package:finance_manager/services/http.services.dart';
import 'package:finance_manager/utils/constants.dart';
import 'package:finance_manager/utils/flutter_ui_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';

class MessageWidget extends StatefulWidget {
  const MessageWidget({
    Key key,
    @required this.date,
    @required this.hour,
    @required this.title,
    @required this.content,
    @required this.senderUser,
    @required this.destUser,


  })  :super(key: key);

  final String date;
  final String hour;
  final String title;
  final String content;
  final User senderUser;
  final User destUser;


  @override
  _MessageWidget createState() => _MessageWidget();
}
class _MessageWidget extends State<MessageWidget>
{
    Widget _buildMessage(String date, String hour,String title, String content, User senderUser, User destUser){
    return Container(
      child: Stack(
        children: <Widget> [
          Container(
            alignment: Alignment.center,
           
          )
        ]
      )
    );
  }
  @override
  Widget build(BuildContext context) {
    return _buildMessage(this.widget.date,this.widget.hour,this.widget.title,this.widget.content,this.widget.senderUser,this.widget.destUser);

}
}