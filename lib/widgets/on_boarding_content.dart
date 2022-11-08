import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../prefs/shared_prefrences_controller.dart';
import 'custom_button.dart';

class OnBoardingContent extends StatefulWidget {
  String? imagepath;
  String? title;
  String? subTitle;
 

  OnBoardingContent({this.imagepath, this.title, this.subTitle});

  @override
  State<OnBoardingContent> createState() => _OnBoardingContentState();
}

class _OnBoardingContentState extends State<OnBoardingContent> {
   
   
  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.maxFinite,
      width: double.maxFinite,
      
      child: Stack(
         
          children: [
          
         Positioned(
          child: Container(
            width: double.maxFinite,
            height: 450.h,
            decoration: BoxDecoration(
              image: DecorationImage(image: AssetImage(widget.imagepath!), fit: BoxFit.cover)
            ),
          )
          ),
           Positioned(
            top:50.h,
            right: 10.w,
             child: Container(
              
             width: 80.w,
             height: 40.h,
             child: CustomButton(onPress: (){
               Navigator.pushNamed(context, '/main_screen_un');
             }, text: 'تخطي', color: Colors.white, textcolor: Colors.black,)),
           ),
          Positioned(
            top:420.h,
            
            
            child: Container(
              
              width: MediaQuery.of(context).size.width,
              height: 700,
             decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30))
             ),
           child: Column(
            children: [
            
          SizedBox(height: 30.h,),
           Text(widget.title!,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Tj')),
            SizedBox(
              height: 20,
            ),
            Text(widget.subTitle!,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: Color(0xff585858),
                    fontFamily: 'Tj')),
                    SizedBox(height: 20.h,),
              CustomButton(onPress: (){
                Navigator.pushNamed(context, '/register');
              }, text: 'إنشاء حساب ', color: Color(0xff3D6CF0)),
                                  SizedBox(height: 20.h,),
              CustomButton(onPress: (){
                String route = SharedPrefController().loggedIn ? '/main_screen':'/login';
                Navigator.pushNamed(context, route);
              }, text: ' تسجيل دخول ', color:Colors.white, textcolor: Colors.black,)
            ],
           ),
            )),
            
           
          ]
          ),
    );
  }
}
