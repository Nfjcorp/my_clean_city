import 'package:flutter/material.dart';
import 'package:my_clean_city/widgets/text_custom.dart';

// Navigate to the next page
void navigateToNextPage(BuildContext context, Widget page) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => page));
}

// navigate PushRemplacemant
void navigatePushReplacement(BuildContext context, Widget page) {
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(builder: (context) => page),
  );
}

// Show a snackbar
void showSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text(message), duration: Duration(seconds: 2)),
  );
}

// show dialogBox
void showDialogBox(
  BuildContext context,
  String title,
  String message,
  void Function() onTap,
) {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text(title),
        content: Text(message),
        actions: [
          InkWell(
            onTap: () => Navigator.pop(context),
            child: TextCustom(data: 'Annuler', fontSize: 16),
          ),
          InkWell(
            onTap: () {
              onTap;
              Navigator.pop(context);
            },
            child: TextCustom(
              data: 'Déconnecter',
              fontSize: 16,
              color: Colors.red,
            ),
          ),
        ],
      );
    },
  );
}

