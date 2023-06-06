import 'package:almohandes_estate/controllers/ad_api_controller.dart';
import 'package:almohandes_estate/controllers/api_helper.dart';
import 'package:almohandes_estate/controllers/api_settings.dart';
import 'package:almohandes_estate/firebase/fb_notifications.dart';
import 'package:almohandes_estate/models/ad_model.dart';
import 'package:drop_shadow/drop_shadow.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:provider/provider.dart';
import 'package:scroll_indicator/scroll_indicator.dart';

import '../../Provider/building_provider_vandor.dart';
import '../../get/options_getx_controller.dart';
import '../../models/home.dart';
import '../../models/option.dart';
import '../../widgets/homeWidget.dart';
import '../../widgets/search_form.dart';
import '../building_details.dart';
import 'main_screen.dart';
import 'package:http/http.dart' as http;

import 'package:carousel_slider/carousel_slider.dart';


class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with FbNotifications, ApiHelper{
    
final CarouselController _controller = CarouselController();
late Future<List<AdModel>> _imageFuture; 
List<AdModel> _myAd = <AdModel>[];
  bool isClicked = false;
  String categoryId = "";
  String typeId = "";
  String cityId = "";
  List<HomeModel> homeModel=<HomeModel>[];
  Data? options;
    ScrollController scrollController = ScrollController();

  Future<void>getData()async
  {
    await Provider.of<BuildingProvider>(context,
        listen: false).getData();

  }
@override
  void initState() {
  OptionGetxController.to.getOptions();
  getData();
  scrollController = ScrollController();
    // TODO: implement initState
    super.initState();
   _imageFuture = ADController().getadUrl();
    FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance; 
    _firebaseMessaging.subscribeToTopic('all');
   _firebaseMessaging.getToken().then((FCMtoken){
   
     
     sendFcmToken(token: FCMtoken!);
     print("FCM TOKEN "+FCMtoken);
      

    
  
 

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
       print('response ');
       print(response.statusCode);
       if(response.statusCode ==200){
          print('token send to api $token' );
          return true;
       }

       return false;
       
     
   }


   @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    scrollController.dispose();
  }
 
  @override
  Widget build(BuildContext context) {
    return
      GetBuilder<OptionGetxController>(builder: (controller) {
        if (controller.loading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (controller.options != null) {
          options ??= controller.options;
          return Column(
            children: [
              TextFormField(
                onSaved: (value) {
                  Provider.of<BuildingProvider>(context,
                      listen: false).sherch(text: value!);
                },
                onChanged: (value) {
                  // Provider.of<BuildingProvider>(context,
                  //     listen: false).sherch(text: value);
                },
                decoration: InputDecoration(
                  hintStyle: const TextStyle(fontFamily: 'Tj'),
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
                    padding:  const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 8),
                    child: SizedBox(
                      width: 48,
                      height: 48,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary:const Color(0xff3D6CF0),
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(12)),
                          ),
                        ),
                        onPressed: () {
                          print("aaaa");
                          setState(() {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const MainScreen(
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
          
              
              
                //  Padding(
                //             padding: const EdgeInsets.only(top: 10,left: 100),
                //             child: Text(
                //              'تصفح أحدث العقارات ..',
                //                textAlign: TextAlign.right,
                //              // textDirection: TextDirection.rtl,
                //               style: TextStyle(
                //                   fontFamily: 'Tj',
                //                   color: Colors.blueAccent,
                //                   fontSize: 22.sp,
                //                   fontWeight: FontWeight.bold),
                //             ),
                //           ),
              Expanded(
                child: ListView(
                  physics: const BouncingScrollPhysics(),
                  shrinkWrap: true,
                  children: [
          
          
                    FutureBuilder<List<AdModel>>(
                      future: _imageFuture,
                      builder: (context, snapshot) {
                         if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
             }
             else if (snapshot.hasData ){
             _myAd = snapshot.data ??[];
          return    Container(
            height: 300.h,
            
            margin: EdgeInsets.all(10),
             
            child: ListView.builder(
              physics: BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            controller: scrollController,
            itemCount: _myAd.length,
            itemBuilder: (context, index) {
              return  InkWell(
                onTap: (){
                   Navigator.push(context,
                                        MaterialPageRoute(builder: (context) {
                                        
                                      return  BuildingDetails(id:_myAd[index].id );
                                      
                                        }
                                        ));
                },
                child: Stack(
                  children: [
                    
                    Container(
                    //  width: 350.w,
                  
                      child: Container(
          decoration: BoxDecoration(
            // border: Border.all(color: Colors.white10),
            //   borderRadius: BorderRadius.circular(20),
              // gradient: const LinearGradient(
              //   colors: [Colors.black, Colors.grey],
              // )
              ),
                        width: 280.w,
                      
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.white10),
               borderRadius: BorderRadius.circular(25),
                          ),
                          // Image.network(_myAd[index].images, fit: BoxFit.cover,)
                          child:promoCard(_myAd[index].images))),
                    ),
                    Positioned(
                      bottom: 25.h,right: 28.w,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [

                          Text('  | ', style: TextStyle(color: Colors.blueAccent, fontWeight: FontWeight.bold, fontSize: 30.sp),),

                        Text(_myAd[index].typeName , style: TextStyle(fontFamily: 'Tj', fontSize: 18, fontWeight: FontWeight.bold ,color: Colors.white),),
                                         Text('|', style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 18.sp),),

                                                  Text(_myAd[index].city , style: TextStyle(fontFamily: 'Tj', fontSize: 18, fontWeight: FontWeight.bold ,color: Colors.white),),

         //  Text('عمارة تجارية للبيع' , style: TextStyle(fontFamily: 'Tj', fontSize: 22, fontWeight: FontWeight.bold ,color: Colors.white),),

                        ],
                      )
                        ),
          
          
                        // Positioned(
                          
                        //   child: Image.asset('images/shadow.png', width: 200,height: 200,))
                  ],
                ));
            },
                 
                ),
          );
          
          
          
          //                       return CarouselSlider(
          // options: CarouselOptions(height: 400.0,
           
             
          //  //   autoPlay: true,
          // ),
          // items: _myAd.map((i) {
          //   return 
          //        ListView.builder(
          //         scrollDirection: Axis.horizontal,
          //         itemCount: _myAd.length,
          //         itemBuilder: (context, index) {
          //           return  Image.network(_myAd[index].images);
          //         },
                 
          //       );
             
          // }).toList(),
          //                       );
             }
             else {
              return Image.asset('images/slider.png');
             }
                      }
                    ),
          
                    // options!.categories.isNotEmpty?  SizedBox(
                    //   height: 50.h,
                    //   child: ListView.builder(
                    //     shrinkWrap: true,
                    //     itemCount: options!.categories.length,
                    //     scrollDirection: Axis.horizontal,
                    //     itemBuilder: (context, index) {
                    //       return InkWell(
                    //         onTap: () {
                    //           if(controller.options!.categories[index].selected)
                    //           {
                    //             controller.options!.categories[index].selected=false;
                    //             categoryId="";
                    //           }
                    //           else{
                    //             for (int i = 0;
                    //             i < controller.options!.categories.length;
                    //             i++) {
                    //               controller.options!.categories[i].selected =
                    //               false;
                    //             }
                    //             controller.options!.categories[index].selected =
                    //             true;
                    //             categoryId = controller
                    //                 .options!.categories[index].id
                    //                 .toString();
                    //           }
                    //            Provider.of<BuildingProvider>(context,
                    //               listen: false).getData(category: categoryId,type: typeId,city: cityId);
                    //           setState(() {});
                    //         },
                    //         child: Container(
                    //           margin: EdgeInsets.symmetric(horizontal: 14.w),
                    //           width: MediaQuery.of(context).size.width / 4,
                    //           height: 30.h,
                    //           decoration: BoxDecoration(
                    //             color: controller
                    //                 .options!.categories[index].selected
                    //                 ? const Color(0xff3D6CF0)
                    //                 : Colors.white,
                    //             border: Border.all(color: Colors.grey),
                    //             borderRadius: BorderRadius.circular(5),
                    //           ),
                    //           child: Center(
                    //               child: Text(
                    //                 controller.options!.categories[index].name,
                    //                 style: TextStyle(fontFamily: 'Tj', fontSize: 14.sp,
                    //                     color: controller.options!
                    //                         .categories[index].selected
                    //                         ? Colors.white
                    //                         : Colors.black
                    //                 ),
                    //               )),
                    //         ),
                    //       );
                    //     },
                    //   ),
                    // ):const SizedBox(),
                    // SizedBox(
                    //   height: 5.h,
                    // ),
                    // options!.types.isNotEmpty?    SizedBox(
                    //   height: 70.h,
                    //   child: ListView.builder(
                    //     shrinkWrap: true,
                    //     itemCount: options!.types.length,
                    //     scrollDirection: Axis.horizontal,
                    //     itemBuilder: (context, index) {
                    //       return InkWell(
                    //         onTap: () {
                    //           if(controller.options!.types[index].selected)
                    //           {
                    //             controller.options!.types[index].selected=false;
                    //             typeId="";
                    //           }
                    //           else{
                    //             for (int i = 0;
                    //             i < controller.options!.types.length;
                    //             i++) {
                    //               controller.options!.types[i].selected =
                    //               false;
                    //             }
                    //             controller.options!.types[index].selected =
                    //             true;
                    //             typeId = controller
                    //                 .options!.types[index].id
                    //                 .toString();
                    //           }
                    //           Provider.of<BuildingProvider>(context,
                    //               listen: false).getData(category: categoryId,type: typeId,city: cityId);
                    //           setState(() {});
                    //         },
                    //         child: Container(
                    //           margin: EdgeInsets.symmetric(horizontal: 14.w),
                    //           width: MediaQuery.of(context).size.width / 6,
                    //           height: 60.h,
          
                    //           decoration: BoxDecoration(
                    //             color: controller
                    //                 .options!.types[index].selected
                    //                 ? const Color(0xff3D6CF0)
                    //                 : Colors.white,
                    //             border: Border.all(color: Colors.grey),
                    //             borderRadius: BorderRadius.circular(5),
                    //           ),
                    //           child: Column(
                    //             children: [
                    //               SizedBox(
                    //                 height: 10.h,
                    //               ),
                    //               SvgPicture.asset(
                    //                 index == 3
                    //                     ? 'images/hous.svg'
                    //                     : index == 2
                    //                     ? 'images/buildings.svg'
                    //                     : index == 1
                    //                     ? 'images/buildings-2.svg'
                    //                     : 'images/building-4.svg',
                    //                 color: controller.options!
                    //                     .types[index].selected
                    //                     ? Colors.white:const Color(0xff797979),
                    //               ),
                    //               SizedBox(height: 5.h,),
                    //               Center(
                    //                   child: Text(
                    //                     controller.  options!.types[index].name,
                    //                     style:
                    //                     TextStyle(fontFamily: 'Tj', fontSize: 14.sp,
                    //                         color: controller.options!
                    //                             .types[index].selected
                    //                             ? Colors.white
                    //                             : Colors.black
                    //                     ),
                    //                   )),
                    //             ],
                    //           ),
                    //         ),
                    //       );
                    //     },
                    //   ),
                    // ):const SizedBox(),
                    // SizedBox(
                    //   height: 5.h,
                    // ),
                    // options!.cities.isNotEmpty?    SizedBox(
                    //   height: 40.h,
                    //   child: ListView.builder(
                    //     shrinkWrap: true,
                    //     physics: const BouncingScrollPhysics(),
                    //     itemCount: options!.cities.length,
                    //     scrollDirection: Axis.horizontal,
                    //     itemBuilder: (context, index) {
                    //       return    InkWell(
                    //         onTap: () {
                    //           if(controller.options!.cities[index].selected)
                    //           {
                    //             controller.options!.cities[index].selected=false;
                    //             cityId="";
                    //           }
                    //           else{
                    //             for (int i = 0;
                    //             i < controller.options!.cities.length;
                    //             i++) {
                    //               controller.options!.cities[i].selected =
                    //               false;
                    //             }
                    //             controller.options!.cities[index].selected =
                    //             true;
                    //             cityId = controller
                    //                 .options!.cities[index].id
                    //                 .toString();
                    //           }
                    //           Provider.of<BuildingProvider>(context,
                    //               listen: false).getData(category: categoryId,type: typeId,city: cityId);
                    //           setState(() {});
                    //         },
                    //         child: Container(
                    //           margin: EdgeInsets.symmetric(horizontal: 14.w),
                    //           width: MediaQuery.of(context).size.width / 5,
                    //           // padding: EdgeInsets.symmetric(horizontal: 4.w),
                    //           height: 30.h,
                    //           decoration: BoxDecoration(
                    //             color: controller
                    //                 .options!.cities[index].selected
                    //                 ? const Color(0xff3D6CF0)
                    //                 : Colors.white,
                    //             border: Border.all(color: Colors.grey),
                    //             borderRadius: BorderRadius.circular(5),
                    //           ),
                    //           child: Center(
                    //               child: Text(
                    //                 controller.options!.cities[index].name,
                    //                 textAlign: TextAlign.center,
                    //                 style: TextStyle(fontFamily: 'Tj',fontSize: 14.sp,
                    //                     color: controller.options!
                    //                         .cities[index].selected
                    //                         ? Colors.white
                    //                         : Colors.black
                    //                 ),
                    //               )),
                    //         ),
                    //       );
                    //     },
                    //   ),
                    // ):const SizedBox(),
                    // SizedBox(
                    //   height: 10.h,
                    // ),
          
                    
                        ScrollIndicator(
                       alignment: Alignment.center,
          scrollController: scrollController,
          width: 30,
          height: 5,
          indicatorWidth: 15,
          decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.grey[300]),
          indicatorDecoration: BoxDecoration(
          color: Colors.blueAccent,
          borderRadius: BorderRadius.circular(10)),
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



  Widget promoCard(image) {
    return AspectRatio(
      aspectRatio: 2.62 / 3,
      child: Container(
        margin: EdgeInsets.only(right: 15.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          image: DecorationImage(fit: BoxFit.cover, image: NetworkImage(image)),
        ),
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: LinearGradient(begin: Alignment.bottomRight, stops: [
                0.1,
                0.9
              ], colors: [
                Colors.black.withOpacity(.8),
                Colors.black.withOpacity(.1)
              ])),
        ),
      ),
    );
  }
}