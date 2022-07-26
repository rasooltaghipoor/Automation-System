import 'package:automation_system/providers/change_provider.dart';
import 'package:automation_system/screens/erp/dynamic_edit_form.dart';
import 'package:automation_system/screens/erp/erp_intro_screen.dart';
import 'package:automation_system/screens/erp/list_of_messages.dart';
import 'package:automation_system/screens/erp/list_of_requests.dart';
import 'package:automation_system/screens/erp/reuqest_selection.dart';
import 'package:automation_system/screens/erp/view_request.dart';
import 'package:automation_system/screens/erp/role_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

/// This class is responsible for changing the active page in middle of the main screen
class MiddleScreenSelector extends StatelessWidget {
  const MiddleScreenSelector({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ChangeProvider>(
        builder: (context, requestListModel, child) {
      //TODO: This code can be changed to setState method!
      switch (requestListModel.screenName) {
        case ScreenName.introScreen:
          return const ErpIntroScreen();
        case ScreenName.requestList:
          return ListOfRequests();
        case ScreenName.addRequest:
          return ListOfRequests();
        case ScreenName.editRequest:
          return DynamicEditForm(
            isEdit: requestListModel.params!['edit'],
            itemsData: requestListModel.params!['itemData'],
          );
        case ScreenName.viewRequest:
          return ViewRequestScreen(
            canManage: requestListModel.params!['canManage'],
            // itemData: getRequestDetails(context),
          );
        case ScreenName.messageList:
          return ListOfMessages(
            requestListModel.params!['itemData'],
          );
        case ScreenName.requestMenuScreen:
          return RequestSelectionWidget(
            title: requestListModel.params!['title'],
          );
        case ScreenName.roleScreen:
          // return RoleScreenWidget(userRoleModel: getUserRoles(context));
          return RoleScreen();
        default:
          return ListOfRequests();
      }
    });
  }
}
