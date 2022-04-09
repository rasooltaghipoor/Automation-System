import 'package:automation_system/utils/SizeConfiguration.dart';
import 'package:automation_system/utils/shared_vars.dart';
import 'package:flutter/material.dart';

/// Some kind og button. Currently, such buttons are just used in login screen
MaterialButton longButtons(String title, VoidCallback fun,
    {Color color: SharedVars.appBarColor, Color textColor: Colors.white}) {
  return MaterialButton(
    onPressed: fun,
    textColor: textColor,
    color: color,
    child: SizedBox(
      width: double.infinity,
      child: Text(
        title,
        textAlign: TextAlign.center,
        style: TextStyle(fontFamily: SharedVars.fontFamily, fontSize: 20),
      ),
    ),
    height: SizeConfig.safeBlockVertical! * 50 * 0.17,
    minWidth: SizeConfig.blockSizeHorizontal! * 80,
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
            Radius.circular(SizeConfig.safeBlockHorizontal! * 4))),
  );
}

label(String title) => Text(title);

InputDecoration buildInputDecoration(String hintText, IconData icon) {
  return InputDecoration(
    prefixIcon: Icon(icon, color: Color.fromRGBO(50, 62, 72, 1.0)),
    // hintText: hintText,
    contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
  );
}

/// A custom app bar for all screens
AppBar myCustomAppBar(String title, double height, Icon? icon) {
  return AppBar(
    backgroundColor: SharedVars.appBarColor,
    leading: icon,
    toolbarHeight: height,
    title: Text(
      title,
      style: TextStyle(fontSize: 20),
    ),
    centerTitle: true,
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
      bottom: Radius.circular(SizeConfig.safeBlockHorizontal! * 7),
    )),
    flexibleSpace: Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [SharedVars.beginAppBarColor, SharedVars.appBarColor],
            stops: [0.5, 1.0],
          ),
          borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(SizeConfig.safeBlockHorizontal! * 7))),
    ),
  );
}

///
SnackBar mySnackBar(String text, Color color) {
  return SnackBar(
    backgroundColor: color,
    content: Container(
      height: SizeConfig.safeBlockVertical! * 7,
      child: Center(
          child: Text(
        text,
        style: TextStyle(
            fontFamily: SharedVars.fontFamily,
            fontSize: SizeConfig.safeBlockHorizontal! * 5,
            color: Colors.white,
            fontWeight: FontWeight.bold),
        textAlign: TextAlign.center,
      )),
    ),
    action: SnackBarAction(
      label: '',
      onPressed: () {
        // Some code to undo the change.
      },
    ),
  );
}

/// A custom alert dialog. This dialog is used as Exit dialog
AlertDialog questionAlertDialog(BuildContext context) {
  return AlertDialog(
    backgroundColor: Colors.transparent,
    content: new Container(
      width: SizeConfig.safeBlockHorizontal! * 90,
      height: SizeConfig.safeBlockHorizontal! * 40,
      decoration: new BoxDecoration(
        shape: BoxShape.rectangle,
        color: Colors.white,
        borderRadius: new BorderRadius.all(
            new Radius.circular(SizeConfig.safeBlockHorizontal! * 5)),
      ),
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            height: SizeConfig.safeBlockHorizontal! * 60 * 0.18,
          ),
          Text(
            'آیا می خواید از برنامه خارج شوید؟',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontFamily: SharedVars.fontFamily,
                fontSize: SharedVars.buttonFontSize! * 0.9),
          ),
          SizedBox(
            height: SizeConfig.safeBlockHorizontal! * 60 * 0.12,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(
                        SizeConfig.safeBlockHorizontal! * 3),
                  ),
                  primary: SharedVars.buttonColor,
                  padding: EdgeInsets.symmetric(
                      horizontal: SizeConfig.safeBlockHorizontal! * 8,
                      vertical: SizeConfig.safeBlockHorizontal! * 3),
                  textStyle: TextStyle(
                    fontFamily: SharedVars.fontFamily,
                    color: Colors.white,
                    fontSize: SharedVars.buttonFontSize,
                  ),
                ),
                onPressed: () => Navigator.of(context).pop(false),
                //return false when click on "NO"
                child: Text('خیر'),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(
                        SizeConfig.safeBlockHorizontal! * 3),
                  ),
                  primary: SharedVars.buttonColor,
                  padding: EdgeInsets.symmetric(
                      horizontal: SizeConfig.safeBlockHorizontal! * 8,
                      vertical: SizeConfig.safeBlockHorizontal! * 3),
                  textStyle: TextStyle(
                      fontFamily: SharedVars.fontFamily,
                      color: Colors.white,
                      fontSize: SharedVars.buttonFontSize,
                      fontWeight: FontWeight.bold),
                ),
                onPressed: () => Navigator.of(context).pop(true),
                //return true when click on "Yes"
                child: Text('بله'),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}

/// A custom dialog for network errors.
AlertDialog netAlertDialog(BuildContext context) {
  return AlertDialog(
    backgroundColor: Colors.transparent,
    content: new Container(
      width: SizeConfig.safeBlockHorizontal! * 70,
      height: SizeConfig.safeBlockHorizontal! * 40,
      decoration: new BoxDecoration(
        shape: BoxShape.rectangle,
        color: Colors.white,
        borderRadius: new BorderRadius.all(
            new Radius.circular(SizeConfig.safeBlockHorizontal! * 5)),
      ),
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            height: SizeConfig.safeBlockHorizontal! * 60 * 0.1,
          ),
          Text(
            'عدم اتصال به شبکه',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontFamily: SharedVars.fontFamily,
                color: Colors.red,
                fontSize: SharedVars.buttonFontSize! * 0.8),
          ),
          SizedBox(
            height: SizeConfig.safeBlockHorizontal! * 60 * 0.07,
          ),
          Text(
            'لطفا اتصال اینترنت را بررسی نمایید',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontFamily: SharedVars.fontFamily,
                fontSize: SharedVars.buttonFontSize! * 0.9),
          ),
          SizedBox(
            height: SizeConfig.safeBlockHorizontal! * 60 * 0.12,
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(
                    SizeConfig.safeBlockHorizontal! * 3),
              ),
              primary: SharedVars.buttonColor,
              padding: EdgeInsets.symmetric(
                  horizontal: SizeConfig.safeBlockHorizontal! * 10,
                  vertical: SizeConfig.safeBlockHorizontal! * 4),
              textStyle: TextStyle(
                fontFamily: SharedVars.fontFamily,
                color: Colors.white,
                fontSize: SharedVars.buttonFontSize,
              ),
            ),
            onPressed: () => Navigator.of(context).pop(false),
            //return false when click on "NO"
            child: Text('تایید'),
          ),
        ],
      ),
    ),
  );
}
