    
  import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Menu extends StatefulWidget{
  Menu ( {
    @required BuildContext context,
    this.key
  }):super(key:key);
  final Key key;
  BuildContext context;
  @override
  _Menu createState() => _Menu();
}
class _Menu extends State<Menu> {
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

  @override
  Widget build(BuildContext context) {
    return menu(context);
  }
}