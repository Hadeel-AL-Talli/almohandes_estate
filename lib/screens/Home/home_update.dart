import 'package:almohandes_estate/Provider/building_provider_vandor.dart';
import 'package:almohandes_estate/controllers/ad_api_controller.dart';
import 'package:almohandes_estate/controllers/api_helper.dart';
import 'package:almohandes_estate/controllers/api_settings.dart';
import 'package:almohandes_estate/controllers/home_api_controller.dart';
import 'package:almohandes_estate/firebase/fb_notifications.dart';
import 'package:almohandes_estate/get/options_getx_controller.dart';
import 'package:almohandes_estate/models/ad_model.dart';
import 'package:almohandes_estate/models/home.dart';
import 'package:almohandes_estate/models/option.dart';
import 'package:almohandes_estate/screens/Home/main_screen.dart';
import 'package:almohandes_estate/screens/building_details.dart';
import 'package:almohandes_estate/widgets/homeWidget.dart';
import 'package:almohandes_estate/widgets/search_form.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:scroll_indicator/scroll_indicator.dart';
class HomeUpdate extends StatefulWidget {
  const HomeUpdate({super.key});

  @override
  State<HomeUpdate> createState() => _HomeUpdateState();
}

class _HomeUpdateState extends State<HomeUpdate> with FbNotifications, ApiHelper {
  late Future<List<HomeModel>> _future;
  List<HomeModel> _myhome = <HomeModel>[];
late Future<List<AdModel>> _imageFuture; 
List<AdModel> _myAd = <AdModel>[];

Data? options;
    ScrollController scrollController = ScrollController();
Future<void>getData()async
  {
    await Provider.of<BuildingProvider>(context,
        listen: false).getData();

  }
@override
  void initState() {
    _future = HomeApiController().showHome();
 
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
    return GetBuilder<OptionGetxController>(builder: ((controller) {
       if(controller.loading){
        return Center(child: CircularProgressIndicator(),);
       }
       else if(controller.options != null){
      options ??=controller.options;
      return Column(
        children: [
 TextFormField(
                onSaved: (value) {},
                onChanged: (value) {
                  Provider.of<BuildingProvider>(context,
                      listen: false).sherch(text: value);
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
                            Navigator.pushReplacement(
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
                                       
                                      
                            child: Container(
                              decoration: BoxDecoration(
                               
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
                    
                    
                              ],
                            )
                              ),
                              
                              
                                      ],
                                    ));
                                },
                                     
                                    ),
                              );
                              
                              
                              
                                 
                              
                                 }
                                 else {
                                  return Image.asset('images/slider.png');
                                 }
                            }
                          ),

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
                        else{
  return Container();
 }

                        
 
 }

 
 )
       
 
       
          
                        ],

       
                      ),
                    ),
       


                    
        ],
      );
       }
    
else{
  return Container();
}
    }));
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

