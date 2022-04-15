import 'package:flutter/material.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';

class DailyRequestScreen extends StatefulWidget {
  const DailyRequestScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _DailyRequestScreenState();
}

class _FormData {
  String email = '';
  String password = '';
  String data = '';
}

class _DailyRequestScreenState extends State<DailyRequestScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _FormData _data = _FormData();
  TextEditingController dateController = TextEditingController();

  void submit() {
    final form = _formKey.currentState;

    if (form!.validate()) {
      form.save();

      print('Printing the login data.');
      print('Email: ${_data.email}');
      print('Password: ${_data.password}');
    }
  }

  @override
  void initState() {
    dateController.text = '1401/01/20'; //SharedVars.currentDate;

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

    return Scaffold(
      body: Container(
          padding: EdgeInsets.all(20.0),
          child: Directionality(
              textDirection: TextDirection.rtl,
              child: Form(
                key: _formKey,
                child: ListView(
                  children: <Widget>[
                    TextFormField(
                        keyboardType: TextInputType
                            .emailAddress, // Use email input type for emails.
                        decoration: const InputDecoration(
                            hintText: 'you@example.com',
                            labelText: 'E-mail Address'),
                        validator: (value) {},
                        onSaved: (value) {
                          _data.email = value!;
                        }),
                    TextFormField(
                        obscureText: true, // Use secure text for passwords.
                        decoration: const InputDecoration(
                            hintText: 'Password',
                            labelText: 'Enter your password'),
                        validator: (value) {},
                        onSaved: (value) {
                          _data.password = value!;
                        }),
                    TextFormField(
                        obscureText: false, // Use secure text for passwords.
                        decoration: const InputDecoration(
                            hintText: 'تاریخ',
                            labelText: 'برای انتخاب کلیک کنید.'),
                        validator: (value) {},
                        onTap: _showDatePicker,
                        controller: dateController,
                        onSaved: (value) {
                          _data.password = value!;
                        }),
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
