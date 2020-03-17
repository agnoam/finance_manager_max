import 'dart:convert';
import 'package:finance_manager/services/storage.services.dart';
import 'package:http/http.dart' as http;

class HttpServices {
  static bool _isDebug = true;
  static String _devURL = 'http://192.168.1.22:8810';
  
  static String get serverURL {
   return _isDebug ? 
      _devURL
    : 
      // The production server
      'https://real-server.com';
  }

  static Future<UserCred> _prepareCredentials() async {
    try {
      Map<String, dynamic> cred = await StorageH.getJSON(StoragePaths.LoginCred);
      UserCred userCred = UserCred.fromJSON(cred);

      if(userCred.expDate > DateTime.now().millisecondsSinceEpoch) {
        await login(emailPass: { 'email': userCred.email, 'password': userCred.password });
        Map<String, dynamic> newCredJSON = await StorageH.getJSON(StoragePaths.LoginCred);
        UserCred newCred = UserCred.fromJSON(newCredJSON);

        return newCred;
      }

      return userCred;
    } catch(ex) {
      throw ex;
    }
  }

  static Future<bool> login({ Map<String, String> emailPass }) async {
    try {
      http.Response res = await http.post('$serverURL/app/login', body: emailPass);
      if(res.statusCode == 200) {
        Map<String, dynamic> resBody = jsonDecode(res.body);      
        
        if(resBody['auth'].toString().toLowerCase() == 'true') {
          Map<String, dynamic> creds = resBody['cred'];
          creds['expDate'] = resBody['expDate'];
          creds['email'] = emailPass['email'];
          creds['password'] = emailPass['password'];

          StorageH.setJSON(StoragePaths.LoginCred, UserCred.fromJSON(creds).toJSON());
          return true;
        }
      }
    } catch(ex) {
      print(ex);
    }
    return false;
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
    return null;
  }

  static Future<double> getBalance() async {
    try {
      UserCred creds = await _prepareCredentials();
      http.Response res = await http.post('$serverURL/app/get-balance', 
        headers: { 'content-type': 'application/json' },
        body: jsonEncode({
          'creds': {
            'id': creds.id,
            'CredentialsHeaderName': creds.credentialsHeaderName,
            'CredentialsToken': creds.credentialsToken
          }
        })
      );

      if(res.statusCode == 200) {
        Map<String, dynamic> body = jsonDecode(res.body);
        if(body != null) {
          BalanceResponse balance = BalanceResponse.fromJSON(body['d'][0]);
          return balance.current;
        }
        return null;
      }

      throw 'Did not able to get balance';
    } catch(ex) {
      throw ex;
    }
  }

  static Future<bool> transferMoney(String destAccID, double amount, String pinCode) async {
    try {
      UserCred creds = await _prepareCredentials();
      http.Response res = await http.post(
        '$serverURL/app/transfer-amount', 
        headers: { 'content-type': 'application/json' },
        body: jsonEncode({
          'creds': {
            'id': creds.id,
            'CredentialsHeaderName': creds.credentialsHeaderName,
            'CredentialsToken': creds.credentialsToken
          },
          'destAccID': destAccID,
          'amount': amount,
          'pinCode': pinCode,
          'currencyIso': "ILS",
          'text': 'Message'
        })
      );

      return res.statusCode == 200;
    } catch(ex) {
      print('http ex, $ex');
    }

    return false;
  }
}

class BalanceResponse {
  String currencyIso;
  double current; // Balance
  double expected;
  double pending;

  BalanceResponse({ this.currencyIso, this.current, this.expected, this.pending });

  Map<String, dynamic> toJSON() {
    return {
      'CurrencyIso': currencyIso,
      'Content': current,
      'Expected': expected,
      'Pending': pending
    };
  }

  static BalanceResponse fromJSON(Map<String, dynamic> json) {
    try {
      return BalanceResponse(
        current: double.parse(json['Current'].toString()), 
        expected: double.parse(json['Expected'].toString()), 
        currencyIso: json['CurrencyIso'].toString(),
        pending: double.parse(json['Pending'].toString())
      );
    } catch(ex) {
      throw ex;
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

class UserCred {
  // CoriunderCredentials
  String id;
  String credentialsToken; 
  String credentialsHeaderName;
  
  int expDate;
  
  // username password of client
  String email;
  String password;

  UserCred(
    this.credentialsToken, 
    this.credentialsHeaderName, 
    this.expDate, 
    this.email, 
    this.password,
    this.id
  );

  Map<String, dynamic> toJSON() {
    return {
      'CredentialsToken': credentialsToken,
      'CredentialsHeaderName': credentialsHeaderName,
      'expDate': expDate,
      'email': email,
      'password': password,
      'id': id
    };
  }

  static UserCred fromJSON(Map<String, dynamic> json) {
    try {
      return UserCred(
        json['CredentialsToken'].toString(),
        json['CredentialsHeaderName'].toString(), 
        int.parse(json['expDate'].toString()),
        json['email'],
        json['password'],
        json['id']
      );
    } catch(ex) {
      throw ex;
    }
  }

  @override
  String toString() {
    return toJSON().toString();
  }
}