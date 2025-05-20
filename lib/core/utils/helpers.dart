import 'package:flutter/material.dart';

void navigateToNextPage(BuildContext context, Widget page) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => page));
}

void showSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text(message), duration: Duration(seconds: 2),
    ),
  );
}

void showDialogBox(BuildContext context, String title, String message, void Function() onPessed){
  showDialog(
    barrierDismissible: true,
    context: context, 
    builder: (BuildContext context){
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20)
      ),
      title: Text(title),
      content: Text(message),
      actions: [
        TextButton(onPressed: onPessed, child: Text('Annuler')),
        TextButton(onPressed: onPessed, child: Text('Ok'))
      ],
    );
  });
}
