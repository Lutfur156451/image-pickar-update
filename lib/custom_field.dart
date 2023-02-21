
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class customFormField extends StatelessWidget {
  final String hintText;
  final inputtype;
  final controlller;
  final String? Function(String?)? validator;

  customFormField({
    Key? key,
    required this.hintText,
    this.validator,
    this.inputtype,
    this.controlller,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        keyboardType: inputtype,
        controller: controlller,
        validator: validator,
        decoration: InputDecoration(
          filled: false,
          hintText: hintText,
          hintStyle: TextStyle(
            fontSize: 15.sp,
          ),
          focusColor: Colors.blue,
        ),
      ),
    );
  }
}