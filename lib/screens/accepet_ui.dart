import 'package:almohandes_estate/widgets/custom_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AccepetBuilding extends StatefulWidget {
  const AccepetBuilding({super.key});

  @override
  State<AccepetBuilding> createState() => _AccepetBuildingState();
}

class _AccepetBuildingState extends State<AccepetBuilding> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment:MainAxisAlignment.center,
        children: [
          Image.asset('images/accepet.png'),
          SizedBox(height: 5,),
          Text('تم إرسال طلبك الان ', style: TextStyle(fontFamily: 'Tj', fontWeight: FontWeight.bold,fontSize: 24 ),),
          SizedBox(height: 5,),
          Text('جاري مراجعة منشورك بأقرب وقت \n انتظر موافقة الادمن لاتمام عملية \nالنشر وسيتم اشعارك بذلك ' , style: TextStyle(fontFamily: 'Tj', color: Color(0xff8A8A8A), fontSize: 14),),
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