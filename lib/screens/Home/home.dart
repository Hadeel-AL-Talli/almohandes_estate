import 'dart:convert';

import 'package:almohandes_estate/controllers/api_helper.dart';
import 'package:almohandes_estate/controllers/api_settings.dart';
import 'package:almohandes_estate/firebase/fb_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:provider/provider.dart';

import '../../Provider/building_provider_vandor.dart';
import '../../get/options_getx_controller.dart';
import '../../models/home.dart';
import '../../models/option.dart';
import '../../widgets/homeWidget.dart';
import '../../widgets/search_form.dart';
import '../building_details.dart';
import 'main_screen.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with FbNotifications, ApiHelper{
    


  bool isClicked = false;
  String categoryId = "";
  String typeId = "";
  String cityId = "";
  List<HomeModel> homeModel=<HomeModel>[];
  Data? options;
  Future<void>getData()async
  {
    await Provider.of<BuildingProvider>(context,
        listen: false).getData();

  }
@override
  void initState() {
  OptionGetxController.to.getOptions();
  getData();
    // TODO: implement initState
    super.initState();
   
    FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance; 
    _firebaseMessaging.subscribeToTopic('all');
   _firebaseMessaging.getToken().then((FCMtoken){
   
     
     sendFcmToken(token: FCMtoken!);
      

    
  
 

  });
  FirebaseMessaging.instance.onTokenRefresh
    .listen((fcmToken) {
      sendFcmToken(token: fcmToken);
      // TODO: If necessary send token to application server.

      // Note: This callback is fired at each app startup and whenever a new
      // token is generated.
    })
    .onError((err) {
      // Error getting token.
    });

  
  
    requestNotificationPermissions();

    
    initializeForegroundNotificationForAndroid();
    manageNotificationAction();
  }
  

   Future<bool> sendFcmToken({ required String token})async{
 print('send fcm token');
 print("/////////////$token");
    var url = Uri.parse(ApiSettings.notifications);
  var response = await  http.post(url , headers:headers,
       body: {
        'token':token,
        
         
       }
     
       );
       print(response.statusCode);
       if(response.statusCode ==200){
          print('token send to api $token' );
          return true;
       }

       return false;
       
     
   }

  @override
  Widget build(BuildContext context) {
    return
      GetBuilder<OptionGetxController>(builder: (controller) {
        if (controller.loading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (controller.options != null) {
          options ??= controller.options;
          return Column(
            children: [
              TextFormField(
                onSaved: (value) {},
                onChanged: (value) {
                  Provider.of<BuildingProvider>(context,
                      listen: false).sherch(text: value);
                },
                decoration: InputDecoration(
                  hintStyle: TextStyle(fontFamily: 'Tj'),
                  filled: true,
                  fillColor: Colors.white,
                  hintText: "ابحث الان عن عقارك ",
                  border: outlineInputBorder,
                  enabledBorder: outlineInputBorder,
                  focusedBorder: outlineInputBorder,
                  errorBorder: outlineInputBorder,
                  prefixIcon: Padding(
                    padding: const EdgeInsets.all(14),
                    child: SvgPicture.asset("images/Search1.svg"),
                  ),
                  suffixIcon: Padding(
                    padding:  EdgeInsets.symmetric(
                        horizontal: 16, vertical: 8),
                    child: SizedBox(
                      width: 48,
                      height: 48,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary:Color(0xff3D6CF0),
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(12)),
                          ),
                        ),
                        onPressed: () {
                          print("aaaa");
                          setState(() {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MainScreen(
                                  currentIndex: 1,
                                ),
                              ),
                            );
                          });
                        },
                        child: SvgPicture.asset("images/Filter.svg", ),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: ListView(
                  physics: BouncingScrollPhysics(),
                  shrinkWrap: true,
                  children: [

                    Image.asset('images/slider.png'),
                    options!.categories.isNotEmpty?  SizedBox(
                      height: 50.h,
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: options!.categories.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              if(controller.options!.categories[index].selected)
                              {
                                controller.options!.categories[index].selected=false;
                                categoryId="";
                              }
                              else{
                                for (int i = 0;
                                i < controller.options!.categories.length;
                                i++) {
                                  controller.options!.categories[i].selected =
                                  false;
                                }
                                controller.options!.categories[index].selected =
                                true;
                                categoryId = controller
                                    .options!.categories[index].id
                                    .toString();
                              }
                               Provider.of<BuildingProvider>(context,
                                  listen: false).getData(category: categoryId,type: typeId,city: cityId);
                              setState(() {});
                            },
                            child: Container(
                              margin: EdgeInsets.symmetric(horizontal: 14.w),
                              width: MediaQuery.of(context).size.width / 4,
                              height: 30.h,
                              decoration: BoxDecoration(
                                color: controller
                                    .options!.categories[index].selected
                                    ? Color(0xff3D6CF0)
                                    : Colors.white,
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Center(
                                  child: Text(
                                    controller.options!.categories[index].name,
                                    style: TextStyle(fontFamily: 'Tj', fontSize: 14.sp,
                                        color: controller.options!
                                            .categories[index].selected
                                            ? Colors.white
                                            : Colors.black
                                    ),
                                  )),
                            ),
                          );
                        },
                      ),
                    ):SizedBox(),
                    SizedBox(
                      height: 5.h,
                    ),
                    options!.types.isNotEmpty?    SizedBox(
                      height: 60.h,
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: options!.types.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              if(controller.options!.types[index].selected)
                              {
                                controller.options!.types[index].selected=false;
                                typeId="";
                              }
                              else{
                                for (int i = 0;
                                i < controller.options!.types.length;
                                i++) {
                                  controller.options!.types[i].selected =
                                  false;
                                }
                                controller.options!.types[index].selected =
                                true;
                                typeId = controller
                                    .options!.types[index].id
                                    .toString();
                              }
                              Provider.of<BuildingProvider>(context,
                                  listen: false).getData(category: categoryId,type: typeId,city: cityId);
                              setState(() {});
                            },
                            child: Container(
                              margin: EdgeInsets.symmetric(horizontal: 14.w),
                              width: MediaQuery.of(context).size.width / 6,
                              height: 60.h,
                              
                              decoration: BoxDecoration(
                                color: controller
                                    .options!.types[index].selected
                                    ? Color(0xff3D6CF0)
                                    : Colors.white,
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 10.h,
                                  ),
                                  SvgPicture.asset(
                                    index == 3
                                        ? 'images/hous.svg'
                                        : index == 2
                                        ? 'images/buildings.svg'
                                        : index == 1
                                        ? 'images/buildings-2.svg'
                                        : 'images/building-4.svg',
                                    color: controller.options!
                                        .types[index].selected
                                        ? Colors.white:Color(0xff797979),
                                  ),
                                  SizedBox(height: 5.h,),
                                  Center(
                                      child: Text(
                                        controller.  options!.types[index].name,
                                        style:
                                        TextStyle(fontFamily: 'Tj', fontSize: 14.sp,
                                            color: controller.options!
                                                .types[index].selected
                                                ? Colors.white
                                                : Colors.black
                                        ),
                                      )),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ):SizedBox(),
                    SizedBox(
                      height: 5.h,
                    ),
                    options!.cities.isNotEmpty?    SizedBox(
                      height: 40.h,
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: options!.cities.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return    InkWell(
                            onTap: () {
                              if(controller.options!.cities[index].selected)
                              {
                                controller.options!.cities[index].selected=false;
                                cityId="";
                              }
                              else{
                                for (int i = 0;
                                i < controller.options!.cities.length;
                                i++) {
                                  controller.options!.cities[i].selected =
                                  false;
                                }
                                controller.options!.cities[index].selected =
                                true;
                                cityId = controller
                                    .options!.cities[index].id
                                    .toString();
                              }
                              Provider.of<BuildingProvider>(context,
                                  listen: false).getData(category: categoryId,type: typeId,city: cityId);
                              setState(() {});
                            },
                            child: Container(
                              margin: EdgeInsets.symmetric(horizontal: 14.w),
                              width: MediaQuery.of(context).size.width / 4,
                              height: 30.h,
                              decoration: BoxDecoration(
                                color: controller
                                    .options!.cities[index].selected
                                    ? Color(0xff3D6CF0)
                                    : Colors.white,
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Center(
                                  child: Text(
                                    
                                    controller.options!.cities[index].name,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(fontFamily: 'Tj',fontSize: 14.sp,
                                        color: controller.options!
                                            .cities[index].selected
                                            ? Colors.white
                                            : Colors.black
                                    ),
                                  )),
                            ),
                          );
                        },
                      ),
                    ):SizedBox(),
                    SizedBox(
                      height: 10.h,
                    ),
                      Consumer<BuildingProvider>(builder: (context, value, child) {
                        if(value.loding)
                        {
                          return Center(child: CircularProgressIndicator());
                        }
                        else if(value.listSelected.isNotEmpty)
                        {
                          return  ListView.builder(
                            itemCount:value.listSelected.length ,
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return  InkWell(
                                  onTap: () {
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (context) {
                                          print(value.listSelected[index].id);
                                      return  BuildingDetails(id: value.listSelected[index].id);
                                      
                                        }
                                        ));
                                  
                                  },
                                  child: homewidget(
                                    homeModel:value.listSelected[index] ,
                                    // tabo: 'طابو صرف',

                                  ));
                            },);
                        }
                        else
                        {
                        return  Column(
            children: [
              SizedBox(height: 20.h,),
              Image.asset('images/search.png', width: 120.w,),
                Center(child: Text(" لا يوجد نتائج ابحث مجددا",
                              style: TextStyle(fontFamily: 'Tj',fontSize: 16.sp, color: Colors.black ,fontWeight: FontWeight.bold,))),

                              SizedBox(height: 10.h,),
                               Center(child: Text("للحصول على نتائج أفضل استخدم الفلاتر الموجودة في صفحة البحث ",
                               textAlign: TextAlign.center,
                              style: TextStyle(fontFamily: 'Tj',fontSize: 14.sp, color: Color(0xff8A8A8A) ,fontWeight: FontWeight.bold,))),
            ],
          );
                        }
                      },),

                  ],
                ),
              ),
            ],
          );
        } else {
          return Column(
            children: [
              SizedBox(height: 40.h,),
              Image.asset('images/search.png'),
                Center(child: Text(" لا يوجد نتائج ابحث مجددا",
                              style: TextStyle(fontFamily: 'Tj',fontSize: 24.sp, color: Colors.black ,fontWeight: FontWeight.bold,))),

                              SizedBox(height: 10.h,),
                               Center(child: Text("للحصول على نتائج أفضل استخدم الفلاتر الموجودة في صفحة البحث ",
                              style: TextStyle(fontFamily: 'Tj',fontSize: 14.sp, color: Color(0xff8A8A8A) ,fontWeight: FontWeight.bold,))),
            ],
          );
        }
      });
  }
}
