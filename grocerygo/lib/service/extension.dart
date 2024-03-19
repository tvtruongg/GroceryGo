import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// Phần mở rộng này bổ sung thêm hai phương thức tiện ích cho các đối tượng thuộc lớp State, giúp việc hiển thị thông báo và quản lý bàn phím trở nên thuận tiện hơn
extension StateExtension on State {
  void mdShowAlert(String title, String message, VoidCallback onPressed,
      {String buttonTitle = "Ok",
      TextAlign messageTextAlign = TextAlign.center}) {
    showDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: Text(title),
        content: Text(
          message,
          textAlign: messageTextAlign,
        ),
        actions: [
          CupertinoDialogAction(
            isDefaultAction: true,
            child: Text(buttonTitle),
            onPressed: () {
              Navigator.pop(context);
              onPressed();
            },
          )
        ],
      ),
    );
  }

  void endEditing() {
    FocusScope.of(context).requestFocus(FocusNode());
  }
}

extension StringExtension on String {
  bool get isEmail {
    return RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(this);
  }
}
