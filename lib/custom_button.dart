import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class coustombuttom extends StatelessWidget {
  String title;
  final onAction;
  coustombuttom(this.title, this.onAction);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onAction(),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.blue, borderRadius: BorderRadius.circular(8)),
        width: 325.w,
        height: 35.h,
        child: Center(
          child: Text(
            title,
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}

class coustomCancelbuttom extends StatelessWidget {
  String title;
  final onAction;

  coustomCancelbuttom(this.title, this.onAction);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onAction(),
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: Colors.blue,
            ),
            borderRadius: BorderRadius.circular(8)),
        width: 325.w,
        height: 35.h,
        child: Center(
          child: Text(
            title,
            style: TextStyle(
              color: Colors.blue,
            ),
          ),
        ),
      ),
    );
  }
}
