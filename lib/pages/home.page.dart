import 'package:finance_manager/pages/cards.page.dart';
import 'package:finance_manager/pages/sendmoney.page.dart';
import 'package:finance_manager/services/http.services.dart';
import 'package:finance_manager/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomePage extends StatefulWidget {
  // final Card; after choosing a card
  HomePage({ Key key }) : super(key: key);
  
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isCollapsed = true;
  double _screenWidth, _screenHeight;
  final Duration _duration = Duration(milliseconds: 300);

  Widget _menu(BuildContext context){
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
            Text('Messages & Requests', style: TextStyle(color: Colors.black, fontSize: 22)),
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
  
  Widget _tomExpenses() {
    return ListView(
      children: <Widget> [
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
                    child: Text('Transactions',
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
            )
          )
        )
      ]
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

  Widget _page(BuildContext context) {
    return AnimatedPositioned(
      duration: _duration,
      top: _isCollapsed ? 0 : 0.2 * _screenHeight,
      bottom: _isCollapsed ? 0 : 0.2 * _screenWidth,
      left: _isCollapsed ? 0 : 0.6 * _screenWidth,
      right: _isCollapsed ? 0 : -0.4 * _screenWidth,
      child: Material(
        animationDuration: Duration(milliseconds: 3000),
        elevation: 8,
        child: Wrap(
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: ListView(
                children: <Widget>[
                  Card(
                    margin: EdgeInsets.symmetric(vertical: 20.0),
                    color: Colors.white,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        vertical: MediaQuery.of(context).size.height * 0.08
                      ),
                      child: Center(child: _balanceWidget()),
                      decoration: BoxDecoration(
                        // color: HexColor('#5dcbc7')
                        /*gradient: LinearGradient(
                          
                          colors: [
                            HexColor('#5dcbc7'),
                            HexColor('#031851')
                          ]
                        )*/
                      )
                    )
                  ),
                  SizedBox(height: 5.0)
                ]
              )
            )
          ]
        )
      )
    );
  }

  Widget _drawer(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          Image.asset(
            AssetsPaths.MaxLogo, 
            scale: MediaQuery.of(context).size.width / 80, 
            alignment: Alignment.centerLeft
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Settings'),
            onTap: () => null
          ),
          ListTile(
            leading: Icon(FontAwesomeIcons.gifts),
            title: Text('Gifts'),
            onTap: () => null
          ),
          ListTile(
            leading: Icon(Icons.notifications),
            title: Text('Messages'),
            onTap: () => null
          ),
          ListTile(
            leading: Icon(FontAwesomeIcons.moneyBillWave),
            title: Text('Expenses'),
            onTap: () => null
          ),
          ListTile(
            leading: Icon(FontAwesomeIcons.headset),
            title: Text('Support'),
            onTap: () => null
          ),
          ListTile(
            leading: Icon(FontAwesomeIcons.calculator),
            title: Text('Calculator'),
            onTap: () => null
          )
        ]
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    _screenHeight = size.height;
    _screenWidth = size.width;
    
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarColor: Theme.of(context).primaryColor,
        systemNavigationBarIconBrightness: Brightness.light
      )
    );

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(AppVariables.ApplicationName),
        // leading: InkWell(
        //   child: Icon(Icons.menu, color: Colors.black, size: 40.0),
        //   onTap: () {
        //     setState(() =>_isCollapsed = !_isCollapsed);
        //   }
        // ),
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.only(right: 10),
            child: InkWell(
              child: Icon(Icons.credit_card, color: Colors.black),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (BuildContext context) => CardsPage())
                );
              }
            )
          )
        ]
      ),
      drawer: _drawer(context),
      body: Column(
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
      floatingActionButton: FloatingActionButton(
        tooltip: 'Transfer money',
        child: Icon(FontAwesomeIcons.coins),
        backgroundColor: Theme.of(context).primaryColorDark,
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (BuildContext context) => SendMoney())
          );
        }
      )
    );
  }
}