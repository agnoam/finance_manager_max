import 'package:finance_manager/pages/cards.page.dart';
import 'package:finance_manager/pages/login.page.dart';
import 'package:finance_manager/pages/sendmoney.page.dart';
import 'package:finance_manager/services/http.services.dart';
import 'package:finance_manager/utils/constants.dart';
import 'package:finance_manager/utils/flutter_ui_utils.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomePage extends StatefulWidget {
  // final Card; after choosing a card
  HomePage({ Key key }) : super(key: key);
  
  @override
  _HomePageState createState() => _HomePageState();
}
class _HomePageState extends State<HomePage> {
  bool _isCollapsed = true;
  double screenWidth, screenHeight, _balance;
  final Duration duration = Duration(milliseconds: 300);
       
  @override
  void initState() {
    super.initState();
  }

  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarColor: Theme.of(context).primaryColor,
      systemNavigationBarIconBrightness: Brightness.light
    )
  );

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

  //builds the sidenav
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
            Image.asset(AssetsPaths.MaxLogo, width: 70.0, height:40.0),
            SizedBox(height: 50),
            Text('Settings ', style: TextStyle(color: Colors.black, fontSize: 22)),
            SizedBox(height: 10),
            Text('Gifts', style: TextStyle(color: Colors.black, fontSize: 22)),
            SizedBox(height: 10),
            Text('Messages', style: TextStyle(color: Colors.black, fontSize: 22)),
            SizedBox(height: 10),
            Text('Expenses', style: TextStyle(color: Colors.black, fontSize: 22)),
            SizedBox(height: 10),
            Text('Support', style: TextStyle(color: Colors.black, fontSize: 22)),
            SizedBox(height: 10),
            Text('Calculator', style: TextStyle(color: Colors.black, fontSize: 22)),
            SizedBox(height: 10)
          ]
        )
      )
    );
  }

  //builds the whole page
  Widget page(context) {
    return AnimatedPositioned(
      duration: duration,
      top: _isCollapsed ? 0 : 0.2 * screenHeight,
      bottom: _isCollapsed ? 0 : 0.2 * screenWidth,
      left: _isCollapsed ? 0 : 0.6 * screenWidth,
      right: _isCollapsed ? 0 : -0.4 * screenWidth,
      child: Material(
        animationDuration: Duration(milliseconds: 3000),
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
                  Text(AppVariables.ApplicationName, style: TextStyle(fontSize: 20)),
                  InkWell(
                    child: Icon(
                      Icons.credit_card, 
                      color: Colors.black, 
                      size: 40.0
                    ),
                    onTap: () {
                     Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => CardsPage()));
                    }
                  )
                ]
              ),
              Column(
                children: <Widget>[
                  Card(
                    margin: EdgeInsets.symmetric(vertical: 20.0),
                    color: Colors.white,
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height / 4,
                      child: Center(child: _balanceWidget()),
                      padding: EdgeInsets.symmetric(
                        vertical: MediaQuery.of(context).size.height * 0.08
                      ),
                    )
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height / 2,
                    child: _lastActions()
                  )
                ]
              ),
              FloatingActionButton(
                tooltip: 'Transfer money',
                child: Icon(FontAwesomeIcons.coins),
                backgroundColor: Theme.of(context).primaryColorDark,
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (BuildContext context) => SendMoney())
                  );
                }
              )
            ]
          )
        )
        ]
      )
      ),
    );
  }

  Widget _balanceWidget() {
    return FutureBuilder(
      future: HttpServices.getBalance(),
      builder: (BuildContext context, AsyncSnapshot<double> snapshot) {
        switch(snapshot.connectionState) {
          case ConnectionState.active:
          case ConnectionState.waiting:
            return CircularProgressIndicator();
            
          case ConnectionState.none:
          case ConnectionState.done:
            if(snapshot.hasData) {
              return Text(
                '₪ ${ snapshot.data }',
                style: TextStyle(
                  fontSize: 35.0,
                  color: Colors.black,
                )
              );
            }
            
            return CircularProgressIndicator();

          default:
            return CircularProgressIndicator();
        }
      }
    );
  }

  Widget _lastActions() {
    return FutureBuilder(
      future: HttpServices.getRows(pageSize: 10),
      builder: (BuildContext context, AsyncSnapshot<List<Page>> snapshot) {
        switch(snapshot.connectionState) {
          case ConnectionState.active:
          case ConnectionState.waiting:
            return CircularProgressIndicator();

          case ConnectionState.none:
          case ConnectionState.done:
            if(snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  Page data = snapshot.data[index];

                  return ListTile(
                    leading: data.amount > 0 ? 
                      Icon(Icons.arrow_upward, color: Colors.green) 
                    : 
                      Icon(Icons.arrow_downward, color: Colors.red)
                    ,
                    title: Text('₪ ${ data.amount.toString() }'),
                    subtitle: Text(data.text)
                  );
                }
              );
            }
            
            return CircularProgressIndicator();

          default:
            return CircularProgressIndicator();
        }
      }
    );
  }

}