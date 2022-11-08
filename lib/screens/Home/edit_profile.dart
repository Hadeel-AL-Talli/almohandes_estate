import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../controllers/api_helper.dart';
import '../../controllers/update_profile_controller.dart';
import '../../models/register_user.dart';
import '../../prefs/shared_prefrences_controller.dart';
import '../../widgets/app_text_feild.dart';
import '../../widgets/custom_button.dart';


class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> with ApiHelper {

  late TextEditingController _passwordTextController;
  late TextEditingController _nameTextController;
   late TextEditingController _phoneTextController;
   late TextEditingController _emailTextController;
   @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _passwordTextController = TextEditingController();
    _nameTextController = TextEditingController()..text=SharedPrefController().name;
   _phoneTextController=TextEditingController()..text=SharedPrefController().phone!="null"?SharedPrefController().phone:"";

    _emailTextController = TextEditingController()..text=SharedPrefController().email;
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _nameTextController.dispose();
    _passwordTextController.dispose();
    _phoneTextController.dispose();
    _emailTextController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar:  AppBar(
         leading: 
            IconButton(onPressed: (){
              Navigator.pop(context);
            }, icon: Icon(Icons.arrow_back_ios) , color: Colors.black,),
        
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.white,
          title: Text('تعديل الحساب', style: TextStyle(fontFamily: 'Tj',fontSize: 24.sp, color: Colors.black )),
        ),
        body: ListView(
          children: [
            SizedBox(height: 30.h,),
              Padding(
               padding: const EdgeInsets.only(right:15.0),
               child: Text('الاسم', textDirection: TextDirection.rtl,style: TextStyle(fontFamily: 'Tj', fontSize: 16.sp,color: Colors.black, fontWeight: FontWeight.bold),),
             ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: AppTextField(hint: 'فاطمة حسام', controller: _nameTextController, suffix: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SvgPicture.asset('images/user-edit.svg', ),
                  )),
                ),
                 Padding(
               padding: const EdgeInsets.only(right:15.0),
               child: Text('البريد الالكتروني', textDirection: TextDirection.rtl,style: TextStyle(fontFamily: 'Tj', fontSize: 16.sp,color: Colors.black, fontWeight: FontWeight.bold),),
             ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: AppTextField(hint: '', controller: _emailTextController, suffix: Padding(
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
                  child: AppTextField(hint: '*******', controller: _passwordTextController, suffix: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SvgPicture.asset('images/eye.svg', ),
                  )),
                ),
                 Padding(
               padding: const EdgeInsets.only(right:15.0),
               child: Text('رقم الهاتف', textDirection: TextDirection.rtl,style: TextStyle(fontFamily: 'Tj', fontSize: 16.sp,color: Colors.black, fontWeight: FontWeight.bold),),
             ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: AppTextField(hint: '123456456', controller: _phoneTextController, suffix: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SvgPicture.asset('images/editphone.svg', ),
                  )),
                ),

                SizedBox(height: 20.h,),
                 Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: CustomButton(onPress: ()async{
                    await performUpdateProfile();
                  }, text: 'حفظ الاعدادات', color: Color(0xff3D6CF0)),
                ),

          ],
        ),
    );
  }
 Future<void> performUpdateProfile() async {
    if (checkData()) {
      await UpdateProfile();
    }
  }
 Future<void> UpdateProfile() async {
    bool status = await UpdateProfileController().updateProfile(context, user: user);
   
    if (status) {
      Navigator.pushReplacementNamed(context, '/main_screen');
    }
  }

  bool checkData() {
    if (
       
        _emailTextController.text.isNotEmpty &&
        _nameTextController.text.isNotEmpty) {
      return true;
    }
    showSnackBar(
      context,
      message: 'Enter required data!',
      error: true,
    );
    return false;
  }
  RegisterUser get user {
    RegisterUser user = RegisterUser();
    user.name = _nameTextController.text;
    user.email = _emailTextController.text;
    user.password = _passwordTextController.text;
    user.phone = _phoneTextController.text;


    return user; 
  }
}