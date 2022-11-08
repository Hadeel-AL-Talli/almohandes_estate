import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../controllers/api_helper.dart';
import '../../controllers/auth_api_controller.dart';
import '../../widgets/app_text_feild.dart';
import '../../widgets/custom_button.dart';


class ChangePassword extends StatefulWidget {
  const ChangePassword({Key? key, required this.email , required this.code }) : super(key: key);
  final String email;
  final String code;

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> with ApiHelper{
  late TextEditingController _passwordTextController ;
  late TextEditingController _confirmedpasswordTextController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _passwordTextController = TextEditingController();
    _confirmedpasswordTextController = TextEditingController();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _passwordTextController.dispose();
    _confirmedpasswordTextController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text('تغيير  كلمة السر', style: TextStyle(fontFamily: 'Tj', fontSize: 16.sp,color: Colors.black)),
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
        }, icon: Icon(Icons.arrow_back_ios, color: Colors.black,)),
      ),

      body: ListView(
        children: [
          Image.asset('images/changepass.png', height: 200.h,),
          SizedBox(height: 10.h,),
          Padding(
               padding: const EdgeInsets.only(right:15.0),
               child: Text('كلمة السر الجديدة', textDirection: TextDirection.rtl,style: TextStyle(fontFamily: 'Tj', fontSize: 16.sp,color: Colors.black, fontWeight: FontWeight.bold),),
             ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: AppTextField(hint: '******** ', controller: _passwordTextController, suffix: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SvgPicture.asset('images/eye.svg', ),
                  )),
                ),
                 Padding(
               padding: const EdgeInsets.only(right:15.0),
               child: Text('تأكيد كلمة السر ', textDirection: TextDirection.rtl,style: TextStyle(fontFamily: 'Tj', fontSize: 16.sp,color: Colors.black, fontWeight: FontWeight.bold),),
             ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: AppTextField(hint: '******** ', controller: _confirmedpasswordTextController, suffix: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SvgPicture.asset('images/eye.svg', ),
                  )),
                ),

                 Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: CustomButton(onPress: () async{
                    await performChangePassword();
                  }, text: 'تأكيد  ', color: Color(0xff3D6CF0)),
                ),
        ],
      ),
    );
  }
Future<void> performChangePassword() async {
    if (checkPassword()) {
      await resetPassword();
    }
  }

   bool checkPassword() {
    if (_passwordTextController.text.isNotEmpty && _confirmedpasswordTextController.text.isNotEmpty) {
      if (_passwordTextController.text == _confirmedpasswordTextController.text) {
        return true;
      }
      showSnackBar(context,
          message: 'Password confirmation error!', error: true);
      return false;
    }
    showSnackBar(context, message: 'Enter new Password ', error: true);
    return false;
  }

   Future<void> resetPassword() async {
    bool status = await AuthApiController().changePassword(context,
        password: _passwordTextController.text, c_password: _confirmedpasswordTextController.text, email: widget.email, code: widget.code);
    if (status) Navigator.pushReplacementNamed(context, '/passwordchanged');
  }
}