import 'package:finance_manager/pages/home.page.dart';
import 'package:finance_manager/services/http.services.dart';
import 'package:flutter/material.dart';
import 'package:finance_manager/utils/flutter_ui_utils.dart';

class SendMoney extends StatefulWidget {

  @override
  _SendMoneyState createState() => _SendMoneyState();
}

class _SendMoneyState extends State<SendMoney> {
  double _amount = 0;
  String _pinCode;
  String _destID;

  Widget page(BuildContext context) { 
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
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: Text(
                              'Amount to transfer:', 
                              textAlign: TextAlign.left, 
                              style: TextStyle(fontSize: 20)
                            )
                          ),
                          Expanded(
                            child: TextField( 
                              keyboardType: TextInputType.number,
                              textAlign: TextAlign.left,
                              enabled: true,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Amount"
                              ),
                              style: TextStyle(fontSize: 20,color: Colors.black),
                              onChanged: (value) => _amount = double.parse(value)
                            )
                          )
                        ]
                      ),
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: Text(
                              'Target id:', 
                              textAlign: TextAlign.left, 
                              style: TextStyle(fontSize: 20)
                            )
                          ),
                          Expanded(
                            child: TextField(
                              textAlign: TextAlign.left,
                              enabled: true,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "id"
                              ),
                              style: TextStyle(fontSize: 20,color: Colors.black),
                              onChanged: (value) => _destID = value
                            )
                          )
                        ]
                      ),
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: Text(
                              'PIN code:', 
                              textAlign: TextAlign.left, 
                              style: TextStyle(fontSize: 20)
                            )
                          ),
                          Expanded(
                            child: TextField(
                              keyboardType: TextInputType.number,
                              textAlign: TextAlign.left,
                              enabled: true,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Pin Code"
                              ),
                              style: TextStyle(fontSize: 20,color: Colors.black),
                              onChanged: (value) => _pinCode = value
                            )
                          )
                        ]
                      ),
                      SizedBox(height: 20),
                      Row(
                        children: <Widget>[
                          Expanded(
                            child:FloatingActionButton.extended(
                              icon: Icon(Icons.send),
                              label: Text("send", style: TextStyle(fontSize: 20),),
                              backgroundColor:HexColor("#031851"),
                              onPressed: () async {
                                bool transfered = await HttpServices.transferMoney(_destID, _amount, _pinCode);
                                if(transfered) {
                                  Dialogs.showAlert(
                                    context, 
                                    'Money Transfered successfuly', 
                                    onResolve: () => Navigator.of(context).pop()
                                  );
                                } else {
                                  Dialogs.showAlert(
                                    context, 
                                    'Money transfer failed', 
                                    onResolve: () => Navigator.of(context).pop()
                                  );
                                }
                              }
                            )
                          )
                        ]
                      )
                    ]
                  )        
                )
              ]
            )
          ]
        )
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: HexColor('#5dcbc7'),
        centerTitle: true,
        title: Row(
          children:<Widget>[
            Text('Money transaction')
          ]
        ),
        leading: GestureDetector(
          child:Icon(Icons.arrow_back),
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (BuildContext context) => HomePage())
            );
          } 
        )
      ),
      body: Stack(
        children: <Widget> [
          page(context) 
        ]
      )
    );
  }
}