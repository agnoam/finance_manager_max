import 'dart:convert';

import 'package:http/http.dart' as http;

class HttpServices {
  static bool _isDebug = true;
  static String _devURL = 'http://10.0.0.23:8010';
  
  static String get serverURL {
   return _isDebug ? 
      _devURL
    : 
      // The production server
      'https://real-server.com'
    ;
  }

  static Future<dynamic> login({ User user }) async {
    http.Response res = await http.post('$serverURL/app/login', body: user.toJSON());

    if(res.statusCode == 200) {
      Map<String, dynamic> resBody = jsonDecode(res.body);
      if(resBody['authenticated'].toString().toLowerCase() == 'true') {
        print('lastConnectedTime: ${resBody['lastConnectionTime']}');
        return true;
      } else {
        print('description: ${resBody['description']}');
      }
    }
    return false;

  }
}

class User {
  String username;
  String password;

  User(this.username, this.password);

  Map<String, String> toJSON() {
    return {
      'username': username,
      'password': password
    };
  }
}