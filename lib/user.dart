/// *
/// Author         : Dicky Zulkarnain
/// Date           : 08/10/22
/// Original File  : user
///**/

import 'dart:convert';

class User {
  User({
    required this.name,
    this.balance = 0,
    this.isLoggedIn = false,
  });

  String name;
  int balance;
  bool isLoggedIn;

  factory User.fromJson(String str) => User.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory User.fromMap(Map<String, dynamic> json) => User(
    name: json["name"],
    balance: json["balance"],
    isLoggedIn: json["isLoggedIn"],
  );

  Map<String, dynamic> toMap() => {
    "name": name,
    "balance": balance,
    "isLoggedIn": isLoggedIn,
  };
}
