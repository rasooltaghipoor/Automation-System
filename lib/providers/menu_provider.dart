import 'package:automation_system/models/MenuDetails.dart';
import 'package:flutter/foundation.dart';

class ErpMenuProvider extends ChangeNotifier {
  ErpSideMenuModel? _sideMenu;
  int _activeIndex = -1;

  ErpSideMenuModel? get sideMenu => _sideMenu;
  int get activeIndex => _activeIndex;

  void setMenu(ErpSideMenuModel menu) {
    _sideMenu = menu;
    notifyListeners();
  }

  void setActiveIndex(int index, bool notify) {
    _activeIndex = index;
    if (notify) notifyListeners();
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
