import 'dart:convert';

import 'package:http/http.dart' as http;

class HttpServices {
  static bool _isDebug = true;
  static String _devURL = 'http://10.0.0.41:8010';
  
  static String get serverURL {
   return _isDebug ? 
      _devURL
    : 
      // The production server
      'https://real-server.com';
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

  static Future<NewUserCred> signup({ NewUserCred userCred }) async {
    http.Response res = await http.post(
      '$serverURL/app/sign-up',
      body: userCred.toJSON()
    );

    if(res.statusCode == 200) {
      Map<String, dynamic> resBody = jsonDecode(res.body);

      if(resBody['isCreated'].toString().toLowerCase() == 'true'){
        return NewUserCred.fromJSON(resBody['user']);
      }
    }
  }
}

class NewUserData {
  String password;
  String pinCode;

  NewUserData({ this.password, this.pinCode });

  Map<String, String> toJSON() {
    return {
      'password': password,
      'pinCode': pinCode
    };
  }

  static NewUserData fromJSON(Map<String, dynamic> json) {
    return NewUserData(
      password: json['password'].toString(),
      pinCode: json['pinCode'].toString()
    );
  }
}

class NewUserInfo {
  String addressLine;
  String city;
  String country;
  String email;
  String firstname;
  String lastname;
  String postalCode;

  NewUserInfo({
    this.addressLine,
    this.city,
    this.country,
    this.email,
    this.firstname,
    this.lastname,
    this.postalCode
  });

  Map<String, String> toJSON() {
    return {
      'addressLine': addressLine,
      'city': city,
      'country': country,
      'email': email,
      'firstname': firstname,
      'lastname': lastname,
      'postalCode': postalCode,
    };
  }

  static NewUserInfo fromJSON(Map<String, dynamic> json) {
    return NewUserInfo(
      addressLine: json['addressLine'].toString(),
      city: json['city'].toString(),
      country: json['country'].toString(),
      email: json['email'].toString(),
      firstname: json['firstname'].toString(),
      lastname: json['lastname'].toString(),
      postalCode: json['postalCode'].toString()
    );
  }

  @override
  String toString() {
    return '''{ 
      addressLine: ${addressLine.toString()}, 
      city: ${city.toString()}, 
      country: ${country.toString()}, 
      email: ${email.toString()}, 
      firstname: ${firstname.toString()}, 
      lastname: ${lastname.toString()}, 
      postalCode: ${postalCode.toString()}
    }''';
  }
}

class NewUserCred {
  NewUserData data;
  NewUserInfo info;

  NewUserCred(this.data, this.info);

  Map<String, dynamic> toJSON() {
    return {
      'data': data.toJSON(),
      'info': info.toJSON()
    };
  }

  static NewUserCred fromJSON(Map<String, dynamic> json) {
    return NewUserCred(
      NewUserData.fromJSON(json['data']), 
      NewUserInfo.fromJSON(json['info'])
    );
  }

  @override
  String toString() {
    return '{ data: ${data.toString()}, info: ${info.toString()}';
  }
}

// {
// 	"data": {
//     	"password": "aabb1122",
//     	"pinCode": "1310"
// 	},
// 	"info": {
// 		"addressLine": "barkat 14",
//     	"city": "holon",
//     	"country": "IL",
//     	"email": "el@sapdan.com",
//     	"firstname": "Yehuda",
//     	"lastname": "D",
//     	"postalCode": "00000"
//     }
// }

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