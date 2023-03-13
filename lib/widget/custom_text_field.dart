import 'dart:ffi';

import 'package:flutter/material.dart';

class CusomTextField extends StatelessWidget {
  final String hint;
  final int maxLine;
  final dynamic onSaved;
  const CusomTextField({Key? key,required this.hint,required this.maxLine,required this.onSaved}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onSaved: onSaved,
      validator: (value){
        if(value?.isEmpty ?? true){
          return "Field Is Required";
        }
      },
      maxLines: maxLine,
      cursorColor: Colors.greenAccent,
      decoration: InputDecoration(
        focusColor: Colors.greenAccent,
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
              color: Colors.white,
            )
        ),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
              color: Colors.blue,
            )
        ),
        hintText: hint,
        hintStyle: TextStyle(
          color: Colors.greenAccent,
        ),
      ),
    );
  }
}
