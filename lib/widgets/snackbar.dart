import 'package:flutter/material.dart';


void mySnackBarShow(BuildContext context, String text){
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(text))
  );
}