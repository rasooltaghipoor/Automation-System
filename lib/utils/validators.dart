String validateEmail(String? value) {
  String? _msg;
  RegExp regex = new RegExp(
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
  if (value!.isEmpty) {
    _msg = "لطفا نام کاربری را وارد نمایید.";
  }
  /*else if (!regex.hasMatch(value)) {
    _msg = "Please provide a valid emal address";
  }*/
  return _msg!;
}

String valiateDate(String value) {
  String? _msg;
  RegExp regex = new RegExp(
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
  if (value.isEmpty) {
    _msg = "لطفا تاریخ را وارد نمایید";
  } else if (!regex.hasMatch(value)) {
    _msg = "لطفا تاریخ را مثل مثال وارد نمایید";
  }
  return _msg!;
}
