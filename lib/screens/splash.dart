import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../controllers/home_api_controller.dart';
import '../widgets/custom_button.dart';


class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    HomeApiController().  getPriceMaxMin();
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Stack(
            
             children: [
              
               
               Positioned.fill(child: Image.asset('images/splash.png', fit: BoxFit.fill,)),
             Positioned(
              top: 90.h,
              right: 20.w,
              child: SvgPicture.asset('images/logo.svg')),
               Positioned(
                
               top: 500.h,
                 child: Padding(
                   padding: const EdgeInsets.all(15.0),
                   child: Text('احصل الان',style: TextStyle(fontSize: 20, fontFamily: 'Tj', color: Colors.white, fontWeight: FontWeight.bold),),
                 )),
                  Positioned(
                
               top: 530.h,
                 child: Padding(
                   padding: const EdgeInsets.all(15.0),
                   child: Text(' على منزل أحلامك ',style: TextStyle(fontSize: 20, fontFamily: 'Tj', color: Colors.white, fontWeight: FontWeight.bold),),
                 )),
        
                 Positioned(
                
               top: 560.h,
                 child: Padding(
                   padding: const EdgeInsets.all(15.0),
                   child: Text(' مع تطبيق عقارات المهندس ',style: TextStyle(fontSize: 20, fontFamily: 'Tj', color: Colors.white, fontWeight: FontWeight.bold),),
                 )),
               Positioned(
               top: 590.h,
               right: 30.w,
                 child: Padding(
                   padding: const EdgeInsets.all(15.0),
                   child:CustomButton(
                    onPress: (){
                    Navigator.pushNamed(context, '/on_boarding');
                   }, text: ' ابدأ الان', color: Color(0xff3D6CF0),))
                 ),
                 
                  


                 
               
             ],
           ),
        ),
      )
       
    );
  }
}