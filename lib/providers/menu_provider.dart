import 'package:automation_system/models/MenuDetails.dart';
import 'package:flutter/foundation.dart';

class ErpMenuProvider extends ChangeNotifier {
  ErpSideMenuModel? _sideMenu;

  ErpSideMenuModel? get sideMenu => _sideMenu;

  void setMenu(ErpSideMenuModel menu) {
    _sideMenu = menu;
    notifyListeners();
  }
}

class MenuProvider extends ChangeNotifier {
  SideMenuModel? _sideMenu;

  SideMenuModel? get sideMenu => _sideMenu;

  void setMenu(SideMenuModel menu) {
    _sideMenu = menu;
    notifyListeners();
  }
}
