import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class WhoUs extends StatelessWidget {
  const WhoUs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
         leading: 
            IconButton(onPressed: (){
              Navigator.pop(context);
            }, icon: Icon(Icons.arrow_back_ios) , color: Colors.black,),
        
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.white,
          title: Text('من نحن ؟ ', style: TextStyle(fontFamily: 'Tj',fontSize: 24.sp, color: Colors.black )),
        ),

        body: ListView(
          physics: BouncingScrollPhysics(),
          children: [
            SizedBox(height: 20.h,),
            Image.asset('images/whous.png', height: 193.h , width: 204.w,),
            SizedBox(height: 30.h,),
            Center(child: Text('عقارات المهندس \n مجموعة مختصة في مجال\n الإستثمار والتسويق والتطوير \n العقاري داخل محافظة الأنبار \n وخارجها, بالإضافة الى القسم \n الخاص بالبناء والترميم والمقاولات',textAlign: TextAlign.center, style: TextStyle(fontFamily: 'Tj',fontSize: 20.sp, color: Colors.black ),))

          ],
        ),
    );
  }
}