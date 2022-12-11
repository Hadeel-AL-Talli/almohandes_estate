import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:share_plus/share_plus.dart';

import 'package:url_launcher/url_launcher.dart';

import '../../controllers/auth_api_controller.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  //final Uri _url = Uri.parse('https://maps.app.goo.gl/wQrcuLtxifH8ddrp6?g_st=it');

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: BouncingScrollPhysics(),
       children: [
        SizedBox(height: 100.h,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
               SizedBox(width: 10.w,),

            InkWell(
              onTap: (){
                Navigator.pushNamed(context, '/edit');
              },
              child: Container(
               padding: EdgeInsets.all(15),
               width: 100.w,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(5)
                ),
                child: Wrap(
                  children: [
                    SvgPicture.asset('images/edit.svg'),
                    SizedBox(height: 10.h,),
                    Text('تعديل الحساب', style: TextStyle(fontFamily: 'Tj',fontSize: 12.sp ),),
            
                  ],
                ),
              ),
            ),
             InkWell(
              onTap:(){
                Navigator.pushNamed(context, '/myPosts');
              },
               child: Container(
               padding: EdgeInsets.all(15),
               width: 100.w,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(5)
                ),
                child: Column(
                  children: [
                    SvgPicture.asset('images/posts.svg'),
                    SizedBox(height: 10.h,),
                    Text('منشوراتي',style: TextStyle(fontFamily: 'Tj',fontSize: 12.sp ),),
             
                  ],
                ),
                         ),
             ),
            
             InkWell(
              onTap: (){
                Navigator.pushNamed(context, '/callus');
              },
               child: Container(
               padding: EdgeInsets.all(15),
               width: 100.w,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(5)
                ),
                child: Column(
                  children: [
                    SvgPicture.asset('images/call.svg'),
                    SizedBox(height: 10.h,),
                    Text('تواصل معنا',style: TextStyle(fontFamily: 'Tj',fontSize: 12.sp ),),
             
                  ],
                ),
                         ),
             ),
            SizedBox(width: 10.w,)

          ],
        ),


        SizedBox(height: 20.h,),

        Container(
          margin: EdgeInsets.all(20),
           decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(5)
              ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
          Row(
           mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SvgPicture.asset('images/location.svg'),
            //  SizedBox(width: 20.w,),
   Text('موقعنا ',style: TextStyle(fontFamily: 'Tj',fontSize: 12.sp ,fontWeight: FontWeight.bold),),
   IconButton(onPressed: (){
    const url = 'https://maps.app.goo.gl/wQrcuLtxifH8ddrp6?g_st=it';
    _launchURL(url);
   }, icon: Icon(Icons.arrow_forward_ios, size: 14,))


            ],
          ),
           Row(
           mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SvgPicture.asset('images/message.svg'),
            //  SizedBox(width: 20.w,),
   Text('من نحن ',style: TextStyle(fontFamily: 'Tj',fontSize: 12.sp ,fontWeight: FontWeight.bold),),
   IconButton(onPressed: (){
    Navigator.pushNamed(context, '/whous');
   }, icon: Icon(Icons.arrow_forward_ios, size: 14,))


            ],
          ),
           Row(
          

            children: [
              SizedBox(width: 30.w,),
              SvgPicture.asset('images/share.svg'),
              SizedBox(width: 70.w,),
            //  SizedBox(width: 20.w,),
   InkWell(
    onTap: (){
      Share.share('حمل تطبيق عقارات المهندس على الرابط التالي:\n https://onelink.to/bfa6w7 ', subject: 'عقارات المهندس');
    },
    child: Text('شارك التطبيق  ',style: TextStyle(fontFamily: 'Tj',fontSize: 12.sp ,fontWeight: FontWeight.bold),)),


            ],
          ),
          SizedBox(height: 15.h,),
            Row(
          

            children: [
              SizedBox(width: 30.w,),
              SvgPicture.asset('images/logout.svg'),
              SizedBox(width: 70.w,),
            //  SizedBox(width: 20.w,),
   InkWell(
    onTap: () async{
await logout(context);
    },
    child: Text('تسجيل خروج',style: TextStyle(fontFamily: 'Tj',fontSize: 12.sp ,fontWeight: FontWeight.bold),)),


            ],
          ),
            ],
          ),
        )
       ],
    );


    
  }

 _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
  

  Future<void> logout(BuildContext context) async {
    bool loggedOut = await AuthApiController().logout();
    if (loggedOut) Navigator.pushReplacementNamed(context, '/login');
  }
}
