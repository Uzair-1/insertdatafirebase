// ignore_for_file: must_be_immutable, prefer_const_constructors, camel_case_types, use_key_in_widget_constructors, file_names

import 'package:flutter/material.dart';

class Custom_Button extends StatelessWidget {
  final String title;
  final VoidCallback ontap;
  bool loading;
  Custom_Button({
    required this.title,
    required this.ontap,
    required this.loading,
  });

  @override
  Widget build(BuildContext context) {
    return  Container(width:230,margin: EdgeInsets.all(4.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            elevation: 3, //elevation of button
            shape: RoundedRectangleBorder( //to set border radius to button
              borderRadius: BorderRadius.circular(28),
            ),
            padding: EdgeInsets.all(20) //content padding inside button
        ),
        onPressed:ontap,
        child: loading ? CircularProgressIndicator(color: Colors.white,)
            : Text(title,style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
      ),
    );
  }
}