import 'package:flutter/material.dart';

class CustomAlertDialog {
  Future<void> showAlertMessage(BuildContext context, {required String title, required String body})
  {
    return showDialog(context: context, builder: (BuildContext context){
      return AlertDialog(
        icon: const Icon(Icons.warning),
        title: Text(title),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text(body),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Ok'),
          ),
        ],
      );
    });
  }
}