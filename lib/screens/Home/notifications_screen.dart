import 'package:almohandes_estate/firebase/fb_notifications.dart';
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
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    
  //   FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance; 
  //  _firebaseMessaging.getToken().then((token){
  //   _token = token;
  //    print(token);
     
  //     //sendFcmToken(context , token: token!);

  //   print('FCM TOKEN IS $_token');
  

  // });
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



        body: ListView(
          children: [
 
            
          ],
        ),
    );
  }
}