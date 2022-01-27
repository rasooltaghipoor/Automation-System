import 'package:automation_system/components/side_menu.dart';
import 'package:automation_system/models/Email.dart';
import 'package:automation_system/responsive.dart';
import 'package:automation_system/screens/email/email_screen.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:websafe_svg/websafe_svg.dart';
import 'package:syncfusion_flutter_core/theme.dart';

import '../../../constants.dart';
import 'email_card.dart';

import 'package:flutter/foundation.dart' show kIsWeb;

class EmailGridView extends StatefulWidget {
  // Press "Command + ."
  const EmailGridView({
    Key? key,
  }) : super(key: key);

  @override
  _EmailGridViewState createState() => _EmailGridViewState();
}

class _EmailGridViewState extends State<EmailGridView> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  List<Employee> employees = <Employee>[];
  late EmployeeDataSource employeeDataSource;

  @override
  void initState() {
    super.initState();
    employees = getEmployeeData();
    employeeDataSource = EmployeeDataSource(employeeData: employees);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        drawer: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 250),
          child: const SideMenu(),
        ),
        body: Container(
          padding: EdgeInsets.only(top: kIsWeb ? kDefaultPadding : 0),
          color: kBgDarkColor,
          child: SafeArea(
            right: false,
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: Column(
                children: [
                  // This is our Search bar
                  Padding(
                    padding:
                    const EdgeInsets.symmetric(horizontal: kDefaultPadding),
                    child: Row(
                      children: [
                        // Once user click the menu icon the menu shows like drawer
                        // Also we want to hide this menu icon on desktop
                        if (!Responsive.isDesktop(context))
                          IconButton(
                            icon: const Icon(Icons.menu),
                            onPressed: () {
                              _scaffoldKey.currentState?.openDrawer();
                            },
                          ),
                        if (!Responsive.isDesktop(context)) const SizedBox(
                            width: 5),
                        Expanded(
                          child: TextField(
                            onChanged: (value) {},
                            decoration: InputDecoration(
                              hintText: "جستجو",
                              fillColor: kBgLightColor,
                              filled: true,
                              suffixIcon: Padding(
                                padding: const EdgeInsets.all(
                                    kDefaultPadding * 0.75), //15
                                child: WebsafeSvg.asset(
                                  "assets/Icons/Search.svg",
                                  width: 24,
                                ),
                              ),
                              border: const OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                    Radius.circular(10)),
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: kDefaultPadding),
                  Padding(
                    padding:
                    const EdgeInsets.symmetric(horizontal: kDefaultPadding),
                    child: Row(
                      children: [
                        WebsafeSvg.asset(
                          "assets/Icons/Angle down.svg",
                          width: 16,
                          color: Colors.black,
                        ),
                        const SizedBox(width: 5),
                        const Text(
                          "مرتب سازی بر اساس تاریخ",
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                        const Spacer(),
                        MaterialButton(
                          minWidth: 20,
                          onPressed: () {},
                          child: WebsafeSvg.asset(
                            "assets/Icons/Sort.svg",
                            width: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: kDefaultPadding),
                  Expanded(
                    child: SfDataGridTheme(
                      data: SfDataGridThemeData(
                          headerColor: const Color(0xff009889),
                          headerHoverColor: Colors.blueAccent,
                          rowHoverColor: Colors.blueAccent,
                          rowHoverTextStyle: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                          )),
                      child: SfDataGrid(
                        source: employeeDataSource,
                        columnWidthMode: ColumnWidthMode.fill,
                        allowSorting: true,
                        //rowsPerPage: 5,
                        columns: <GridColumn>[
                          GridColumn(
                              columnName: 'id',
                              label: Container(
                                  padding: const EdgeInsets.all(16.0),
                                  alignment: Alignment.center,
                                  child: const Text(
                                    'ID',
                                  ))),
                          GridColumn(
                              columnName: 'name',
                              label: Container(
                                  padding: const EdgeInsets.all(8.0),
                                  alignment: Alignment.center,
                                  child: const Text('Name'))),
                          GridColumn(
                              columnName: 'designation',
                              label: Container(
                                  padding: const EdgeInsets.all(8.0),
                                  alignment: Alignment.center,
                                  child: const Text(
                                    'Designation',
                                    overflow: TextOverflow.ellipsis,
                                  ))),
                          GridColumn(
                              columnName: 'salary',
                              label: Container(
                                  padding: const EdgeInsets.all(8.0),
                                  alignment: Alignment.center,
                                  child: const Text('Salary'))),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  List<Employee> getEmployeeData() {
    return [
      Employee(10001, 'James', 'Project Lead', 20000),
      Employee(10002, 'Kathryn', 'Manager', 30000),
      Employee(10003, 'Lara', 'Developer', 15000),
      Employee(10004, 'Michael', 'Designer', 15000),
      Employee(10005, 'Martin', 'Developer', 15000),
      Employee(10006, 'Newberry', 'Developer', 15000),
      Employee(10007, 'Balnc', 'Developer', 15000),
      Employee(10008, 'Perry', 'Developer', 15000),
      Employee(10009, 'Gable', 'Developer', 15000),
      Employee(10010, 'Grimes', 'Developer', 15000)
    ];
  }
}

/// Custom business object class which contains properties to hold the detailed
/// information about the employee which will be rendered in datagrid.
class Employee {
  /// Creates the employee class with required details.
  Employee(this.id, this.name, this.designation, this.salary);

  /// Id of an employee.
  final int id;

  /// Name of an employee.
  final String name;

  /// Designation of an employee.
  final String designation;

  /// Salary of an employee.
  final int salary;
}

/// An object to set the employee collection data source to the datagrid. This
/// is used to map the employee data to the datagrid widget.
class EmployeeDataSource extends DataGridSource {
  /// Creates the employee data source class with required details.
  EmployeeDataSource({required List<Employee> employeeData}) {
    _employeeData = employeeData
        .map<DataGridRow>((e) => DataGridRow(cells: [
      DataGridCell<int>(columnName: 'id', value: e.id),
      DataGridCell<String>(columnName: 'name', value: e.name),
      DataGridCell<String>(
          columnName: 'designation', value: e.designation),
      DataGridCell<int>(columnName: 'salary', value: e.salary),
    ]))
        .toList();
  }

  List<DataGridRow> _employeeData = [];

  @override
  List<DataGridRow> get rows => _employeeData;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((e) {
          return Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(8.0),
            child: Text(e.value.toString()),
          );
        }).toList());
  }
}
