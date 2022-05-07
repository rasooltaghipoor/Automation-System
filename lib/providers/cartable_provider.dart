import 'package:automation_system/models/Cartable.dart';
import 'package:flutter/foundation.dart';

enum LoadStatus { loading, nothingLoaded, dataLoaded, none }

class CartableProvider extends ChangeNotifier {
  CartableModel? _cartable;
  LoadStatus loadStatus = LoadStatus.none;
  String letterListTitle = '';

  CartableModel? get cartable => _cartable;

  void setCartable(CartableModel newCartable, String title) {
    _cartable = newCartable;
    loadStatus = LoadStatus.dataLoaded;
    letterListTitle = title;
    notifyListeners();
  }

  void setNoData(String title) {
    //_cartable = null;
    loadStatus = LoadStatus.nothingLoaded;
    letterListTitle = title;
    notifyListeners();
  }
}

class ErpCartableProvider extends ChangeNotifier {
  ErpCartableModel? _cartable;
  LoadStatus loadStatus = LoadStatus.none;
  String letterListTitle = '';

  ErpCartableModel? get cartable => _cartable;

  void setCartable(ErpCartableModel newCartable, String title) {
    _cartable = newCartable;
    loadStatus = LoadStatus.dataLoaded;
    letterListTitle = title;
    notifyListeners();
  }

  void setNoData(String title) {
    //_cartable = null;
    loadStatus = LoadStatus.nothingLoaded;
    letterListTitle = title;
    notifyListeners();
  }
}
