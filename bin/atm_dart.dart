import 'dart:io';

import 'package:args/args.dart';
import 'package:atm_dart/atm_dart.dart';
import 'package:atm_dart/atm_menu.dart';

void main(List<String> arguments) async {
  final parser = ArgParser();
  for (var element in MenuName.values) {
    final command = ArgParser();
    command.addOption(element.name.toLowerCase(), abbr: element.name.substring(0, 1));
    parser.addCommand(element.name.toLowerCase(), command);
  }
  final result = parser.parse(arguments);
  final command = result.command?.name;
  await loadDataFromFile(); // Storage
  switch (command) {
    case 'login': {
      final name = result.command?.arguments[0];
      login(name);
      break;
    }
    case 'deposit': {
      final amount = result.command?.arguments[0];
      deposit(amount);
      break;
    }
    case 'withdraw': {
      final amount = result.command?.arguments[0];
      withDraw(amount);
      break;
    }
    case 'transfer': {
      final target = result.command?.arguments[0];
      final amount = result.command?.arguments[1];
      transfer(target, amount);
      break;
    }
    case 'current': {
      currentLoggedInUser();
      break;
    }
    case 'print': {
      printUsers();
      break;
    }
    case 'logout': {
      logout();
      break;
    }
    default: {
      // SHOW HELP
    }
  }
}
