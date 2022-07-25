import 'package:automation_system/screens/temp/buy_process/components/item_data.dart';
import 'package:automation_system/utils/SizeConfiguration.dart';
import 'package:flutter/material.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';

class BuyRequestScreen extends StatefulWidget {
  const BuyRequestScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _BuyRequestScreenState();
}

class _FormData {
  String vacationType = '';
  String startDate = '';
  String dayNo = '';
  String desc = '';
}

class _BuyRequestScreenState extends State<BuyRequestScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _FormData _data = _FormData();
  TextEditingController dateController = TextEditingController();
  String dropdownValue = 'فنی مهندسی';

  var departments = {
    'فنی مهندسی': '1',
    'علوم پایه': '2',
    'علوم انسانی': '3',
    'تربیت بدنی': '4',
    'دانشکده مهارت (سما)': '5'
  };

  List<Widget> _itemList = [];

  void _addItemWidget() {
    setState(() {
      print('dddddddddddddddddddddddddd');
      _itemList.add(ItemWidget());
    });
  }

  void submit() {
    final form = _formKey.currentState;

    if (form!.validate()) {
      form.save();

      print('Printing the login data.');
      print('Email: ${_data.vacationType}');
      print('Password: ${_data.desc}');
    }
  }

  @override
  void initState() {
    dateController.text = '1401/01/20'; //SharedVars.currentDate;
    _addItemWidget();
    super.initState();
  }

  @override
  void dispose() {
    dateController.dispose();
    super.dispose();
  }

  Future<void> _showDatePicker() async {
    Jalali? picked = await showPersianDatePicker(
      context: context,
      initialDate: Jalali.now(),
      firstDate: Jalali(1385, 8),
      lastDate: Jalali(1450, 9),
    );
    if (picked != null) {
      dateController.text = picked.formatCompactDate();
    }
    //return picked!.formatFullDate();
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    //TODO This line of code should be removed in the future
    SizeConfig().init(context);

    return Scaffold(
      body: Container(
          margin: const EdgeInsets.all(20),
          child: Directionality(
              textDirection: TextDirection.rtl,
              child: Form(
                key: _formKey,
                child: ListView(
                  children: <Widget>[
                    Row(children: <Widget>[
                      const Text("انتخاب دانشکده:"),
                      Expanded(
                          child: Container(
                              alignment: Alignment.center,
                              padding: EdgeInsets.all(
                                  SizeConfig.safeBlockHorizontal! * 3),
                              child: DropdownButton<String>(
                                //hint: new Text("انتخاب ساختمان"),
                                isExpanded: true,
                                value: dropdownValue,
                                //icon: const Icon(Icons.arrow_downward),
                                iconSize: 24,
                                elevation: 16,
                                style:
                                    const TextStyle(color: Colors.deepPurple),
                                underline: Container(
                                  height: 2,
                                  color: Colors.deepPurpleAccent,
                                ),
                                onChanged: (String? newValue) {
                                  setState(() {
                                    dropdownValue = newValue!;
                                  });
                                },
                                items: departments.keys
                                    .map<DropdownMenuItem<String>>(
                                        (String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(
                                      value,
                                      textAlign: TextAlign.center,
                                    ),
                                  );
                                }).toList(),
                              ))),
                    ]),
                    TextFormField(
                        obscureText: false, // Use secure text for passwords.
                        decoration: const InputDecoration(
                            hintText: 'تاریخ',
                            labelText: 'برای انتخاب کلیک کنید.'),
                        validator: (value) {},
                        onTap: _showDatePicker,
                        controller: dateController,
                        onSaved: (value) {
                          _data.startDate = value!;
                        }),
                    TextFormField(
                        keyboardType: TextInputType
                            .emailAddress, // Use email input type for emails.
                        decoration: const InputDecoration(
                            hintText: 'مثال: 5', labelText: 'تعداد روز'),
                        validator: (value) {},
                        onSaved: (value) {
                          _data.dayNo = value!;
                        }),
                    TextFormField(
                        obscureText: true, // Use secure text for passwords.
                        decoration: const InputDecoration(
                            hintText: 'توضیحات اضافه', labelText: 'توضیحات'),
                        validator: (value) {},
                        onSaved: (value) {
                          _data.desc = value!;
                        }),
                    Container(
                      color: Colors.amber,
                      child: Column(
                        //mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          const Text(
                            'اقلام درخواستی',
                          ),
                          ListView.builder(
                              shrinkWrap: true,
                              itemCount: _itemList.length,
                              itemBuilder: (context, index) {
                                return _itemList[index];
                              }),
                          FloatingActionButton(
                            onPressed: _addItemWidget,
                            tooltip: 'Add',
                            child: const Icon(Icons.add),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: screenSize.width,
                      child: ElevatedButton(
                        child: const Text(
                          'ارسال',
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: submit,
                      ),
                      margin: const EdgeInsets.only(top: 20.0),
                    )
                  ],
                ),
              ))),
    );
  }
}
