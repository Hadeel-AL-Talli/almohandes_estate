import 'package:almohandes_estate/get/options_getx_controller.dart';
import 'package:almohandes_estate/models/IsFav.dart';
import 'package:almohandes_estate/models/my_post.dart';
import 'package:almohandes_estate/models/option.dart';
import 'package:almohandes_estate/widgets/GalleryWidget.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:favorite_button/favorite_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:full_screen_image_null_safe/full_screen_image_null_safe.dart';
import 'package:get/get.dart';
import 'package:scroll_indicator/scroll_indicator.dart';
import 'package:url_launcher/url_launcher.dart';

import '../controllers/favorite_api_controller.dart';
import '../controllers/home_api_controller.dart';

import '../controllers/home_api_controller.dart';
import '../models/details.dart';
import '../models/favorite.dart';

class BuildingDetails extends StatefulWidget {
  const BuildingDetails({Key? key, required this.id}) : super(key: key);
  final int id;

  @override
  State<BuildingDetails> createState() => _BuildingDetailsState();
}

class _BuildingDetailsState extends State<BuildingDetails> {
  List<Categories> categories = <Categories>[];
  int _current = 0;
  late Future<List<Details>> _future;
   
  List<Details> _details = <Details>[];
 
  List<Images> _images = <Images>[];
 
   
  final CarouselController _controller = CarouselController();
  ScrollController scrollController = ScrollController();
   
  
   _viewFav() {
    bool? isFav;
    FavoriteApiController().isFav(context, widget.id.toString()).then((value){

     isFav = value;
   

   } );
   
   }
  
  @override
  void initState() {
    // TODO: implement initState
    scrollController = ScrollController();
    super.initState();
    print('load data');
    _future = HomeApiController().getDetails(widget.id.toString());
  
    

  }
 

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder<List<Details>>(
            future: _future,
            builder: (context, snapShot) {
              if (snapShot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapShot.hasData && snapShot.data!.isNotEmpty) {
                _details = snapShot.data ?? [];
                          

                return ListView.builder(
                    itemCount: _details.length,
                    itemBuilder: (context, index) {
                              

                      return Column(
                        children: [
                          SizedBox(
                            height: 10.h,
                          ),

                          Stack(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: CarouselSlider.builder(
                                  carouselController: _controller,
                                  options: CarouselOptions(
                                      onPageChanged: (index, reason) {
                                        setState(() {
                                          _current = index;
                                        });
                                      },
                                      height: 280.h,
                                      autoPlay: true,
                                      // viewportFraction: 0.8,
                                      enlargeCenterPage: true,
                                      aspectRatio: 16 / 9,
                                      autoPlayAnimationDuration:
                                          const Duration(seconds: 1),
                                      autoPlayCurve: Curves.fastOutSlowIn,
                                      initialPage: 0,
                                      enableInfiniteScroll: true,
                                      reverse: false,
                                      autoPlayInterval:
                                          const Duration(seconds: 3)),
                                  itemCount: _images.length,
                                  itemBuilder: (BuildContext context,
                                          int itemIndex, int pageViewIndex) =>
                                      FullScreenWidget(
                                    backgroundColor: Colors.white,
                                    child: Center(
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(16),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            image: DecorationImage(
                                              image: NetworkImage(
                                                  _details[index]
                                                      .images[itemIndex]
                                                      .image),
                                              fit: BoxFit.fitWidth,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              // ScrollIndicator(
                              //              alignment: Alignment.center,
                              // scrollController: scrollController,
                              // width: 30,
                              // height: 5,
                              // indicatorWidth: 15,
                              // decoration: BoxDecoration(
                              // borderRadius: BorderRadius.circular(10),
                              // color: Colors.grey[300]),
                              // indicatorDecoration: BoxDecoration(
                              // color: Colors.blueAccent,
                              // borderRadius: BorderRadius.circular(10)),
                              // ),

                              //     Row(
                              //   mainAxisAlignment: MainAxisAlignment.center,
                              //   children: imgList.asMap().entries.map((entry) {
                              //     return GestureDetector(
                              //       onTap: () => _controller.animateToPage(entry.key),
                              //       child: Container(
                              //         width: 12.0,
                              //         height: 12.0,
                              //         margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                              //         decoration: BoxDecoration(
                              //             shape: BoxShape.circle,
                              //             color: (Theme.of(context).brightness == Brightness.dark
                              //                     ? Colors.white
                              //                     : Colors.black)
                              //                 .withOpacity(_current == entry.key ? 0.9 : 0.4)),
                              //       ),
                              //     );
                              //   }).toList(),
                              // ),

                              // Positioned(
                              //     right: 30.w,
                              //     child: IconButton(
                              //         onPressed: () {},
                              //         icon: Icon(
                              //           Icons.favorite,
                              //           color: Colors.white,
                              //         ))),

                          
                                 
               
            
                  
                                   Positioned(
                                      right: 30.w,
                                      child: FavoriteButton(
                                       isFavorite:  _viewFav() ,
                                        valueChanged: (_isFavorite) {
                                         
                                            
                                          
                                         
                                          print('Is Favorite : $_isFavorite');
                                          _isFavorite == false
                                              ? FavoriteApiController().unFavourite(
                                                  context,
                                                  id: widget.id.toString())
                                              : FavoriteApiController()
                                                  .addToFavourite(context,
                                                      id: widget.id.toString());
                              
                                                    
                                        },
                                        
                                        
                                      )
                                      ),


                                      
                               
                               

                                
                              
                              Positioned(
                                  left: 30.w,
                                  child: IconButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      icon: Icon(
                                        Icons.arrow_back_ios,
                                        color: Colors.white,
                                      ))),
                            ],
                          ),
                          
                          Padding(
                            padding: const EdgeInsets.only(top: 40, left: 120),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                
                                 Text(
                                  _details[index].categoryName,
                                  style: TextStyle(
                                      fontFamily: 'Tj',
                                      color: Colors.black,
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  ' | ',
                                  style: TextStyle(
                                      fontFamily: 'Tj',
                                      color: Colors.black,
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  _details[index].typeName,
                                  style: TextStyle(
                                      fontFamily: 'Tj',
                                      color: Colors.black,
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  ' | ',
                                  style: TextStyle(
                                      fontFamily: 'Tj',
                                      color: Colors.black,
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.bold),
                                ),

                                Text(
                                  _details[index].tabooName,
                                  style: TextStyle(
                                      fontFamily: 'Tj',
                                      color: Colors.black,
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.bold),
                                ),
                                 
                                SizedBox(
                                  width: 40.w,
                                ),
                                // Text('${homeModel.totalPrice}''د.ع', style: TextStyle(fontFamily: 'Tj', fontSize: 16.sp, color: Color(0xff3D6CF0), fontWeight: FontWeight.bold),)
                              ],
                            ),
                          ),
                          // Padding(
                          //   padding: const EdgeInsets.only(top: 40, left: 260),
                          //   child: Text(
                          //     _details[index].typeName,
                          //     // textAlign: TextAlign.right,
                          //     textDirection: TextDirection.rtl,
                          //     style: TextStyle(
                          //         fontFamily: 'Tj',
                          //         color: Colors.black,
                          //         fontSize: 18.sp,
                          //         fontWeight: FontWeight.bold),
                          //   ),
                          // ),

                          Padding(
                            padding: const EdgeInsets.only(top: 5, right: 20),
                            child: Directionality(
                              textDirection: TextDirection.rtl,
                              child: Row(
                                children: [
                                  SvgPicture.asset(
                                    'images/location.svg',
                                    color: Color(0xff797979),
                                  ),
                                  SizedBox(
                                    width: 5.w,
                                  ),
                                  Text(
                                    _details[index].cityName,
                                    textDirection: TextDirection.rtl,
                                    style: TextStyle(
                                      fontFamily: 'Tj',
                                      fontSize: 14.sp,
                                      color: Color(0xff797979),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 25, left: 290),
                            child: Text(
                              'السعر',
                              textDirection: TextDirection.rtl,
                              style: TextStyle(
                                  fontFamily: 'Tj',
                                  fontSize: 18.sp,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          GetBuilder<OptionGetxController>(
                            init: OptionGetxController(),
                            initState: (_) {},
                            builder: (controller) {
                              return Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Column(
                                    children: [
                          _details[index].categoryId =="2"?           Text(
                                        'السعر للمتر ',
                                        textDirection: TextDirection.rtl,
                                        style: TextStyle(
                                          fontFamily: 'Tj',
                                          fontSize: 14.sp,
                                          color: Color(0xff797979),
                                        ),
                                      ):   Text(
                                        'السعر الشهري',
                                        textDirection: TextDirection.rtl,
                                        style: TextStyle(
                                          fontFamily: 'Tj',
                                          fontSize: 14.sp,
                                          color: Color(0xff797979),
                                        ),
                                      ),
                                      Text(
                                        _details[index].meterPrice ?? '',
                                        textDirection: TextDirection.rtl,
                                        style: TextStyle(
                                          fontFamily: 'Tj',
                                          fontSize: 14.sp,
                                          color: Color(0xff797979),
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  SvgPicture.asset('images/dollar.svg'),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Row(
                                    children: [
                                      Column(
                                        children: [
                                     _details[index].categoryId =="2"?        Text(
                                            'السعر الكلي',
                                            textDirection: TextDirection.rtl,
                                            style: TextStyle(
                                              fontFamily: 'Tj',
                                              fontSize: 14.sp,
                                              color: Color(0xff797979),
                                            ),
                                          ) :  Text(
                                            'السعر السنوي ',
                                            textDirection: TextDirection.rtl,
                                            style: TextStyle(
                                              fontFamily: 'Tj',
                                              fontSize: 14.sp,
                                              color: Color(0xff797979),
                                            ),
                                          ),
                                          Text(
                                            _details[index].totalPrice,
                                            textDirection: TextDirection.rtl,
                                            style: TextStyle(
                                              fontFamily: 'Tj',
                                              fontSize: 14.sp,
                                              color: Color(0xff797979),
                                            ),
                                          )
                                        ],
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      SvgPicture.asset('images/dollar.svg'),
                                      SizedBox(
                                        width: 20,
                                      ),
                                    ],
                                  )
                                ],
                              );
                            },
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 25, left: 220, bottom: 10),
                            child: Text(
                              'تفاصيل العقار ',
                              textDirection: TextDirection.rtl,
                              style: TextStyle(
                                  fontFamily: 'Tj',
                                  fontSize: 18.sp,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Wrap(
                            runSpacing: 5.0,
                            spacing: 5.0,
                            children: [
                              Text(
                                'عدد الغرف ' + _details[index].rooms,
                                style: TextStyle(
                                  fontFamily: 'Tj',
                                  fontSize: 12.sp,
                                  color: Colors.black,
                                ),
                              ),

                              SvgPicture.asset(
                                'images/house.svg',
                                height: 18.h,
                                width: 18.w,
                                color: Color(0xff797979),
                              ),

                              // SizedBox(

                              //   width: 5.w,

                              // ),

                              Text(
                                'رقم العقار ' + _details[index].number ??
                                    'الرقم لا يوجد ',
                                style: TextStyle(
                                  fontFamily: 'Tj',
                                  fontSize: 12.sp,
                                  color: Colors.black,
                                ),
                              ),

                              // SizedBox(

                              //   width: 5.w,

                              // ),

                              SvgPicture.asset(
                                'images/num.svg',
                                height: 18.h,
                                width: 18.w,
                                color: Color(0xff797979),
                              ),

                              // SizedBox(

                              //   width: 5.w,

                              // ),

                              Text(
                                _details[index].tabooName,
                                style: TextStyle(
                                  fontFamily: 'Tj',
                                  fontSize: 12.sp,
                                  color: Colors.black,
                                ),
                              ),

                              // SizedBox(

                              //   width: 5.w,

                              // ),

                              SvgPicture.asset(
                                'images/cat.svg',
                                height: 18.h,
                                width: 18.w,
                                color: Color(0xff797979),
                              ),

                              // SizedBox(

                              //   width: 5.w,

                              // ),

                              Text(
                                'طابق عدد ' + _details[index].floors,
                                style: TextStyle(
                                  fontFamily: 'Tj',
                                  fontSize: 12.sp,
                                  color: Colors.black,
                                ),
                              ),

                              // SizedBox(

                              //   width: 5.w,

                              // ),

                              SvgPicture.asset(
                                'images/buliding.svg',
                                height: 18.h,
                                width: 18.w,
                                color: Color(0xff797979),
                              ),
                            ],
                          ),
                           

                          Padding(
                            padding: const EdgeInsets.only(top: 25, left: 220),
                            child: Text(
                              'مميزات العقار ',
                              textDirection: TextDirection.rtl,
                              style: TextStyle(
                                  fontFamily: 'Tj',
                                  fontSize: 18.sp,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 260, top: 10),
                            child: Text(
                              _details[index].features[index].featureName,
                              textDirection: TextDirection.rtl,
                              style: TextStyle(
                                fontFamily: 'Tj',
                                fontSize: 14.sp,
                                color: Color(0xff797979),
                              ),
                            ),
                          ),
                           
                          Padding(
                            padding: const EdgeInsets.only(top: 25, left: 220),
                            child: Text(
                              'وصف العقار ',
                              textDirection: TextDirection.rtl,
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                  fontFamily: 'Tj',
                                  fontSize: 18.sp,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10, bottom: 20),
                            child: Text(
                              _details[index].description,
                              textDirection: TextDirection.rtl,
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                fontFamily: 'Tj',
                                fontSize: 14.sp,
                                color: Color(0xff797979),
                              ),
                            ),
                          ),

                          ElevatedButton.icon(
                              style: ElevatedButton.styleFrom(
                                primary: Color(0xff3D6CF0),
                                minimumSize: Size(320, 60),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15)),
                              ),
                              onPressed: () {
                                launch("tel://+9647800012163");
                              },
                              icon: Icon(Icons.call),
                              label: Text(
                                'اتصل الان ',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'Tj',
                                    fontSize: 20.sp),
                              ))
//  Padding(
//    padding: const EdgeInsets.all(20.0),
//    child: CustomButton(onPress: (){

//    }, text: 'اتصل الآن ', color: Color(0xff3D6CF0), ),
//  )
                        ],
                      );
                    });
              } else {
                return Center(
                  child: Text(
                    'No Data',
                    style: TextStyle(color: Colors.black),
                  ),
                );
              }
            }));
  }
}
