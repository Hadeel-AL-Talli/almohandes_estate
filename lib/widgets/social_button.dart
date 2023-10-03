import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SocialButton extends StatelessWidget {
   SocialButton({Key? key,  this.imagepath, this.text}) : super(key: key);
    String? imagepath;
    String? text;
  @override
  Widget build(BuildContext context) {
    return Container(
      
      height: 45.h,
     width: 330.w,
      decoration: BoxDecoration(
        border: Border.all(color: Color(0xff3D6CF0)),
        borderRadius: BorderRadius.circular(15)
       
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(width: 10.w,),
         SvgPicture.asset(imagepath!),
         SizedBox(width: 10.w,),
         Text(text!, style: TextStyle(fontFamily: 'Tj', color: Colors.black, fontSize: 15.sp, fontWeight: FontWeight.bold),),
         SizedBox(width: 10.w,),
         
        ],
      ),
    );
  }
}