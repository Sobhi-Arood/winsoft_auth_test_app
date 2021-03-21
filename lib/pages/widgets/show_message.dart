import 'package:flutter/material.dart';

class ShowMessages {
  static final ShowMessages instance = ShowMessages();

  showMessage(BuildContext ctx, String message) {
      return showDialog(
          barrierDismissible: true,
          context: ctx,
          builder: (context) => Center(
            child: Container(
              color: Colors.white,
              padding: EdgeInsets.all(16),
              child: Text(
                message,
                style: TextStyle(fontSize: 18),
              ),
            ),
          ),
        );
    }
}