import 'package:flutter/material.dart';

class AppTextField extends StatelessWidget {
  const AppTextField({
    Key? key,
    this.suffix,
    this.max,
    required this.hint,
    required this.controller,
    //required this.prefixIcon,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
  }) : super(key: key);
  final Widget? suffix;
  final String hint;
  final TextInputType keyboardType;
  final TextEditingController controller;
  //final IconData prefixIcon;
  final bool obscureText;
  final int? max;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        keyboardType: keyboardType,
        maxLength: max,
        style: TextStyle(color: Colors.black, ),
        decoration: InputDecoration(
          
            hintText: hint,
            hintStyle: TextStyle(
              
                  fontFamily: 'Tj',
                  fontSize: 12,
                  color: Color(0xff797979)
                ),
    suffixIcon: suffix,
            // TextStyle(fontFamily: 'Poppins'),
            // prefixIcon: Icon(
            //   prefixIcon,
            //   color: Colors.grey,
            // ),
            enabledBorder: border(),
            focusedBorder: border(borderColor: Color(0xff3D6CF0)
                //  borderColor: Colors.black
                )),
      ),
    );
  }

  OutlineInputBorder border({Color borderColor = Colors.grey}) {
    return OutlineInputBorder(
      borderSide: BorderSide(
        color: borderColor,
        width: 1,
      ),
      borderRadius: BorderRadius.circular(10),
    );
  }
}
