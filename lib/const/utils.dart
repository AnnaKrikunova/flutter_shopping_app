import 'package:flutter/material.dart';

void showSnackBarWithViewCart(BuildContext context, String s) {
  Scaffold.of(context).showSnackBar(SnackBar(content: Text('$s'),
    action: SnackBarAction(label: 'View Cart',onPressed: () => Navigator.of(context).pushNamed('/cartDetail'),),));
}

void showOnlySnackBar(BuildContext context, String s) {
  Scaffold.of(context).showSnackBar(SnackBar(content: Text('$s'),
    ));
}