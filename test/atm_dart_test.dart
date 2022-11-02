import 'package:atm_dart/atm_dart.dart';
import 'package:test/test.dart';

void main() {
  expect('dicky', currentLoggedInUser()?.name);
}
