import 'package:automation_system/models/Cartable.dart';
import 'package:flutter/foundation.dart';

enum LoadStatus{
  loading,
  nothingLoaded,
  dataLoaded,
  none
}
class CartableProvider extends ChangeNotifier {
  CartableModel? _cartable;
  LoadStatus loadStatus = LoadStatus.none;

  CartableModel? get cartable => _cartable;

  void setCartable(CartableModel newCartable) {
    _cartable = newCartable;
    loadStatus = LoadStatus.dataLoaded;
    notifyListeners();
  }

  void setNoData() {
    //_cartable = null;
    loadStatus = LoadStatus.nothingLoaded;
    notifyListeners();
  }
}
