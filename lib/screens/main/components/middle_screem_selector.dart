import 'package:automation_system/providers/change_provider.dart';
import 'package:automation_system/screens/email/email_screen.dart';
import 'package:automation_system/screens/email/request_screen.dart';
import 'package:automation_system/screens/erp/list_of_requests.dart';
import 'package:automation_system/screens/erp/view_request.dart';
import 'package:automation_system/utils/communication/web_request.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class MiddleScreenSelector extends StatelessWidget {
  const MiddleScreenSelector({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ChangeProvider>(
        builder: (context, requestListModel, child) {
      //TODO: This code ca be changed to setState method!
      switch (requestListModel.screenName) {
        case ScreenName.requestList:
          return ListOfRequests();
        case ScreenName.addRequest:
          return ListOfRequests();
        case ScreenName.editRequest:
          return ListOfRequests();
        case ScreenName.viewRequest:
          return ViewRequestScreen(
            itemData: getRequestDetails(context),
          );
        default:
          return ListOfRequests();
      }

      // return requestListModel.requestList == null
      //     ? const Center(child: CircularProgressIndicator())
    });
  }
}
