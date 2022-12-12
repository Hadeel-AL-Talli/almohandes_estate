import 'package:almohandes_estate/widgets/custom_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class Reject extends StatefulWidget {
  const Reject({super.key});

  @override
  State<Reject> createState() => _RejectState();
}

class _RejectState extends State<Reject> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
        }, icon: Icon(Icons.arrow_back_ios ,color: Colors.black,)),
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.white,
          title: Text('الإشعارات ',style: TextStyle(fontFamily: 'Tj',fontSize: 24.sp, color: Colors.black )),
        ),
        body: Column(
        mainAxisAlignment:MainAxisAlignment.center,
        children: [
          Image.asset('images/notifications_no.png'),
          SizedBox(height: 5,),
          Text('عذراً, لقد تم رفض طلبك ', style: TextStyle(fontFamily: 'Tj', fontWeight: FontWeight.bold,fontSize: 24 ),),
          SizedBox(height: 5,),
          Text('يرجى التأكد من منشورك قبل ارسال الطلب' , style: TextStyle(fontFamily: 'Tj', color: Color(0xff8A8A8A), fontSize: 14),),
          SizedBox(height: 70,),
          Center(
            child: CustomButton(onPress: (){
              Navigator.pushNamed(context, '/main_screen');
            }, text: 
            'العودة للرئيسية ', color: Color(0xff3D6CF0)),
          )
        ],
      ),
    );
  }
}