import 'package:almohandes_estate/controllers/user_notifications_controller.dart';
import 'package:almohandes_estate/models/user_notifications.dart';
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
   late Future<List<UserNotifications>> _future;
   List<UserNotifications> userNotifications = <UserNotifications>[];

   @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _future = UserNotificationsController().userNotifications();
   
  }
 
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
        body: FutureBuilder<List<UserNotifications>>(
          future: _future,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }else if (snapshot.hasData && snapshot.data!.isNotEmpty){
            userNotifications = snapshot.data ??[];
            return Column(
              
              children: [
                // ListView.builder(
                //   shrinkWrap: true,
                //   physics: NeverScrollableScrollPhysics(),
                //   itemCount: userNotifications.length,
                //   itemBuilder: (context, index) {
                //     return Text(userNotifications[index].reject_reason ??'Rejected' , style: TextStyle(fontFamily: 'Tj', color: Color(0xff8A8A8A), fontSize: 14),);
                //   },
                //    // mainAxisAlignment:MainAxisAlignment.center,
           
                //   ),
                     SizedBox(height: 50.h,),
                  Image.asset('images/notifications_no.png'),
                  SizedBox(height: 5.h,),
                  Text('عذراً, لقد تم رفض طلبك ', style: TextStyle(fontFamily: 'Tj', fontWeight: FontWeight.bold,fontSize: 24 ),),
                  SizedBox(height: 5.h,),

                  SizedBox(height: 5.h,),
                  Text('يرجى التأكد من منشورك قبل ارسال الطلب' , style: TextStyle(fontFamily: 'Tj', color: Color(0xff8A8A8A), fontSize: 14),),
                  SizedBox(height: 50.h,),
                  Center(
                    child: CustomButton(onPress: (){
                      Navigator.pushNamed(context, '/main_screen');
                    }, text: 
                    'العودة للرئيسية ', color: Color(0xff3D6CF0)),
                  )
              ],
            );
          }
          else{
            return Text('data');
          }
          }
        ),
    );
  }
}