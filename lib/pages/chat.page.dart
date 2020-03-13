import 'package:finance_manager/pages/home.page.dart';
import 'package:finance_manager/services/http.services.dart';
import 'package:finance_manager/widgets/chatmodel.widgets.dart';
import 'package:finance_manager/widgets/messages.widgets.dart';
import 'package:flutter/material.dart';
import 'package:finance_manager/utils/flutter_ui_utils.dart';
import 'package:finance_manager/widgets/creditcard.widgets.dart';


class Chat extends StatefulWidget {
  const Chat({
    Key key,
    @required this.messages
  })  :super(key: key); 
  final List<MessageWidget> messages;

  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {


Widget page(context) { 

 
    return Material(
        child: Container(
          child: Column(
            children: <Widget>[
              Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Padding(
                  padding: EdgeInsets.only(top: 25, left: 10), 
                  child: 
                
                  Column(children: <Widget>
                  [
                    ListView.builder(
                      itemCount: this.widget.messages.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ChatModel (messageWidget: this.widget.messages[index]);
                      }
                        )
                  
                  ],
                  
                  
                  )

                  
                  ),

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
          Text('Chat',),
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