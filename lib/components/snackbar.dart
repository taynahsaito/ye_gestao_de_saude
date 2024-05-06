import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

showSnackBar(
    {required BuildContext context,
    required String texto,
    bool isErro = true}) {
  SnackBar snackBar = SnackBar(
      content: Text(
        texto,
      ),
      backgroundColor: (isErro) ? Colors.red : Colors.green);

  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

