import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class CustomButton extends StatelessWidget {
  String text;
  Color color;
  Function onPress;
  Color? textcolor;
  IconData? icon;
  CustomButton(
      {Key? key,
      required this.onPress,
      this.textcolor,
      this.icon,
      required this.text,
      required this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: color,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          minimumSize: const Size(310, 50),
        ),
        onPressed: () {
          onPress();
        },
        child: Text(text,
            style:  TextStyle(
                color: textcolor??Colors.white,
                fontSize: 16.sp,
                fontWeight: FontWeight.w900,
                fontFamily: 'Tj')));
  }
}
