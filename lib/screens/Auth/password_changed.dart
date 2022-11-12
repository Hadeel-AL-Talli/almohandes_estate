import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class PasswordChanged extends StatefulWidget {
  const PasswordChanged({Key? key}) : super(key: key);

  @override
  State<PasswordChanged> createState() => _PasswordChangedState();
}

class _PasswordChangedState extends State<PasswordChanged> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
         leading: 
            IconButton(onPressed: (){
              Navigator.pushNamed(context, '/login');
            }, icon: Icon(Icons.arrow_back_ios) , color: Colors.black,),
        
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.white,
          title: Text('', style: TextStyle(fontFamily: 'Tj',fontSize: 24.sp, color: Colors.black )),
        ),


        body: ListView(
          children: [
              Image.asset('images/changepass.png', height: 200.h,),
              SizedBox(height: 60.h,),
               Center(child: Text('تم تغيير كلمة السر ', textDirection: TextDirection.rtl,style: TextStyle(fontFamily: 'Tj', fontSize: 24.sp,color: Colors.black, fontWeight: FontWeight.bold),)),
               SizedBox(height: 8.h,),
                Center(child: Text('تم تغيير كلمة السر الخاصة بك بنجاح', textDirection: TextDirection.rtl,style: TextStyle(fontFamily: 'Tj', fontSize: 14.sp,color: Color(0xff8A8A8A), fontWeight: FontWeight.bold),)),

          ],
        )
    );
  }
}