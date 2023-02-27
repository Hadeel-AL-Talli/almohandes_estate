import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../controllers/api_helper.dart';
import '../../controllers/auth_api_controller.dart';
import '../../widgets/app_text_feild.dart';
import '../../widgets/custom_button.dart';
import 'code_verify.dart';


class ForgetPassword extends StatefulWidget {
  const ForgetPassword({Key? key}) : super(key: key);

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> with ApiHelper {
  late TextEditingController _email;
   bool loding = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _email = TextEditingController();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _email.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text('نسيت كلمة السر', style: TextStyle(fontFamily: 'Tj', fontSize: 16.sp,color: Colors.black)),
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
        }, icon: Icon(Icons.arrow_back_ios, color: Colors.black,)),
      ),
      body:ListView(
        children: [
          SizedBox(height: 50.h,),
          Center(
            child: Text('الرجاء ادخال البريد الالكتروني  لارسال رمز التفعيل \n لتعيين كلمة مرور جديدة ', textAlign: TextAlign.center,style: TextStyle(fontFamily: 'Tj', fontWeight: FontWeight.bold),),
          ),
          SizedBox(height: 20.h,),
           Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: AppTextField(hint: 'example@gmail.com', controller: _email, suffix: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SvgPicture.asset('images/email.svg', ),
                  )),
                ),

                loding? Center(child: CircularProgressIndicator()):    Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: CustomButton(onPress: ()async{
                    setState(() {
                        loding=true;
                      });
                    await performForgetPassword();
                    setState(() {
                        loding=false;
                      });
                  }, text: 'إرسال  ', color: Color(0xff3D6CF0)),
                ),
        ],
      ) ,
    );
  }

   Future<void> performForgetPassword() async {
    if (checkData()) {
      await forgetPassword();
    }
  }

  bool checkData() {
    if (_email.text.isNotEmpty) {
      return true;
    }
    showSnackBar(
      context,
      message: 'الرجاء ادخال البريد الالكتروني',
      error: true,
    );
    return false;
  }

  Future<void> forgetPassword() async {
    bool status = await AuthApiController().forgetPassword(
      context,
      email: _email.text,
    );

    if (status) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) =>
              CodeVerify(email: _email.text),
        ),
      );
    }
  }
}