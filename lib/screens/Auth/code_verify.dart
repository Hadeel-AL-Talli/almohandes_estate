import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../controllers/api_helper.dart';
import '../../controllers/auth_api_controller.dart';
import '../../widgets/code_text_feild.dart';
import '../../widgets/custom_button.dart';
import 'change_password.dart';


class CodeVerify extends StatefulWidget {
  const CodeVerify({Key? key , required this.email}) : super(key: key);
   final String email;
  @override
  State<CodeVerify> createState() => _CodeVerifyState();
}

class _CodeVerifyState extends State<CodeVerify> with ApiHelper {
  late TextEditingController _firstCodeTextController;
  late TextEditingController _secondCodeTextController;
  late TextEditingController _thirdCodeTextController;
  late TextEditingController _fourthCodeTextController;

  late FocusNode _firstFocusNode;
  late FocusNode _secondFocusNode;
  late FocusNode _thirdFocusNode;
  late FocusNode _fourthFocusNode;
  String? code;
@override
  void initState() {
    super.initState();
    _firstCodeTextController = TextEditingController();
    _secondCodeTextController = TextEditingController();
    _thirdCodeTextController = TextEditingController();
    _fourthCodeTextController = TextEditingController();

    _firstFocusNode = FocusNode();
    _secondFocusNode = FocusNode();
    _thirdFocusNode = FocusNode();
    _fourthFocusNode = FocusNode();
  }

  @override
  void dispose() {
    _firstCodeTextController.dispose();
    _secondCodeTextController.dispose();
    _thirdCodeTextController.dispose();
    _fourthCodeTextController.dispose();

    _firstFocusNode.dispose();
    _secondFocusNode.dispose();
    _thirdFocusNode.dispose();
    _fourthFocusNode.dispose();

    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
        }, icon: Icon(Icons.arrow_back_ios, color: Colors.black,)),
      ),
      body: ListView(
        children: [
          Image.asset('images/code.png', height: 200.h,),
          SizedBox(height: 20.h,),
          Text('تم إرسال الرمز الخاص بك ',textAlign: TextAlign.center, style: TextStyle(fontFamily: 'Tj', fontSize: 24.sp, fontWeight: FontWeight.bold),),
          SizedBox(height: 8.h,),
          Text('قم بادخل رمز التحقق الذي ارسلناه لك على \nالبريد الالكتروني ',textAlign: TextAlign.center, style: TextStyle(fontFamily: 'Tj',color: Color(0xff8A8A8A), fontSize: 14.sp),),
          SizedBox(height: 20.h,),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
                              children: [
                                Expanded(
                                  child: CodeTextField(
                                    textEditingController:
                                        _firstCodeTextController,
                                    focusNode: _firstFocusNode,
                                    onChanged: (value) {
                                      if (value.isNotEmpty) {
                                        _secondFocusNode.requestFocus();
                                      }
                                    },
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: CodeTextField(
                                    textEditingController:
                                        _secondCodeTextController,
                                    focusNode: _secondFocusNode,
                                    onChanged: (value) {
                                      value.isNotEmpty
                                          ? _thirdFocusNode.requestFocus()
                                          : _firstFocusNode.requestFocus();
                                    },
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: CodeTextField(
                                    textEditingController:
                                        _thirdCodeTextController,
                                    focusNode: _thirdFocusNode,
                                    onChanged: (value) {
                                      value.isNotEmpty
                                          ? _fourthFocusNode.requestFocus()
                                          : _secondFocusNode.requestFocus();
                                    },
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: CodeTextField(
                                    textEditingController:
                                        _fourthCodeTextController,
                                    focusNode: _fourthFocusNode,
                                    onChanged: (value) {
                                      if (value.isEmpty) {
                                        _thirdFocusNode.requestFocus();
                                      }
                                    },
                                  ),
                                ),
                              ],
                            ),
          ),


          
                 Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: CustomButton(onPress: ()async{
                   await performResetPassword();
                  }, text: 'تحقق  ', color: Color(0xff3D6CF0)),
                ),
                 Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
      InkWell(
        onTap: ()async{
         // Navigator.pushNamed(context, '/login');
         await AuthApiController().forgetPassword(
      context,
      email: widget
      .email,
    );

        },
        child: Text('  إعادة إرسال' , style: TextStyle(fontFamily: 'Tj',  fontSize: 12.sp, color: Color(0xff3D6CF0)),)),

         Text(' لم يصلك الرمز بعد؟  ', style: TextStyle(fontFamily: 'Tj',  fontSize: 12.sp, color: Color(0xff797979)),),


                  ],
                )


        
        ],
      ),
    );
  }
Future<void> performResetPassword() async {
    if (checkCode()) {
     print('code');
      await resetPassword();
      

      
    }
  }

  bool checkCode() {
    if (_firstCodeTextController.text.isNotEmpty &&
        _secondCodeTextController.text.isNotEmpty &&
        _thirdCodeTextController.text.isNotEmpty &&
        _fourthCodeTextController.text.isNotEmpty) {
      getVerificationCode();
      
      return true;
    }
    showSnackBar(
      context,
      message: 'أدخل رمز التفعيل, من فضلك ',
      error: true,
    );
    return false;
  }

  String getVerificationCode() {
    return code = _firstCodeTextController.text +
        _secondCodeTextController.text +
        _thirdCodeTextController.text +
        _fourthCodeTextController.text;

        
        
  }

  Future<void> resetPassword() async {
    bool status = await AuthApiController().resetPassword(context,
        email: widget.email, code: code!);
        print('reset password');
        print(status);
    if (status) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) =>
              ChangePassword(email: widget.email, code:code!),
        ),
      );
    }

    
  }
}