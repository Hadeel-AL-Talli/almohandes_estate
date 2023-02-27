import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../models/home.dart';


class homewidget extends StatelessWidget {
  const homewidget({
    Key? key,
    required this.homeModel,
    // required this.tabo
  }) : super(key: key);

final  HomeModel homeModel;
// final String tabo;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.all(20),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade200),
        borderRadius: BorderRadius.circular(10)
      ),
      child: Column(
        children: [
      //  Image.network(homeModel.images, fit: BoxFit.fill,),
       Image.network(homeModel.images!=null&&homeModel.images!.isNotEmpty?
       homeModel.images![0].image:"", fit: BoxFit.fill,),
       
       SizedBox(height: 10.h,),
       Row(
       // mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
                    Text(homeModel.tabooName  , style: TextStyle(fontFamily: 'Tj', color: Colors.black,fontSize: 14.sp),),
                    Text(' | ', style: TextStyle(fontFamily: 'Tj', color: Colors.black,fontSize: 14.sp),),

          Text(homeModel.typeName  , style: TextStyle(fontFamily: 'Tj', color: Colors.black,fontSize: 14.sp),),

          SizedBox(width: 40.w,),
          Text('${homeModel.totalPrice}''د.ع', style: TextStyle(fontFamily: 'Tj', fontSize: 16.sp, color: Color(0xff3D6CF0), fontWeight: FontWeight.bold),)
        ],
       ),
       SizedBox(height: 10.h,),
        Row(
       // mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SvgPicture.asset('images/location.svg', color:Color(0xff797979) ,),
          SizedBox(width: 5.w,),
          Text(homeModel.location, style: TextStyle(fontFamily: 'Tj', fontSize: 14.sp, color: Color(0xff797979),),)
        ],
       ),
       SizedBox(height: 10.h,),
 Row(
       // mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
         SizedBox(width: 10.w,),
          SvgPicture.asset('images/max.svg', color:Color(0xff797979),),
          SizedBox(width: 10.w,),
          Text(homeModel.size, style: TextStyle(fontFamily: 'Tj', fontSize: 14.sp, color: Colors.black,),),
          SizedBox(width: 5.w,),
           SvgPicture.asset('images/cat.svg', color:Color(0xff797979) ,),
         SizedBox(width: 10.w,),
          Text(homeModel.tabooName, style: TextStyle(fontFamily: 'Tj', fontSize: 14.sp, color: Colors.black,),),
        SizedBox(width: 10.w,),
           SvgPicture.asset('images/house.svg', color:Color(0xff797979) ,),
          SizedBox(width: 5.w,),
          Text(homeModel.rooms, style: TextStyle(fontFamily: 'Tj', fontSize: 14.sp, color: Colors.black,),)
        ],
       ),

        ],
      ),
    );
  }
}