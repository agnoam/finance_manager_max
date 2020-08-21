import 'package:finance_manager/utils/flutter_ui_utils.dart';
import 'package:finance_manager/widgets/menu.widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'cards.page.dart';

class Calc extends StatefulWidget {
  @override
  _CalcState createState() => _CalcState();
  
}

class Currencies {
  double exch;
  String name;

  Currencies(this.exch, this.name);
  static List<Currencies> getCurrencies() {
    return <Currencies>[
      Currencies(0.274, "USD"),
      Currencies(0.244, "EUR"),
      Currencies(1, "ILS"),
    ];
  }
}


class _CalcState extends State<Calc> {
  bool _isCollapsed = true;
  double screenWidth, screenHeight;
  final Duration duration = Duration(milliseconds: 300);
  String _exchangeVal = "0";
  String _output = "0";
  double num1 = 0.0;
  double num2 = 0.0;
  String operandFrom = "";
  String operandTo = "";

  List<Currencies> _currencies = Currencies.getCurrencies();
  List<DropdownMenuItem<Currencies>> _dropItems;
  Currencies _selectCurrency;
  Currencies _toCurrency;

  @override
  void initState() {
    super.initState();

    _dropItems = buildDropMenuItems(_currencies);
    _selectCurrency = _dropItems[2].value;
    _toCurrency = _dropItems[1].value;
  }

  List<DropdownMenuItem<Currencies>> buildDropMenuItems(List currencies) {
    List<DropdownMenuItem<Currencies>> items = List();
    for(Currencies currency in currencies) {
      items.add(
        DropdownMenuItem(
          value: currency, 
          child: Text(
            currency.name
          ),
        )
      );
    }
    return items;
  }

  valueChange() {
    if(_output.length > 0 && double.parse(_output) > 0){
      if(_selectCurrency.name == "ILS"){
        _exchangeVal =  (double.parse(_output) * _toCurrency.exch).toStringAsFixed(2);
      }else if(_toCurrency.name == "ILS") {
        _exchangeVal =  (double.parse(_output) / _selectCurrency.exch).toStringAsFixed(2);
      }else {
        _exchangeVal =  (double.parse(_output) * _toCurrency.exch / _selectCurrency.exch).toStringAsFixed(2);
      }
    }

    switch(_selectCurrency.name) {
      case "ILS":
        operandFrom = "₪";
      break;
      case "EUR":
        operandFrom = "€";
      break;
      case "USD":
        operandFrom = "\u0024";
      break;
    }

    switch(_toCurrency.name) {
      case "ILS":
        operandTo = "₪";
      break;
      case "EUR":
        operandTo = "€";
      break;
      case "USD":
        operandTo = "\u0024";
      break;
    }
  }

  buttonPressed(String buttonText) {
    if(buttonText == "C") {
      _output = "0";
      _exchangeVal = "0";
      num1 = 0.0;
      num2 = 0.0;

      setState(() => _output = _output);
    } else if(double.parse(_output) < 1000000) {
      if(buttonText == '.' && !_output.contains('.')) {
        setState(() => _output += buttonText);
      } else if(_output == "0") {
        setState(() => _output = buttonText);
      } else if(buttonText != '.') {
        setState(() {
          List<String> splitted = _output.split('.');
          if((splitted.length > 1 && splitted[1].length < 2) || splitted.length == 1){
            _output += buttonText;
          }
        });
      }
    }

    valueChange();
  }

  Widget _buildButton(String buttonText) {
    return Expanded(
      child: OutlineButton(
        padding: EdgeInsets.symmetric(horizontal:5.0, vertical: 25.0),
        child: Text(buttonText, style:TextStyle(fontSize: 30.0, fontWeight: FontWeight.normal, color: Colors.white)),
        color: HexColor('#ededed'),
        textColor: HexColor('#121237'),
        onPressed: () {
          buttonPressed(buttonText);
        } 
      )
    );
  }

  onChangedDropdownItem(Currencies selectCurrency) {
    valueChange();
    setState(() {
      _selectCurrency = selectCurrency;
    });
  }
  onChangedDropdownItem2(Currencies toCurrency) {
    valueChange();
    setState(() {
      _toCurrency = toCurrency;
    });
  }
  Widget page (context) {
      return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Container(
        color: HexColor('#3399ff'),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.symmetric(vertical: 40.0, horizontal: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                         '$operandFrom $_output', 
                        style: TextStyle(
                          fontSize: 50.0,
                          color: Colors.white,
                          fontWeight: FontWeight.bold
                        )
                      ),
                      Text(
                        '$operandTo $_exchangeVal', 
                        style: TextStyle(
                          fontSize: 50.0,
                          color: HexColor('#f7f7f7').withOpacity(0.4),
                          fontWeight: FontWeight.bold
                        )
                      ),
                    ]
                  )
                ),
                Container(
                  width: 100.0,
                  margin: EdgeInsets.symmetric(vertical: 70.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      DropdownButton(
                        value: _selectCurrency,
                        items: _dropItems,
                        onChanged: onChangedDropdownItem,
                      ),
                      SizedBox(height: 15.0),
                      DropdownButton(
                        value: _toCurrency,
                        items: _dropItems,
                        onChanged: onChangedDropdownItem2,
                      ),
                    ]
                  ),
                )
              ]
            ),
            Expanded(
              child: Divider(),
            ),
            Column(
              children:<Widget>[
                Row(
                  children: <Widget>[
                    Expanded(
                      child: OutlineButton(
                        padding: EdgeInsets.symmetric(horizontal:5.0, vertical: 15.0),
                        child: IconButton(
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(builder: (BuildContext context) => CardsPage())
                            );
                          },
                          icon: Icon(
                            Icons.credit_card, 
                            size: 40.0,
                            ),
                          ),
                        color: HexColor('#ededed'),
                        textColor: HexColor('#121237'),
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(builder: (BuildContext context) => CardsPage())
                          );
                        },
                      )
                    ),
                    Expanded(
                      child: OutlineButton(
                        padding: EdgeInsets.symmetric(horizontal:5.0, vertical: 15.0),
                        child: IconButton(
                          onPressed: () {
                            int lengt = _output.length;
                            setState(() {
                              _output = lengt > 1? _output.substring(0, lengt - 1) : "0";
                              _exchangeVal = _output == "0" ? "0": _exchangeVal;
                            });
                          },
                          icon: Icon(
                            Icons.backspace, 
                            size: 40.0,
                            ),
                          ),
                        color: HexColor('#ededed'),
                        textColor: HexColor('#121237'),
                        onPressed: () {}
                      )
                    )
                  ]
                ),
                Row(
                  children: <Widget>[
                    _buildButton('1'),
                    _buildButton('2'),
                    _buildButton('3'),
                  ]
                ),
                Row(
                  children: <Widget>[
                    _buildButton('4'),
                    _buildButton('5'),
                    _buildButton('6'),
                  ]
                ),
                Row(
                  children: <Widget>[
                    _buildButton('7'),
                    _buildButton('8'),
                    _buildButton('9'),
                  ]
                ),
                Row(
                  children: <Widget>[
                    _buildButton('C'),
                    _buildButton('0'),
                    _buildButton('.'),
                  ]
                ),
              ]
            )
          ],
        )
      )
    );
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

    return Stack(
         children: [Menu(context: context),page(context)],
    );
  }
}

// class CurrencyResponse {
//   String base;
//   Map<String, double> rates;

//   int _amount = 4; //should be = input.value
//   static double eur = Currency.EUR;
//   final double usd = Currency.USD;



//   convert() {
//     if(true){//USD
//       return _amount * usd;
//     }
//   }
// }
// class Currency {
//   static final double EUR = 0.244;
//   static final double USD = 0.274;
//   static final double ILS = 1;

//   // Currencies(this.)
// }

// // * foreign to Local
// // / local to foreign
// {
//   "base": "ILS",
//   "rates": {
//       "EUR": 0.244,
//       "USD": 0.274
//   },
// }