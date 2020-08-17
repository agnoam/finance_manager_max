import 'package:finance_manager/pages/cards.page.dart';
import 'package:finance_manager/pages/login.page.dart';
import 'package:finance_manager/pages/sendmoney.page.dart';
import 'package:finance_manager/services/http.services.dart';
import 'package:finance_manager/utils/constants.dart';
import 'package:finance_manager/utils/flutter_ui_utils.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/services.dart';
import 'calc.page.dart';

class HomePage extends StatefulWidget {
  // final Card; after choosing a card
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isCollapsed = true;
  double screenWidth, screenHeight;
  final Duration duration = Duration(milliseconds: 300);

  Widget balanceWidget;
  Widget lastActions;

  @override
  void initState() {
    super.initState();
    balanceWidget = _balanceWidget();
    lastActions = _lastActions();
  }

  Future<bool> _onWillPop() async {
    // TODO: make sure actually logged out
    return (await showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            title: new Text('Are you sure?'),
            content: new Text('Do you want to logout?'),
            actions: <Widget>[
              new FlatButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: new Text('No'),
              ),
              new FlatButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: new Text('Yes'),
              ),
            ],
          ),
        )) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    screenHeight = size.height;
    screenWidth = size.width;

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarColor: Theme.of(context).primaryColor,
        systemNavigationBarIconBrightness: Brightness.light));

    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        body: Stack(
          children: <Widget>[menu(context), page(context)],
        ),
      ),
    );
  }

  //builds the sidenav
  Widget menu(context) {
    return Padding(
        padding: EdgeInsets.only(left: 16.0),
        child: Align(
            alignment: Alignment.centerLeft,
            child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  // Image.asset(AssetsPaths.MaxLogo,
                  //     scale: MediaQuery.of(context).size.width / 80,
                  //     alignment: Alignment.centerLeft),
                  ListTile(
                      leading: Icon(Icons.settings),
                      title: Text('Settings'),
                      onTap: () => null),
                  ListTile(
                      leading: Icon(FontAwesomeIcons.moneyBillWave),
                      title: Text('Expenses'),
                      onTap: () => null),
                  ListTile(
                      leading: Icon(FontAwesomeIcons.headset),
                      title: Text('Support'),
                      onTap: () => null),
                  ListTile(
                      leading: Icon(FontAwesomeIcons.shieldAlt),
                      title: Text('Privacy'),
                      onTap: () => null),
                ])));
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
        color: HexColor('#3399ff'),
          animationDuration: Duration(milliseconds: 3000),
          elevation: 8,
          child: Wrap(children: <Widget>[
            Container(
                child: Column(
                  children: <Widget>[
              // Container(
              //   child: AppBar(
              //       centerTitle: true,
              //       title: Text(AppVariables.ApplicationName),
              //       leading: InkWell(
              //           child:
              //               Icon(Icons.menu, color: Colors.black, size: 40.0),
              //           onTap: () {
              //             setState(() => _isCollapsed = !_isCollapsed);
              //           }),
              //       actions: <Widget>[
              //         Padding(
              //             padding: EdgeInsets.only(right: 10),
              //             child: InkWell(
              //                 child: Icon(Icons.credit_card,
              //                     color: Colors.black, size: 40.0),
              //                 onTap: () {
              //                   Navigator.of(context).push(MaterialPageRoute(
              //                       builder: (BuildContext context) =>
              //                           CardsPage()));
              //                 }))
              //       ]),
              // ),
              Column(children: <Widget>[ // Is used as an appbar
                Card(
                  elevation: 8,
                    color: HexColor('#3399ff'),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.35,
                      child: Column(
                        children: <Widget>[
                          SizedBox(height:25),
                          Stack(
                            children: <Widget>[
                              Positioned(
                                left: 0,
                                child: InkWell(
                                  child: Icon(Icons.menu, color: Colors.white, size: 40.0),
                                    onTap: () {
                                      setState(() => _isCollapsed = !_isCollapsed);
                                    }
                                ),
                              ),
                              Center(
                                child: Text(
                                  AppVariables.ApplicationName,
                                  style: TextStyle(
                                    letterSpacing: 9,
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                              child: Text(
                                'בוקר טוב יהודה דניאל',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white
                                ),
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              balanceWidget,
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 15),
                                child: Text(
                                  ' :יתרתך',
                                  style: TextStyle(
                                    fontSize: 25.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 30),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                InkWell(
                                    child: Icon(Icons.credit_card, color: Colors.pinkAccent, size: 50.0),
                                      onTap: () {
                                        Navigator.of(context).push(MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                          CardsPage()));
                                      }
                                ),
                                InkWell(
                                    child: Icon(FontAwesomeIcons.calculator, color: Colors.orange, size: 35.0),
                                      onTap: () {
                                        Navigator.of(context).push(MaterialPageRoute(
                                          builder: (BuildContext context) => Calc()));
                                      }
                                ),
                                InkWell(
                                    child: Icon(FontAwesomeIcons.bell, color: Colors.white, size: 40.0),
                                      onTap: () {
                                        
                                      }
                                ),
                                InkWell(
                                    child: Icon(FontAwesomeIcons.locationArrow, color: Colors.green, size: 40.0),
                                      onTap: () {
                                        
                                      }
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                ),
                Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.6,
                    child: lastActions
                )
              ]),
              // FloatingActionButton(
              //   tooltip: 'Transfer money',
              //   child: Icon(FontAwesomeIcons.coins),
              //   backgroundColor: Theme.of(context).primaryColorDark,
              //   onPressed: () {
              //     Navigator.of(context).push(
              //       MaterialPageRoute(builder: (BuildContext context) => SendMoney())
              //     );
              //   }
              // )
              Container(
                margin: EdgeInsets.all(5),
                // child: FlatButton(
                //     onPressed: () {
                //       Navigator.of(context).push(MaterialPageRoute(
                //           builder: (BuildContext context) => SendMoney()));
                //     },
                //     color: HexColor('#5dcbc7'),
                //     child: Padding(
                //       padding: EdgeInsets.symmetric(
                //           horizontal: MediaQuery.of(context).size.width * 0.22,
                //           vertical: MediaQuery.of(context).size.height * 0.02),
                //       child: Text('Transfer Money',
                //           style: TextStyle(fontSize: 22)),
                //     )),
              )
            ]))
          ])),
    );
  }

  Widget _balanceWidget() {
    return FutureBuilder(
        future: HttpServices.getBalance(),
        builder: (BuildContext context, AsyncSnapshot<double> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.active:
            case ConnectionState.waiting:
              return CircularProgressIndicator();

            case ConnectionState.none:
            case ConnectionState.done:
              if (snapshot.hasData) {
                return Text('₪ ${snapshot.data}',
                    style: TextStyle(
                      fontSize: 30.0,
                      color: Colors.white,
                    ));
              }

              return CircularProgressIndicator();

            default:
              return CircularProgressIndicator();
          }
        });
  }

  Widget _lastActions() {
    return FutureBuilder(
        future: HttpServices.getRows(pageSize: 10),
        builder: (BuildContext context, AsyncSnapshot<List<Page>> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.active:
            case ConnectionState.waiting:
              return CircularProgressIndicator();

            case ConnectionState.none:
            case ConnectionState.done:
              if (snapshot.hasData) {
                return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext context, int index) {
                      Page data = snapshot.data[index];

                      return ListTile(
                          leading: data.amount > 0
                              ? Icon(Icons.arrow_upward, color: Colors.green)
                              : Icon(Icons.arrow_downward, color: Colors.red),
                          title: Text('₪ ${data.amount.toString()}',
                              style: TextStyle(fontSize: 22)),
                          subtitle:
                              Text(data.text, style: TextStyle(fontSize: 22)));
                    });
              }

              return CircularProgressIndicator();

            default:
              return CircularProgressIndicator();
          }
        });
  }
}
