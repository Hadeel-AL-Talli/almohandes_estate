import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../controllers/api_helper.dart';
import '../../controllers/auth_api_controller.dart';
import '../../widgets/app_text_feild.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/social_button.dart';


class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> with ApiHelper {
   late TextEditingController _emailTextController ;
  late TextEditingController _passwordTextController;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _emailTextController = TextEditingController();
    _passwordTextController = TextEditingController();
    
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailTextController.dispose();
    
    _passwordTextController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
           SizedBox(height: 10.h,),
           
          SizedBox(height: 40.h,),
          Center(child: Text(' تسجيل دخول ', style: TextStyle(fontFamily: 'Tj',  fontSize: 16.sp, color: Colors.black, fontWeight: FontWeight.bold),)),
          SizedBox(height: 25.h,),
         Center(child: Text('سجل دخول على التطبيق باستخدام فيسبوك او غوغل   ', style: TextStyle(fontFamily: 'Tj',  fontSize: 12.sp, color: Color(0xff797979)),)),

        SizedBox(height: 25.h,),
         Row(
          mainAxisAlignment: MainAxisAlignment.center,
           children: [
             SocialButton(imagepath: 'images/google.svg', text: 'باستخدام غوغل ',),
             SizedBox(width: 10.w,),
             SocialButton(imagepath: 'images/facebook.svg', text: 'باستخدام فيسبوك ',),
           ],
         ),
         SizedBox(height: 20.h,),
          Row(children: [
                  Expanded(child: Divider(thickness: 1,endIndent: 5,indent: 15,)),
                  Text('أو', style: TextStyle(fontFamily: 'Tj',color: Color(0xff797979),fontSize: 12.sp),),
                   Expanded(child: Divider(thickness: 1,indent: 5,endIndent: 15,))
                ],),
              SizedBox(height: 15.h,),
          
               
                 
             Padding(
               padding: const EdgeInsets.only(right:15.0),
               child: Text('البريد الالكتروني ', textDirection: TextDirection.rtl,style: TextStyle(fontFamily: 'Tj', fontSize: 16.sp,color: Colors.black, fontWeight: FontWeight.bold),),
             ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: AppTextField(hint: 'example@gmail.com', controller: _emailTextController, suffix: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SvgPicture.asset('images/email.svg', ),
                  )),
                ),

             Padding(
               padding: const EdgeInsets.only(right:15.0),
               child: Text('كلمة السر ', textDirection: TextDirection.rtl,style: TextStyle(fontFamily: 'Tj', fontSize: 16.sp,color: Colors.black, fontWeight: FontWeight.bold),),
             ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: AppTextField(hint: 'ادخل على الأقل 8 حروف أو أكثر ', controller: _passwordTextController, suffix: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SvgPicture.asset('images/eye.svg', ),
                  )),
                ),

                   Padding(
               padding: const EdgeInsets.only(right:15.0),
               child: InkWell(
                onTap: (){
                  Navigator.pushNamed(context, '/forget_password');
                },
                child: Text('هل نسيت كلمة السر؟  ', textDirection: TextDirection.rtl,style: TextStyle(fontFamily: 'Tj', fontSize: 12.sp,color: Color(0xff3D6CF0), fontWeight: FontWeight.bold),)),
             ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: CustomButton(onPress: () async{
                  await performLogin();
                  }, text: 'تسجيل دخول ', color: Color(0xff3D6CF0)),
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
      InkWell(
        onTap: (){
          Navigator.pushNamed(context, '/register');
        },
        child: Text(' إنشاءحساب' , style: TextStyle(fontFamily: 'Tj',  fontSize: 12.sp, color: Color(0xff3D6CF0)),)),
       SizedBox(width: 5,),
         Text('ليس لديك حساب ؟ ', style: TextStyle(fontFamily: 'Tj',  fontSize: 12.sp, color: Color(0xff797979)),),


                  ],
                )

        ],
      ),
    );
  }



   Future<void> performLogin() async {
    if (checkData()) {
      
      await login();
    }
  }

  bool checkData() {
    if (_emailTextController.text.isNotEmpty &&
        _passwordTextController.text.isNotEmpty) {
      return true;
    }
    showSnackBar(
      context,
      message: 'من فضلك, أدخل البيانات المطلوبة',
      error: true,
    );
    return false;
  }

  Future<void> login() async {
    bool status = await AuthApiController().login(
      context,
      email: _emailTextController.text,
      password: _passwordTextController.text,
    );
    if (status) Navigator.pushReplacementNamed(context, '/main_screen');
  }
}