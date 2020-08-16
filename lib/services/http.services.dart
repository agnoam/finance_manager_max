import 'dart:convert';
import 'package:finance_manager/services/storage.services.dart';
import 'package:http/http.dart' as http;

class HttpServices {
  static bool _isDebug = true;
  static String _devURL = 'http://192.168.1.17:8810';
  static Map<String, String> _defaultHeaders = { 'Content-Type': 'application/json' };
  
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
      if(res.statusCode == ResponseStatus.Ok) {
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
      headers: _defaultHeaders,
      body: jsonEncode(userCred.toJSON())
    );

    if(res.statusCode == ResponseStatus.Ok) {
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
        headers: _defaultHeaders,
        body: jsonEncode(_buildCreds(creds))
      );

      if(res.statusCode == ResponseStatus.Ok) {
        Map<String, dynamic> body = jsonDecode(res.body);
        if(body != null) {
          List data = body['d'];
          if(data.length > 0) {
            BalanceResponse balance = BalanceResponse.fromJSON(body['d'][0]);
            return balance.current;
          } else {
            return 0;
          }
        }
        
        return null;
      }

      throw "Wasn't able to get balance";
    } catch(ex) {
      throw ex;
    }
  }

  static Future<bool> transferMoney(String destAccID, double amount, String pinCode) async {
    try {
      UserCred creds = await _prepareCredentials();
      http.Response res = await http.post('$serverURL/app/transfer-amount', headers: _defaultHeaders,
        body: jsonEncode({
          ..._buildCreds(creds),
          'destAccID': destAccID,
          'amount': amount,
          'pinCode': pinCode,
          'currencyIso': "ILS",
          'text': 'Message'
        })
      );

      return res.statusCode == ResponseStatus.Ok;
    } catch(ex) {
      print('http ex, $ex');
    }

    return false;
  }

  static Map<String, dynamic> _buildCreds(UserCred creds) {
    return {
      'creds': {
        'id': creds.id,
        'CredentialsHeaderName': creds.credentialsHeaderName,
        'CredentialsToken': creds.credentialsToken
      }
    };
  }

  static Future<List<Page>> getRows({ 
    String currencyIso = 'ILS', 
    int pageNumber = 1, 
    int pageSize = 20 
  }) async {
    try {
      UserCred creds = await _prepareCredentials();
      http.Response res = await http.post('$serverURL/app/get-rows', headers: _defaultHeaders, 
        body: jsonEncode({
          ..._buildCreds(creds), 'filters': { 'CurrencyIso': currencyIso }, 
          'sortAndPage': { 'PageNumber': pageNumber, 'PageSize': pageSize }
        }
      ));

      if(res.statusCode == ResponseStatus.Ok) {
        Map<String, dynamic> resBody = jsonDecode(res.body);
        List pagesBuffer = resBody['data'];
        List<Page> toReturn = [];

        for(Map pageJson in pagesBuffer) {
          toReturn.add(Page.fromJSON(pageJson));
        }

        return toReturn;
      }

      return null;
    } catch(ex) {
      throw ex;
    }
  }
}

class Page {
  int amount;
  String balanceTransferType;
  String balanceTransferTypeName;
  String comment;
  String currencyIso;
  int id;
  String insertDate;
  bool isPending;
  int sourceAccountID;
  String sourceAccountName;
  String sourceAccountProfileImage;
  int sourceAccountProfileImageSize;
  String sourceAccountType;
  int sourceID;
  String sourceType;
  int targetAccountID;
  String targetAccountName;
  String targetAccountProfileImage;
  int targetAccountProfileImageSize;
  String targetAccountType;
  String text;
  double total;

  Page({ 
    this.amount, this.balanceTransferType, 
    this.balanceTransferTypeName, this.comment, 
    this.currencyIso, this.id, this.insertDate,
    this.isPending, this.sourceAccountID, 
    this.sourceAccountName, this.sourceAccountProfileImage, 
    this.sourceAccountProfileImageSize,
    this.sourceAccountType, this.sourceID, this.sourceType, 
    this.targetAccountID, this.targetAccountName, this.targetAccountProfileImage, 
    this.targetAccountProfileImageSize, this.targetAccountType, 
    this.text, this.total
  });

  static Page fromJSON(Map<String, dynamic> json) {
    try {
      return Page(
        amount: int.parse(json['Amount'].toString()),
        balanceTransferType: json['BalanceTransferType'].toString(),
        balanceTransferTypeName: json['BalanceTransferTypeName'].toString(),
        comment: json['Comment'].toString(),
        currencyIso: json['CurrencyIso'].toString(),
        id: int.parse(json['ID'].toString()),
        insertDate: json['InsertDate'].toString(),
        isPending: json['IsPending'].toString().toLowerCase() == 'true',
        sourceAccountID: int.parse(json['SourceAccountID'].toString()),
        sourceAccountName: json['SourceAccountName'].toString(),
        sourceAccountProfileImage: json['SourceAccountProfileImage'].toString(),
        sourceAccountProfileImageSize: int.parse(json['SourceAccountProfileImageSize'].toString()),
        sourceAccountType: json['SourceAccountType'].toString(),
        sourceID: int.parse(json['SourceID'].toString()),
        sourceType: json['SourceType'].toString(),
        targetAccountID: int.parse(json['TargetAccountID'].toString()),
        targetAccountName: json['TargetAccountName'].toString(),
        targetAccountProfileImage: json['TargetAccountProfileImage'].toString(),
        targetAccountProfileImageSize: int.parse(json['TargetAccountProfileImageSize'].toString()),
        targetAccountType: json['TargetAccountType'].toString(),
        text: json['Text'].toString(),
        total: double.parse(json['Total'].toString())
      );
    } catch(ex) {
      throw 'generate page from json ex: $ex';
    }
  }

  Map<String, dynamic> toJSON() {
    return {
      'Amount': amount,
      'BalanceTransferType': balanceTransferType,
      'BalanceTransferTypeName': balanceTransferTypeName,
      'Comment': comment,
      'CurrencyIso': currencyIso,
      'ID': id,
      'InsertDate': insertDate,
      'IsPending': isPending,
      'SourceAccountID': sourceAccountID,
      'SourceAccountName': sourceAccountName,
      'SourceAccountProfileImage': sourceAccountProfileImage,
      'SourceAccountProfileImageSize': sourceAccountProfileImageSize,
      'SourceAccountType': sourceAccountType,
      'SourceID': sourceID,
      'SourceType': sourceType,
      'TargetAccountID': targetAccountID,
      'TargetAccountName': targetAccountName,
      'TargetAccountProfileImage': targetAccountProfileImage,
      'TargetAccountProfileImageSize': targetAccountProfileImageSize,
      'TargetAccountType': targetAccountType,
      'Text': text,
      'Total': total
    };
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

class ResponseStatus {
  static const int NoContent = 204;
  static const int NotFound = 404;
  static const int BadRequest = 400;
  static const int Unauthorized = 401;
  static const int InternalError = 500;
  static const int NotImplemented = 501;
  static const int Ok = 200;
  static const int Created = 201;
  static const int Accepted = 202;
  static const int Found = 302;
}