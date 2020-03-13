import 'package:finance_manager/widgets/messages.widgets.dart';
import 'package:finance_manager/widgets/requests.widgets.dart';
import 'package:flutter/material.dart';

class ChatModel extends StatefulWidget{
  const ChatModel({
    Key key,
    @required this.messageWidget,
  }) :super(key:key);
  
  final MessageWidget messageWidget;
  @override
  _ChatModel createState() => _ChatModel();

}
class _ChatModel extends State<ChatModel>
{
   Widget _buildChatModel(MessageWidget messageWidget){
    return Container(
      child: Stack(
        children: <Widget> [
          Container(
            alignment: Alignment.center,
           child: ListTile(
             title: Row(
               children: <Widget>[
                 Text(
                   messageWidget.senderUser.username
                 ),
                 SizedBox(width: 16.0,),
                 Text(messageWidget.title),
    ],
  ),
  subtitle: Text(messageWidget.content),
  trailing: Icon(
    Icons.arrow_forward_ios,
  ),
),

          )
        ]
      )
    );
    
  }
  @override
  Widget build(BuildContext context) {
    return _buildChatModel(this.widget.messageWidget);

}
}