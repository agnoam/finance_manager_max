import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            expandedHeight: 200.0,
            floating: false,
            pinned: true,
            flexibleSpace: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.purple[600],
                    Colors.cyan[700]
                  ]
                )
              ),
            ),
            title: Row(
              children: <Widget>[
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.2,
                  child: IconButton(
                    onPressed: (){},
                    icon: Icon(
                      Icons.menu, 
                      color: Colors.white
                    ),
                    iconSize: 60.0,
                  )
                ),
                Text(
                  '1,000', 
                  style: TextStyle(
                    fontWeight: FontWeight.bold, 
                    fontSize: 60.0
                  )
                ),
              ]
            ),
          ),
          SliverFillRemaining(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('asgasgadggasgag')
                ],
              )
            )
          )
        ],
      )
    );
  }
}