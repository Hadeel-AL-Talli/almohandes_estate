import 'package:carousel_slider/carousel_slider.dart';
import 'package:favorite_button/favorite_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';

import '../controllers/favorite_api_controller.dart';
import '../controllers/home_api_controller.dart';


import '../controllers/home_api_controller.dart';
import '../models/details.dart';

class BuildingDetails extends StatefulWidget {
  const BuildingDetails({Key? key , required this.id}) : super(key: key);
  final int id;


  @override
  State<BuildingDetails> createState() => _BuildingDetailsState();
}

class _BuildingDetailsState extends State<BuildingDetails> {
  int _current = 0;
  late Future<List<Details>> _future;
  List<Details> _details = <Details>[];
   List<Images> _images = <Images>[];
  final CarouselController _controller = CarouselController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('load data');
    _future = HomeApiController().getDetails(widget.id.toString());
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: FutureBuilder<List<Details>>(
        future: _future,
        builder: (context,snapShot){
if(snapShot.connectionState == ConnectionState.waiting){
  return Center(child: CircularProgressIndicator(),);
}
else if(snapShot.hasData && snapShot.data!.isNotEmpty){
  _details = snapShot.data ?? [];
 return ListView.builder(
  itemCount: _details.length,
  itemBuilder: (context,index){
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
                        height: 300.h,
                        autoPlay: true,
                       // viewportFraction: 0.8,
                        enlargeCenterPage: true,
                        aspectRatio: 16/9,
                        autoPlayAnimationDuration:
                            const Duration(seconds: 1),
                        autoPlayCurve: Curves.fastOutSlowIn,
                        initialPage: 0,
                        enableInfiniteScroll: true,
                        reverse: false,
                        autoPlayInterval: const Duration(seconds: 3)),
                    itemCount: _images.length,
                    itemBuilder: (BuildContext context, int itemIndex,
                            int pageViewIndex) =>
                        Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                            image: NetworkImage(_details[index].images[itemIndex].image),
                            fit: BoxFit.cover),
                      ),
                    ),
                    
                  ),
                  
                  
                ),

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
            isFavorite: false,
              valueChanged: (_isFavorite){
                 print('Is Favorite : $_isFavorite');
            _isFavorite == false?  
            FavoriteApiController().addFavorite(context, id: widget.id)
             : FavoriteApiController().removeFavorite(context, id: widget.id)
               ;
              
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
  padding: const EdgeInsets.only(top:40,left: 220 ),
  child: Text(
    _details[index].title,
   // textAlign: TextAlign.right,
    textDirection: TextDirection.rtl,
    style: TextStyle(
        fontFamily: 'Tj',
        color: Colors.black,
        fontSize: 18.sp,
        fontWeight: FontWeight.bold),
  ),
),
Padding(
  padding: const EdgeInsets.only( top: 5, right: 20),
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
          _details[index].location,
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
  padding: const EdgeInsets.only(top: 25,left: 290 ),
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
Row(
  mainAxisAlignment: MainAxisAlignment.spaceAround,
  children: [
    Column(
      children: [
        Text(
          'السعر للمتر',
          textDirection: TextDirection.rtl,
          style: TextStyle(
            fontFamily: 'Tj',
            fontSize: 14.sp,
            color: Color(0xff797979),
          ),
        ),
        Text(
          _details[index].meterPrice,
          textDirection: TextDirection.rtl,
          style: TextStyle(
            fontFamily: 'Tj',
            fontSize: 14.sp,
            color: Color(0xff797979),
          ),
        )
      ],
    ),
    SvgPicture.asset('images/dollar.svg'),
    Row(
      children: [
        Column(
          children: [
            Text(
              'السعر الكلي',
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
        SvgPicture.asset('images/dollar.svg')
      ],
    )
  ],
),
Padding(
  padding: const EdgeInsets.only(top: 25, left: 220),
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
SingleChildScrollView(
  scrollDirection: Axis.horizontal,
  child:   Row(
  
     mainAxisAlignment: MainAxisAlignment.start,
  
    children: [
  
       Text(
  
      'عدد الغرف '+ _details[index].rooms,
  
        style: TextStyle(
  
          fontFamily: 'Tj',
  
          fontSize: 12.sp,
  
          color: Colors.black,
  
        ),
  
      ),
  
      SvgPicture.asset(
  
        'images/house.svg',
  
        height: 18.h,width: 18.w,
  
        color: Color(0xff797979),
  
      ),
  
      // SizedBox(
  
      //   width: 5.w,
  
      // ),
  
     
  
        Text(
  
       'رقم العقار ' + _details[index].number ??'الرقم لا يوجد ',
  
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
  
        height: 18.h,width: 18.w,
  
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
  
  
  
        height: 18.h,width: 18.w,
  
        color: Color(0xff797979),
  
      ),
  
      // SizedBox(
  
      //   width: 5.w,
  
      // ),
  
      Text(
  
       'طابق عدد '+ _details[index].floors,
  
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
  
        height: 18.h,width: 18.w,
  
        color: Color(0xff797979),
  
      ),
  
    
  
    ],
  
  ),
),

 Padding(
  padding: const EdgeInsets.only( top: 25, left: 220),
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
   padding: const EdgeInsets.only(left: 260, top:10),
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
    style: TextStyle(
        fontFamily: 'Tj',
        fontSize: 18.sp,
        color: Colors.black,
        fontWeight: FontWeight.bold),
  ),
),
 Padding(
   padding: const EdgeInsets.only(left: 20, top:10, right: 40),
   child: Text(
           _details[index].description,
            textDirection: TextDirection.rtl,
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
      minimumSize: Size(320,60),
      shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      
    ),
    onPressed: (){
     
       launch("tel://+96407832170007");
    }, icon: Icon(Icons.call), label: Text('اتصل الان ', style: TextStyle(color:Colors.white , fontFamily: 'Tj', fontSize: 20.sp),))
//  Padding(
//    padding: const EdgeInsets.all(20.0),
//    child: CustomButton(onPress: (){

//    }, text: 'اتصل الآن ', color: Color(0xff3D6CF0), ),
//  )
        ],
      );
 });
}
else {
  return Center(child: Text('No Data', style: TextStyle(color: Colors.black),),);
}
        }
        )
    );
  }
}
