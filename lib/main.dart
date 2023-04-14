import 'package:almohandes_estate/firebase/fb_notifications.dart';
import 'package:almohandes_estate/prefs/shared_prefrences_controller.dart';
import 'package:almohandes_estate/screens/Auth/forget_password.dart';
import 'package:almohandes_estate/screens/Auth/login.dart';
import 'package:almohandes_estate/screens/Auth/password_changed.dart';
import 'package:almohandes_estate/screens/Auth/register.dart';
import 'package:almohandes_estate/screens/Home/add_building.dart';
import 'package:almohandes_estate/screens/Home/edit_profile.dart';
import 'package:almohandes_estate/screens/Home/main_screen.dart';
import 'package:almohandes_estate/screens/Home/my_posts.dart';
import 'package:almohandes_estate/screens/Home/notifications_screen.dart';
import 'package:almohandes_estate/screens/Home/profile.dart';
import 'package:almohandes_estate/screens/accepet_ui.dart';
import 'package:almohandes_estate/screens/callus.dart';
import 'package:almohandes_estate/screens/on_boarding.dart';
import 'package:almohandes_estate/screens/splash.dart';
import 'package:almohandes_estate/screens/whous.dart';
import 'package:almohandes_estate/widgets/accepeted.dart';
import 'package:almohandes_estate/widgets/reject.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:provider/provider.dart';

import 'Provider/building_provider_vandor.dart';
import 'Unregister_User/main_screen_un.dart';
import 'Unregister_User/unregister.dart';
import 'firebase_options.dart';
import 'get/options_getx_controller.dart';

void main() async{
    WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,

  );
await FbNotifications.initNotifications();
 
  await SharedPrefController().initPref();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  OptionGetxController _optionGetxController = Get.put(OptionGetxController());
@override
 
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360 ,800),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context,child)=> MultiProvider(
        providers: [
          ChangeNotifierProvider<BuildingProvider>(
              create: (_) => BuildingProvider()
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          initialRoute: '/splash',
          routes: {
            //  '/test':((context) =>SearchError() ),
            '/splash':(context) => Splash(),
            '/on_boarding':(context)=> OnBoarding(),
            '/register':(context)=>  Register(),
            '/login':(context)=> Login(),
            '/forget_password':(context)=> ForgetPassword(),
            //  '/code_verify':(context)=> CodeVerify(),
            //  '/change_password':(context)=> ChangePassword(),
            '/main_screen':(context)=> MainScreen(),
            '/whous':(context)=> WhoUs(),
            '/callus':(context)=> CallUs(),
            '/addBuilding':(context)=> AddBuilding(),
            '/edit':(context)=> EditProfile(),
            '/main_screen_un':(context)=> MainScreenUN(),
            '/unregister':(context) => Unregister(),
            '/myPosts':(context) => MyPosts(),
              '/notifications':(context)=> NotificationScreen(),
            '/passwordchanged':((context) => PasswordChanged()),
            '/accepet':(context)=> AccepetBuilding(),
            '/accepeted':((context) => Accepeted()),
             '/profile':(context)=> Profile(),
            '/reject':((context) => Reject())






          },
        ),
      )
      ,
    );
  }
}