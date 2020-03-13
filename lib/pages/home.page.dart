import 'package:finance_manager/pages/cards.page.dart';
import 'package:finance_manager/pages/sendmoney.page.dart';
import 'package:finance_manager/services/http.services.dart';
import 'package:finance_manager/utils/flutter_ui_utils.dart';
import 'package:finance_manager/widgets/messages.widgets.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  final User user; 
  //final Card; after choosing a card
  HomePage({Key key, this.user}) : super(key: key);
  @override
_HomePageState createState() => _HomePageState();
}
class _HomePageState extends State<HomePage> {
  bool _isCollapsed = true;
  double screenWidth, screenHeight;
  final Duration duration = Duration(milliseconds: 300);
       
  Widget menu(context){
    return Padding(
      padding: EdgeInsets.only(left: 16.0),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
          Image.asset('assets/images/max.png', width: 70.0, height:40.0),
          SizedBox(height: 50),
          Text('Settings ', style: TextStyle(color: Colors.black, fontSize: 22)),
          SizedBox(height: 10),
          Text('Gifts', style: TextStyle(color: Colors.black, fontSize: 22)),
          SizedBox(height: 10),
          Text('Messages & Requests', style: TextStyle(color: Colors.black, fontSize: 22)),
          SizedBox(height: 10),
          Text('Expenses', style: TextStyle(color: Colors.black, fontSize: 22)),
          SizedBox(height: 10),
          Text('Support', style: TextStyle(color: Colors.black, fontSize: 22)),
          SizedBox(height: 10),
          Text('Calculator', style: TextStyle(color: Colors.black, fontSize: 22)),
          SizedBox(height: 10),
        ],
      ),
    ),
  );
}

  Widget page(context) {
    return AnimatedPositioned(
      duration: duration,
      top: _isCollapsed ? 0 : 0.2 * screenHeight,
      bottom: _isCollapsed ? 0 : 0.2 * screenWidth,
      left: _isCollapsed ? 0 : 0.6 * screenWidth,
      right: _isCollapsed ? 0 : -0.4 * screenWidth,
      child: Material(
        animationDuration: Duration(milliseconds: 3000),
        borderRadius: BorderRadius.all(Radius.circular(40)),
        elevation: 8,
        child: Wrap(children: <Widget>[
        Container(
          padding: EdgeInsets.only(left: 16, right: 16, top: 48),
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  InkWell(
                    child: Icon(
                      Icons.menu, 
                      color: Colors.black, 
                      size: 40.0
                    ),
                    onTap: () {
                      setState(() {
                        _isCollapsed = !_isCollapsed;
                      });
                    },
                  ),
                  Text('Balance', style: TextStyle(fontSize: 20)),
                  InkWell(
                    child: Icon(
                      Icons.credit_card, 
                      color: Colors.black, 
                      size: 40.0
                    ),
                    onTap: () {
                     Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => CardsPage()));
                    },
                  ),


                ]
              ),
              Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Card(
                    margin: EdgeInsets.symmetric(vertical: 20.0),
                    color: Colors.white,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        vertical: MediaQuery.of(context).size.height * 0.08
                      ),
                      child: Center(
                        child: Text(
                          '1,000 ₪',
                          style: TextStyle(
                            fontSize: 30.0,
                            color: Colors.white
                          )
                        )
                      ),
                      decoration: BoxDecoration(
                        color: HexColor('#031851')
                        /*gradient: LinearGradient(
                          
                          colors: [
                            HexColor('#5dcbc7'),
                            HexColor('#031851')
                          ]
                        )*/
                      ),
                    )
                  ),
                  
                  SizedBox(height: 5.0),
                  Card(
                    margin: EdgeInsets.symmetric(vertical: 20.0),
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(40.0))
                    ),
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        vertical: MediaQuery.of(context).size.height * 0.04
                      ),
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.fromLTRB(10.0, 0, 0, 5.0),
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                'Expenses',
                                style: TextStyle(
                                  fontSize: 20.0,
                                  color: Colors.black
                                )
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: Text(
                              '-240 for Yuda supermarket',
                              style: TextStyle(
                                fontSize: 20.0,
                                color: Colors.red,
                                fontWeight: FontWeight.bold
                              )
                            ),
                          ),
                        ]
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(width: 0.5, color: Colors.grey),
                        borderRadius: BorderRadius.all(Radius.circular(40.0))
                      ),
                    )
                  ),
                  SizedBox(height: 5.0),
                  Card(
                    margin: EdgeInsets.symmetric(vertical: 20.0),
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(40.0))
                    ),
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        vertical: MediaQuery.of(context).size.height * 0.04
                      ),
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.fromLTRB(10.0, 0, 0, 5.0),
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                'Transactions',
                                style: TextStyle(
                                  fontSize: 20.0,
                                  color: Colors.black
                                )
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: Text(
                              '+300 from kobi',
                              style: TextStyle(
                                fontSize: 20.0,
                                color: Colors.green,
                                fontWeight: FontWeight.bold
                              )
                            ),
                          ),
                        ]
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(width: 0.5, color: Colors.grey),
                        borderRadius: BorderRadius.all(Radius.circular(40.0))
                      ),
                    )
                  ),

          
                  FloatingActionButton.extended(
                  onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => SendMoney()));
                  },
                  icon: Icon(Icons.send,),
                  label: Text("send", style: TextStyle(fontSize: 20),),
                  backgroundColor:HexColor("#031851") ,),
                
                ]
              )
            ],
          ),
        )
        ]
      )
      ),
    );
}

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    screenHeight = size.height;
    screenWidth = size.width;
    return Scaffold(
      body: Stack(
        children: <Widget>[
          menu(context),
           page(context)
         
          
        ],
      )
    );
  }
}