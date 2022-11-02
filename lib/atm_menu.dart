/// *
/// Author         : Dicky Zulkarnain
/// Date           : 08/10/22
/// Original File  : atm_menu
///**/

abstract class AtmMenu {

  final String menuName ;
  AtmMenu(this.menuName);

  void run(String command);

}

enum MenuName {
  login,
  deposit,
  withDraw,
  transfer,
  logout,
  current,
  print,
}


