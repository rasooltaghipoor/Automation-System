import 'package:automation_system/models/Cartable.dart';
import 'package:flutter/foundation.dart';

class CartableProvider extends ChangeNotifier {
  CartableModel? _cartable;

  CartableModel? get cartable => _cartable;

  void setCartable(CartableModel cartable) {
    _cartable = cartable;
    notifyListeners();
  }
}
