import 'dart:convert';

import 'package:http/http.dart' as http;

class HttpServices {
  static bool _isDebug = true;
  static String _devURL = 'http://10.0.0.17:8810';
  
  static String get serverURL {
   return _isDebug ? 
      _devURL
    : 
      // The production server
      'https://real-server.com'
    ;
  }

  static Future<User> login({ Map<String, String> cred }) async {
    http.Response res = await http.post(
      '$serverURL/app/login', 
      body: cred
    );

    if(res.statusCode == 200) {
      Map<String, dynamic> resBody = jsonDecode(res.body);      
      
      if(resBody['auth'].toString().toLowerCase() == 'true') {
        return User.fromJSON(resBody['user']);
      }
    }
    
    return null;
  }
}

class UserCred {
  String username;
  String password;

  UserCred({ this.username, this.password });

  Map<String, dynamic> toJSON() {
    return {
      'username': username,
      'password': password
    };
  }

  UserCred fromJSON(Map<String, dynamic> json) {
    return UserCred(username: json['username'].toString(), password: json['password'].toString());
  }
}

class User {
  String username;
  String password;
  String email;
  String name;
  String profileImage;
  int lastConnected;

  User({ 
    this.username, 
    this.password, 
    this.email,
    this.name, 
    this.profileImage, 
    this.lastConnected 
  });

  Map<String, dynamic> toJSON() {
    return {
      'username': username,
      'password': password,
      'email': email,
      'name': name,
      'profileImage': profileImage,
      'lastConnected': lastConnected
    };
  }

  static User fromJSON(Map<String, dynamic> json) {
    return User(
      username: json['username'],
      password: json['password'],
      email: json['email'],
      name: json['name'],
      profileImage: json['profileImage'],
      lastConnected: json['lastConnected']
    );
  }

  @override
  String toString() {
    return toJSON().toString();
  }
}