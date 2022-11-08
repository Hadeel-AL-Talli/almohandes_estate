import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'custom_button.dart';


class SearchError extends StatefulWidget {
  const SearchError({Key? key}) : super(key: key);

  @override
  State<SearchError> createState() => _SearchErrorState();
}

class _SearchErrorState extends State<SearchError> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
        Image.asset('images/unregister.png'),
   Center(child: Text('لا توجد نتائج بحث , ابحث مجدداً ', style: TextStyle(fontFamily: 'Tj',fontSize: 24.sp, color: Colors.black ,fontWeight: FontWeight.w600))),
   SizedBox(height: 8.h,),
  Center(child: Text('للحصول على نتائج افضل استخدم\n الفلاتر الموجودة في صفحة البحث', style: TextStyle(fontFamily: 'Tj',fontSize: 14.sp, color: Colors.grey ,))),

  SizedBox(height: 10.h,),
   Padding(
       padding: const EdgeInsets.all(15.0),
       child: CustomButton(onPress: (){
                  Navigator.pushNamed(context, '/register');
                }, text: 'ابحث مجدداً', color: Color(0xff3D6CF0)),
     ),


        ],
      ),
    );
  }
}