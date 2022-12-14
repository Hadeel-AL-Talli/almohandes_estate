import 'package:almohandes_estate/controllers/user_notifications_controller.dart';
import 'package:almohandes_estate/firebase/fb_notifications.dart';
import 'package:almohandes_estate/models/user_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> with FbNotifications {
   //String? _token;
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
      appBar: AppBar(
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
          }
           else if (snapshot.hasData && snapshot.data!.isNotEmpty){
            userNotifications = snapshot.data ??[];
            
         return ListView.builder(
          itemCount: userNotifications.length,
          itemBuilder: ((context, index) {
           return InkWell(
            onTap: (){
              String route ;
              switch(userNotifications[index].type){
                case '0': route = '/general';
               // Navigator.pushNamed(context, route);
                break;

                case '1': route = '/accepeted';
                 Navigator.pushNamed(context, route);
                print(route);
                break;

                case '2': route = '/reject';
                 Navigator.pushNamed(context, route);
                print(route);
                break;
              }
            },
             child: Container(
              margin: EdgeInsets.all(15),
             padding: EdgeInsets.only(top:10, right: 10, bottom: 10,left:  10),
              decoration: BoxDecoration(
                border: Border.all(color: Color(0xffCBCFDA))
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
              
                  // Image.asset('images/notifications_no.png', height: 80,width: 80,),
             
                userNotifications[index].type==0 ?   Image.asset('images/accepet_notification.png', height: 50,width: 50,): 
                userNotifications[index].type ==1 ?
             
                   Image.asset('images/general_notification.png', height: 80,width: 80,): userNotifications[index].type ==2 ? Image.asset('images/notifications_no.png', height: 80,width: 80,):  Image.asset('images/accepet_notification.png', height: 50,width: 50,),
                   
           
                  Column(
                    children: [
               Center(child: Text(userNotifications[index].created_at , style: TextStyle(fontFamily: 'Tj', fontSize: 14 , color: Color(0xff8A8A8A)),)),
               SizedBox(height: 5,),
           
                      Text(userNotifications[index].title , style: TextStyle(fontFamily: 'Tj', fontSize: 18, color: Colors.black),
                      ),
                      SizedBox(height: 5,),
                       Text(userNotifications[index].reject_reason??'' , style: TextStyle(fontFamily: 'Tj', fontSize: 18, color: Colors.black),
                      ),
            SizedBox(height: 5,),
                      Text(userNotifications[index].body , style: TextStyle(fontFamily: 'Tj', fontSize: 14 , color: Color(0xff8A8A8A)),)
                    ],
                  )
                ],
              ),
             ),
           );
         }));
           }
          
           else{
          return  Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
       Center(child: Text('لا توجد اشعارات ', style: TextStyle(fontFamily: 'Tj', fontSize:24.sp,color: Colors.black ),)),

         Image.asset('images/notifications_no.png'),
              ],
            );
           }
        },
  
        ),
    
    );
  }
}