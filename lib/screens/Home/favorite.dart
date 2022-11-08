import 'dart:core';
import 'dart:core';

import 'package:favorite_button/favorite_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../controllers/favorite_api_controller.dart';
import '../../models/favorite.dart';
import '../building_details.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';




class Favorite extends StatefulWidget {
  const Favorite({Key? key}) : super(key: key);

  @override
  State<Favorite> createState() => _FavoriteState();
}

class _FavoriteState extends State<Favorite> {
   late Future<List<FavoriteModel>> _future;

    List<FavoriteModel> _favourite = <FavoriteModel>[];
    
    @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _future = FavoriteApiController().getFav();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
body: FutureBuilder<List<FavoriteModel>>(
  future: _future,
  builder: (context, snapshot) {
   if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          else if (snapshot.hasData && snapshot.data!.isNotEmpty){
             _favourite = snapshot.data ?? [];
           return   ListView.builder(
    itemCount: _favourite.length,
    itemBuilder: ((context, index) {
    return InkWell(
      onTap: (){
          Navigator.push(context,
                                        MaterialPageRoute(builder: (context) {
                                        
                                      return  BuildingDetails(id: _favourite[index].id);
                                      
                                        }
                                        ));
      },
      child: Container(
         padding: EdgeInsets.all(10),
        margin: EdgeInsets.all(20),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(10)
        ),
        child: Column(
          children: [
           
            Stack(
              children: [
                Image.network(_favourite[index].images),
               // Image.asset('images/code.png'),
                Positioned(
              top:20.h,
              right: 10.w,
               child: Container(
                
               width: 80.w,
               height: 40.h,
               child: FavoriteButton(
                isFavorite: true,
                valueChanged: (_isFavorite){
              _isFavorite == false?    FavoriteApiController().removeFavorite(context, id: _favourite[index].id):FavoriteApiController().addFavorite(context, id: _favourite[index].id) ;
    
                })
               ),
             ),
              ],
            ),
    SizedBox(height: 10.h,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                  Text(
      _favourite[index].totalPrice+'د.ع',
      textDirection: TextDirection.rtl,
      style: TextStyle(
          fontFamily: 'Tj',
          fontSize: 18.sp,
          color: Color(0xff3D6CF0),
          fontWeight: FontWeight.bold),
      ),
                Text(
      _favourite[index].title,
      textDirection: TextDirection.rtl,
      style: TextStyle(
          fontFamily: 'Tj',
          fontSize: 18.sp,
          color: Colors.black,
          fontWeight: FontWeight.bold),
      ),
              ],
            ),
    Padding(
      padding: const EdgeInsets.only( top: 5, right: 25),
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
            _favourite[index].location,
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
    
    
    Row(
       mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
       Text(
      'عدد الغرف '+ _favourite[index].rooms,
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
      
       
       
      Text(
        _favourite[index].tabooName,
        style: TextStyle(
          fontFamily: 'Tj',
          fontSize: 12.sp,
          color: Colors.black,
        ),
      ),
       
      
      
      SvgPicture.asset(
        'images/buliding.svg',
        height: 18.h,width: 18.w,
        color: Color(0xff797979),
      ),
    
       Text(
      'مساحة'+ _favourite[index].size,
        style: TextStyle(
          fontFamily: 'Tj',
          fontSize: 12.sp,
          color: Colors.black,
        ),
      ),
      SvgPicture.asset(
        'images/dollar.svg',
        height: 18.h,width: 18.w,
        color: Color(0xff797979),
      ),
      
      
      ],
    ),
          ],
        ),
      ),
    );
  }
  ));

          }

          else{
            return Column(
              children: [
                SizedBox(height: 60.h,),
                Image.asset('images/noFav.png'),
                SizedBox(height: 40.h,),
                Center(child: Text('لا توجد عقارات مفضلة حالياً', style: TextStyle(fontFamily: 'Tj', fontSize:24.sp,color: Colors.black ),)),
                SizedBox(height: 10.h,),
    Center(child: Text('اضغط على رمز القلب الذي بقرب العقار \n لاضافته الى قائمة العقارات المميزة', style: TextStyle(fontFamily: 'Tj', fontSize:14.sp,color: Color(0xff8A8A8A) ),))

              ],
            );
          }
},
),
    );
  }
}