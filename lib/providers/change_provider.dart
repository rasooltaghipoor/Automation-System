import 'package:flutter/foundation.dart';

enum ScreenName { requestList, addRequest, editRequest, viewRequest }

// This class is responsible for changing the widgets in main part of home screen.
class ChangeProvider extends ChangeNotifier {
  ScreenName _screenName = ScreenName.requestList;

  Map<String, String> _params = <String, String>{};

  ScreenName? get screenName => _screenName;
  Map<String, String>? get params => _params;

  void setMenu(ScreenName name, Map<String, String> params) {
    _screenName = name;
    _params = params;
    notifyListeners();
  }
}
