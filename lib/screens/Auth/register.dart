import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../controllers/api_helper.dart';
import '../../controllers/api_settings.dart';
import '../../controllers/auth_api_controller.dart';
import '../../models/register_user.dart';
import '../../widgets/app_text_feild.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/social_button.dart';
import 'package:http/http.dart'as http;


class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register>with ApiHelper{
  late TextEditingController _emailTextController ;
  late TextEditingController _passwordTextController;
  late TextEditingController _nameTextController ;
   late TextEditingController _passwordConTextController;
   final FacebookLogin _fb = FacebookLogin(); 
   bool loding = false;
GoogleSignIn _googleSignIn = GoogleSignIn(
 
  // The OAuth client id of your app. This is required.
 // clientId:'1052048950734-fn8787cumgcqlbl6b12gfi33k3skvo2v.apps.googleusercontent.com',
  // If you need to authenticate to a backend server, specify its OAuth client. This is optional.
  serverClientId: '',
);
GoogleSignIn _googleSign = GoogleSignIn(
  scopes: [
    // 'email',
    // 'https://www.googleapis.com/auth/contacts.readonly'
   
  ],
);
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    _emailTextController = TextEditingController();
    _passwordTextController = TextEditingController();
    _nameTextController = TextEditingController();
    _passwordConTextController = TextEditingController();

  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailTextController.dispose();
    _nameTextController.dispose();
    _passwordTextController.dispose();
    _passwordConTextController.dispose();
  }
   void _facebookLogin()async{
    final result = await _fb.logIn();

    switch(result.status){
      case FacebookLoginStatus.success :
      sendToken(result.accessToken!.token);
      print('TOKEN'+result.accessToken!.token);
      break;

      case FacebookLoginStatus.cancel: break;

      case FacebookLoginStatus.error:
       print(result.error);
      break;
    }
  }
  void sendToken (String facebookToken) async{
     var url = Uri.parse(ApiSettings.facebooklogin);
     var response = await http.post(url, body: json.encode({
      "token":facebookToken
     }, ), headers: {"Content-Type":"application/json"});

     print(response.body);
  }
  Future<void> _handleSignIn() async {
  try {
    await _googleSignIn.signIn().then((value) => value!.authentication.then((googleKey) => sendGoogleToken(googleKey.accessToken!))).catchError((err)=>print(err)).catchError((error)=>print(error));
  } catch (error) {
    print(error);
  }
}
void sendGoogleToken(String googleToken)async{
  var url = Uri.parse(ApiSettings.googlelogin);
  var response = await http.post(url, body: json.encode({
    "token":googleToken
  }), headers: {"Content-Type":"application/json"});
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          SizedBox(height: 10.h,),
         
          SizedBox(height: 40.h,),
          Center(child: Text('انشاء حساب ', style: TextStyle(fontFamily: 'Tj',  fontSize: 16.sp, color: Colors.black, fontWeight: FontWeight.bold),)),
          SizedBox(height: 25.h,),
         Center(child: Text('انشئ حسابك على التطبيق باستخدام فيسبوك او غوغل   ', style: TextStyle(fontFamily: 'Tj',  fontSize: 12.sp, color: Color(0xff797979)),)),

        SizedBox(height: 25.h,),
         Row(
          mainAxisAlignment: MainAxisAlignment.center,
           children: [
             InkWell(
              onTap: ()async{
                await _handleSignIn();
                await  Navigator.pushReplacementNamed(context, '/main_screen');
              },
              child: SocialButton(imagepath: 'images/google.svg', text: 'باستخدام غوغل ',)),
             SizedBox(width: 10.w,),
             InkWell(
              onTap:()async{
                 _facebookLogin();
                 await  Navigator.pushReplacementNamed(context, '/main_screen');
              },
              child: SocialButton(imagepath: 'images/facebook.svg', text: 'باستخدام فيسبوك ',)),
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
               child: Text('الاسم', textDirection: TextDirection.rtl,style: TextStyle(fontFamily: 'Tj', fontSize: 16.sp,color: Colors.black, fontWeight: FontWeight.bold),),
             ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: AppTextField(hint: 'قم بادخال اسمك الكامل ', controller: _nameTextController, suffix: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SvgPicture.asset('images/person.svg', ),
                  )),
                ),
                 
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
               child: Text(' تأكيد كلمة السر ', textDirection: TextDirection.rtl,style: TextStyle(fontFamily: 'Tj', fontSize: 16.sp,color: Colors.black, fontWeight: FontWeight.bold),),
             ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: AppTextField(hint: '******', controller: _passwordConTextController, suffix: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SvgPicture.asset('images/eye.svg', ),
                  )),
                ),

               loding? Center(child: CircularProgressIndicator()):  Padding(
                  padding: const EdgeInsets.only(top:10.0, right: 20, left: 20, bottom: 10),
                  child: CustomButton(onPress: () async{
                     setState(() {
                        loding=true;
                      });
await performRegister();
setState(() {
                        loding=false;
                      });
                  }, text: 'انشاء حساب', color: Color(0xff3D6CF0)),
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
      InkWell(
        onTap: (){
          Navigator.pushNamed(context, '/login');
        },
        child: Text('تسجيل الدخول', style: TextStyle(fontFamily: 'Tj',  fontSize: 12.sp, color: Color(0xff3D6CF0)),)),

         Text(' هل لديك حساب بالفعل؟ ', style: TextStyle(fontFamily: 'Tj',  fontSize: 12.sp, color: Color(0xff797979)),),


                  ],
                )

        ],
      ),
    );
  }

Future<void> performRegister() async{
    if(checkData()){
      await register();
    }
  } 
     bool checkData(){
      if(_nameTextController.text.isNotEmpty && _emailTextController.text.isNotEmpty
       && _passwordConTextController.text.isNotEmpty &&_passwordConTextController.text.isNotEmpty){
        return true;
       }
       showSnackBar(
      context,
      message: 
      'من فضلك, أدخل البيانات المطلوبة',
      error: true,
    );
    return false;
     }
     Future<void> register()async{
    bool status = await AuthApiController().register(context, user: user);
    if(status) {
       showSnackBar(context, message:'تم انشاء الحساب بنجاح' );
       Navigator.pushNamed(context, '/login');
    }

  }

   RegisterUser get user {
    RegisterUser user = RegisterUser();
    user.name = _nameTextController.text;
    user.email = _emailTextController.text;
    user.password = _passwordTextController.text;
    user.c_password = _passwordConTextController.text;


    return user; 
  }
}