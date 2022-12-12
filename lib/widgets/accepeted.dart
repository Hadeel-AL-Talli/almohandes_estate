import 'package:almohandes_estate/widgets/custom_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Accepeted extends StatefulWidget {
  const Accepeted({super.key});

  @override
  State<Accepeted> createState() => _AccepetedState();
}

class _AccepetedState extends State<Accepeted> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
          Image.asset('images/accepet_notification.png'),
          SizedBox(height: 5,),
          Text('تم الموافقة على منشورك', style: TextStyle(fontFamily: 'Tj', fontWeight: FontWeight.bold,fontSize: 24 ),),
          SizedBox(height: 5,),
          Text('تمت مراجعة منشورك والموافقة عليه اضغط على الزر في الاسفل لمشاهدة منشورك ' , style: TextStyle(fontFamily: 'Tj', color: Color(0xff8A8A8A), fontSize: 14),),
          SizedBox(height: 70,),
          Center(
            child: CustomButton(onPress: (){
              Navigator.pushNamed(context, '/main_screen');
            }, text: 
            'الذهاب لمنشورك', color: Color(0xff3D6CF0)),
          )
        ],
      ),
    );
  }
}