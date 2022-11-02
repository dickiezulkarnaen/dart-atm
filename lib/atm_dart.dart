
import 'dart:convert';
import 'dart:io';
import 'package:atm_dart/extentions.dart';

import 'user.dart';


final file = File('users.txt');
final _users = <User>[];

Future<void> loadDataFromFile() async {
  final usersFile = utf8.decoder.bind(file.openRead()).transform(const LineSplitter());
  _users.clear();
  await for (final line in usersFile) {
    _users.add(User.fromJson(line));
  }
}

Future<void> writeDataToFile() async {
  await file.writeAsString('', mode: FileMode.write);
  final openFile = file.openWrite(mode: FileMode.append);
  for (var element in _users) {
    openFile.writeln(element.toJson());
  }
}

Future<void> syncData() async {
  await writeDataToFile();
  await loadDataFromFile();
}

void login(String? name) async {
  if (name != null && name.isNotEmpty) {
    final isExist = _isNameDoesExist(name);
    if (isExist) {
      final user = _users.find((element) => element.name == name);
      for (var element in _users) {
        element.isLoggedIn = user?.name == element.name;
      }
      if (user != null) {
        _home(user);
        await syncData();
      }
    } else {
      _addNewUser(name);
    }
  } else {
    stdout.writeln('Please insert your name correctly');
  }
}

void deposit(String? amount) async {
  if (currentLoggedInUser() == null) {
    stdout.writeln('Please login first');
    return;
  }
  if (amount != null && _isAmountValid(amount)) {
    currentLoggedInUser()?.balance += int.parse(amount);
    await syncData();
    stdout.writeln('Your balance is \$${currentLoggedInUser()?.balance}');
  } else {
    stdout.writeln('Please insert your amount correctly');
  }
}

void withDraw(String? amount) async {
  if (currentLoggedInUser() == null) {
    stdout.writeln('Please login first');
    return;
  }
  if (amount != null && _isAmountValid(amount)) {
    currentLoggedInUser()?.balance -= int.parse(amount);
    await syncData();
    stdout.writeln('Your balance is \$${currentLoggedInUser()?.balance}');
  } {
    stdout.writeln('Please insert your amount correctly');
  }
}

void transfer(String? target, String? amount) async {
  stdout.writeln('transfer : $target $amount');
  if (currentLoggedInUser() == null) {
    stdout.writeln('Please login first');
    return;
  }if (currentLoggedInUser() == null) {
    stdout.writeln('Please login first');
    return;
  }
  if (target == null || target.isNotEmpty) {
    stdout.writeln('Please insert your name correctly');
    return;
  }
  if (!_isNameDoesExist(target)) {
    stdout.writeln('User not registered');
    return;
  }
  if (currentLoggedInUser()?.name == target) {
    stdout.writeln('Please select another receiver');
    return;
  }
  if (_isAmountValid(amount)) {
    stdout.writeln('Please insert your amount correctly');
    return;
  }
  currentLoggedInUser()?.balance -= int.parse(amount ?? '0');
  _users.find((element) => element.name == target)?.balance += int.parse(amount ?? '0');
  stdout.writeln('Transfered \$$amount to $target}');
  stdout.writeln('Your balance is \$${currentLoggedInUser()?.balance}');
  //wait syncData();
}

void logout() async {
  if (currentLoggedInUser() == null) {
    stdout.writeln('No logged in user');
    return;
  }
  currentLoggedInUser()?.isLoggedIn = false;
  stdout.writeln('Thank You for using ATM');
  await syncData();
}

bool _isAmountValid(String? s) {
  stdout.writeln('_isAmountValid : $s');
  if (s == null) {
    return false;
  } else {
    return int.tryParse(s) != null;
  }
}

bool _isNameDoesExist(String name) {
  bool exist = false;
  if (_users.isNotEmpty) {
    for (var element in _users) {
      if (element.name == name) {
        exist = true;
        break;
      }
    }
  }
  return exist;
}

void _addNewUser(String? name) async {
  if (name != null && name.isNotEmpty) {
    final user = User(name: name, balance: 0, isLoggedIn: true);
    for (var element in _users) {
      element.isLoggedIn = user.name == element.name;
    }
    _users.add(user);
    _home(user);
    await syncData();
  } else {
    stdout.writeln('Please Insert Your Name');
  }
}

void _home(User user) {
  stdout.writeln('Hi, ${user.name}');
  stdout.writeln('Your balance is \$${user.balance}');
}

User? currentLoggedInUser() {
  for (var element in _users) { stdout.writeln('${element.name} ${element.isLoggedIn}'); }
  final current = _users.find((element) => element.isLoggedIn == true);
  stdout.writeln('Current, ${current?.toJson()}');
  return current;
}

void printUsers() {
  for (var element in _users) { stdout.writeln(element.toJson()); }
}
