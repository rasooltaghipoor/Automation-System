import 'dart:async';
import 'package:automation_system/models/User.dart';
import 'package:automation_system/providers/auth.dart';
import 'package:automation_system/providers/user_provider.dart';
import 'package:automation_system/responsive.dart';
import 'package:automation_system/utils/SizeConfiguration.dart';
import 'package:automation_system/utils/shared_vars.dart';
import 'package:automation_system/utils/useful_widgets.dart';
import 'package:automation_system/utils/validators.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  final String userName;

  @override
  _LoginState createState() => _LoginState(this.userName);

  Login(this.userName);
}

class _LoginState extends State<Login> {
  final formKey = new GlobalKey<FormState>();

  String? _username, _password;

  _LoginState(this._username);

  Timer? _timer;

  Future<bool> showNetConnectionPopup() async {
    return await showDialog(
      //show confirm dialogue
      //the return value will be from "Yes" or "No" options
      context: context,
      builder: (context) => netAlertDialog(context),
    ) ??
        false; //if showDialouge had returned null, then return false
  }

  @override
  void initState() {
    super.initState();

    _timer = Timer(const Duration(milliseconds: 3000), () {
      if (!SharedVars.isNetConnected) showNetConnectionPopup();
    });
  }

  @override
  Widget build(BuildContext context) {
    AuthProvider auth = Provider.of<AuthProvider>(context);
    SizeConfig().init(context);
    SharedVars.buttonFontSize = SizeConfig.blockSizeHorizontal! * 4;

    final usernameField = TextFormField(
      autofocus: false,
      validator: validateEmail,
      initialValue: _username,
      onSaved: (value) => _username = value!,
      decoration:
      buildInputDecoration("Confirm password", Icons.account_circle),
    );

    final passwordField = TextFormField(
        autofocus: false,
        obscureText: true,
        validator: (value) =>
        value!.isEmpty ? "لطفا رمز عبور را وارد نمایید." : null,
        onSaved: (value) => _password = value!,
        decoration: buildInputDecoration("Confirm password", Icons.lock),
        inputFormatters: [
          FilteringTextInputFormatter.allow(RegExp("[a-zA-Z0-9]")),
        ]);

    var loading = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        CircularProgressIndicator(),
        Text(" در حال اتصال ... لطفا منتظر بمانید")
      ],
    );

    void doLogin() {
      // if(SharedVars.isNetConnected) {
      final form = formKey.currentState;

      if (form!.validate()) {
        form.save();

        final Future<Map<String, dynamic>> successfulMessage =
        auth.login(_username!, _password!);

        successfulMessage.then((response) {
          if (response['status']) {
            User user = response['user'];

            //******Provider.of<UserProvider>(context, listen: false).setUser(user);
            //SharedVars.currentDate = response['date'];
            Navigator.pushReplacementNamed(context, '/main_screen');
          } else {
            final snackBar = mySnackBar(
                'نام کاربری یا رمز عبور اشتباه است', SharedVars.appBarColor);
            // Find the ScaffoldMessenger in the widget tree
            // and use it to show a SnackBar.
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }
        });
      } else {
        print("فرم نامعتبر است");
      }

      // else {
      //   final snackBar = mySnackBar('عدم اتصال به سرور. لطفا اتصال اینترنت را چک کنید.');
      //   ScaffoldMessenger.of(context).showSnackBar(snackBar);
      // }
    }

    ;

    return SafeArea(
      child: Scaffold(
        appBar: myCustomAppBar('دانشگاه آزاد اسلامی واحد نیشابور',
            SizeConfig.safeBlockVertical! * 10, null),
        body: Container(
          padding: Responsive.isMobile(context) ?
          EdgeInsets.fromLTRB(
              SizeConfig.safeBlockHorizontal! * 15,
              SizeConfig.safeBlockHorizontal! * 10,
              SizeConfig.safeBlockHorizontal! * 15,
              SizeConfig.safeBlockHorizontal! * 10)
              : EdgeInsets.fromLTRB(
              SizeConfig.safeBlockHorizontal! * 30,
              SizeConfig.safeBlockHorizontal! * 10,
              SizeConfig.safeBlockHorizontal! * 30,
              SizeConfig.safeBlockHorizontal! * 10),
          child: ListView(
            children: <Widget>[
              Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/images/Logo Outlook.png",
                      width: SizeConfig.safeBlockHorizontal! * 15,
                      height: SizeConfig.safeBlockHorizontal! * 15 * 1.25,
                    ),
                    const Text(
                      "اپلیکیشن رتبه بندی کارمندان",
                      style: TextStyle(fontFamily: SharedVars.fontFamily),
                    ),
                    SizedBox(height: SizeConfig.safeBlockVertical! * 8),
                    label("نام کاربری"),
                    SizedBox(height: SizeConfig.safeBlockVertical),
                    usernameField,
                    SizedBox(height: SizeConfig.safeBlockVertical! * 2),
                    label("رمز عبور"),
                    SizedBox(height: SizeConfig.safeBlockVertical),
                    passwordField,
                    SizedBox(height: SizeConfig.safeBlockVertical! * 5),
                    auth.loggedInStatus == Status.Authenticating
                        ? loading
                        : longButtons("ورود", doLogin),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
