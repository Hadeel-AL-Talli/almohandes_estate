import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../widgets/custom_button.dart';

class FavoriteUn extends StatefulWidget {
  const FavoriteUn({Key? key}) : super(key: key);

  @override
  State<FavoriteUn> createState() => _FavoriteUnState();
}

class _FavoriteUnState extends State<FavoriteUn> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        children: [
          SizedBox(height: 20.h,),
          Image.asset('images/unregister.png' , height: 193.h,width: 204.w,),
          SizedBox(height: 60.h,),
          Center(child: Text('عليك تسجيل الدخول أولاً ', style: TextStyle(fontFamily: 'Tj',fontSize: 24.sp, color: Colors.black ,fontWeight: FontWeight.bold ))),
          SizedBox(height: 10.h,),
    Center(child: Text('قم بتسجيل الدخول أو انشاء حساب \nلتتمكن من الدخول الى حسابك الشخصي ', style: TextStyle(fontFamily: 'Tj',fontSize: 14.sp, color: Color(0xff8A8A8A) ,fontWeight: FontWeight.bold ))),

    SizedBox(height: 60.h,),
     Padding(
       padding: const EdgeInsets.all(15.0),
       child: CustomButton(onPress: (){
                  Navigator.pushNamed(context, '/register');
                }, text: 'إنشاء حساب ', color: Color(0xff3D6CF0)),
     ),
                                  SizedBox(height: 20.h,),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: CustomButton(onPress: (){
                  Navigator.pushNamed(context, '/login');
                }, text: ' تسجيل دخول ', color:Colors.white, textcolor: Colors.black,),
              )


        ],
      ),
    );
  }
}