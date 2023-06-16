import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class BottomNavButton extends StatelessWidget {
  const BottomNavButton({
    super.key,
    required this.onPressed,
    required this.iconData,
    required this.color,
    required this.text,
  });

  final IconData iconData;
  final Color color;
  final String text;
  final VoidCallback onPressed;

  static const minButtonWidth = 20.0;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      padding: EdgeInsets.symmetric(horizontal: 1.h),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
      minWidth: minButtonWidth,
      onPressed: onPressed,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            iconData,
            size: 20.sp,
            color: color,
          ),
          Flexible(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 9.sp,
                color: color,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
