import 'dart:convert';

import 'package:finance_manager/services/storage.services.dart';
import 'package:http/http.dart' as http;

class HttpServices {
  static bool _isDebug = true;
  static String _devURL = 'http://10.0.0.41:8010';
  
  static String get serverURL {
   return _isDebug ? 
      _devURL
    : 
      // The production server
      'https://real-server.com'
    ;
  }

  static Future<Map<String, String>> _prepareRequest() async {
    try {
      Map<String, dynamic> cred = await StorageH.getJSON(StoragePaths.LoginCred);
      UserCred userCred = UserCred.fromJSON(cred);

      if(userCred.expDate <= DateTime.now().millisecondsSinceEpoch) {
        await login(emailPass: { 'email': userCred.email, 'password': userCred.password });
        Map<String, dynamic> newCredJSON = await StorageH.getJSON(StoragePaths.LoginCred);
        UserCred newCred = UserCred.fromJSON(cred);

        return newCred.toJSON();
      }

      return userCred.toJSON();
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
}

class UserCred {
  String CredentialsToken; 
  String CredentialsHeaderName;
  int expDate;
  String email;
  String password;

  UserCred(
    this.CredentialsToken, 
    this.CredentialsHeaderName, 
    this.expDate, 
    this.email, 
    this.password
  );

  Map<String, dynamic> toJSON() {
    return {
      'CredentialsToken': CredentialsToken,
      'CredentialsHeaderName': CredentialsHeaderName,
      'expDate': expDate,
      'email': email,
      'password': password
    };
  }

  static UserCred fromJSON(Map<String, dynamic> json) {
    try {
      return UserCred(
        json['CredentialsToken'].toString(),
        json['CredentialsHeaderName'].toString(), 
        int.parse(json['expDate'].toString()),
        json['email'],
        json['password']
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