import 'package:flutter/foundation.dart';

enum ScreenName {
  requestList,
  messageList,
  addRequest,
  editRequest,
  viewRequest,
  introScreen,
  requestMenuScreen,
  roleScreen,
}

// This class is responsible for changing the widgets in main part of home screen.
class ChangeProvider extends ChangeNotifier {
  ScreenName _screenName = ScreenName.introScreen;

  Map<String, dynamic> _params = <String, dynamic>{};

  ScreenName? get screenName => _screenName;
  Map<String, dynamic>? get params => _params;

  void setMidScreen(ScreenName name, Map<String, dynamic>? params) {
    _screenName = name;
    _params = params!;
    notifyListeners();
  }
}
