
import 'package:finance_manager/services/http.services.dart';
import 'package:flutter/material.dart';

class RequestWidget extends StatefulWidget {
  const RequestWidget({
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
  _RequestWidget createState() => _RequestWidget();
}
class _RequestWidget extends State<RequestWidget>
{
    Widget _buildRequests(String date, String hour,String title, String content, User senderUser, User destUser){
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
    return _buildRequests(this.widget.date,this.widget.hour,this.widget.title,this.widget.content,this.widget.senderUser,this.widget.destUser);

}
}