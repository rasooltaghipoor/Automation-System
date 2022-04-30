import 'package:automation_system/models/Cartable.dart';
import 'package:automation_system/models/RequestList.dart';
import 'package:flutter/foundation.dart';

enum LoadStatus { loading, nothingLoaded, dataLoaded, none }

class RequestListProvider extends ChangeNotifier {
  RequestListModel? _requestList;
  LoadStatus loadStatus = LoadStatus.none;
  String listTitle = '';

  RequestListModel? get requestList => _requestList;

  void setRequestList(RequestListModel newList, String title) {
    _requestList = newList;
    loadStatus = LoadStatus.dataLoaded;
    listTitle = title;
    notifyListeners();
  }

  void setNoData(String title) {
    //_cartable = null;
    loadStatus = LoadStatus.nothingLoaded;
    listTitle = title;
    notifyListeners();
  }
}
