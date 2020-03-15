import 'package:finance_manager/pages/home.page.dart';
import 'package:finance_manager/services/http.services.dart';
import 'package:flutter/material.dart';
import 'package:finance_manager/utils/flutter_ui_utils.dart';
import 'package:finance_manager/widgets/creditcard.widgets.dart';


class SendMoney extends StatefulWidget {

  @override
  _SendMoneyState createState() => _SendMoneyState();
}

class _SendMoneyState extends State<SendMoney> {

  double _amount = 0;
  String _pinCode;
  String _destID;

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
                  child: Column(children: <Widget>[
                  Row(
                   children: <Widget>[
                    Expanded(
                      child: Text('Amount to transfer:', textAlign: TextAlign.left, style: TextStyle(fontSize: 20),),),
                      Expanded(
                     child: TextField( 
                       onChanged: (value) => _amount = double.parse(value),
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.left,
                      enabled: true,
                      decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "amount"),
                      style: TextStyle(fontSize: 20,color: Colors.black))
                      ),
                      ],
                      ),
                    Row(
                      children: <Widget>[
                      Expanded(
                        child: Text('Target id:', textAlign: TextAlign.left, style: TextStyle(fontSize: 20),),),
                        Expanded(
                        child: TextField(
                        onChanged: (value) => _destID = value,
                        textAlign: TextAlign.left,
                        enabled: true,
                        decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "id"),
                        style: TextStyle(fontSize: 20,color: Colors.black))
                        ),
                      ],
                      ),

                      Row(
                   children: <Widget>[
                    Expanded(
                      child: Text('PIN code:', textAlign: TextAlign.left, style: TextStyle(fontSize: 20),),),
                      Expanded(
                     child: TextField( 
                       onChanged: (value) => _pinCode = value,
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.left,
                      enabled: true,
                      decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Pin Code"),
                      style: TextStyle(fontSize: 20,color: Colors.black))
                      ),
                      ],
                      ),

                      SizedBox(height: 20),
                      Row(
                      children: <Widget>[
                      Expanded(
                      child:FloatingActionButton.extended(
                      onPressed: () async {
                        bool transfered = await HttpServices.transferMoney(_destID, _amount, _pinCode);
                        if(transfered) {
                          Dialogs.showAlert(context, 
                            'Money Transfered successfuly', onResolve: () => Navigator.of(context).pop());
                        } else {
                          Dialogs.showAlert(context, 'Money transfer failed', onResolve: () => Navigator.of(context).pop());
                        }
                      },
                     icon: Icon(Icons.send,),
                     label: Text("send", style: TextStyle(fontSize: 20),),
                     backgroundColor:HexColor("#031851") ,)
                      ),
                      ],
                      ),
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
          Text('Money transaction',),
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