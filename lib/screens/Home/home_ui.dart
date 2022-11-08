// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/src/foundation/key.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:real_estate/screens/building_details.dart';
// import 'package:real_estate/widgets/homeWidget.dart';
// import 'package:real_estate/widgets/search_form.dart';
//
// class Home extends StatefulWidget {
//   const Home({Key? key}) : super(key: key);
//
//   @override
//   State<Home> createState() => _HomeState();
// }
//
// class _HomeState extends State<Home> {
//   bool isClicked = false;
//
//   @override
//   Widget build(BuildContext context) {
//     return ListView(
//       physics: BouncingScrollPhysics(),
//       children: [
//        SearchForm(
//
//        ),
//         Image.asset('images/slider.png'),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceAround,
//           children: [
//             Container(
//               width: MediaQuery.of(context).size.width/4,
//               height: 30.h,
//               decoration: BoxDecoration(
//                 border: Border.all(color: Colors.grey),
//                 borderRadius: BorderRadius.circular(5),
//
//
//               ),
//               child: Center(child: Text('ايجار', style: TextStyle(fontFamily: 'Tj', fontSize: 14.sp),)),
//             ),
//             Container(
//               width: MediaQuery.of(context).size.width/4,
//               height: 30.h,
//               decoration: BoxDecoration(
//                 border: Border.all(color: Colors.grey),
//                 borderRadius: BorderRadius.circular(5),
//
//               ),
//               child: Center(child: Text('شراء', style: TextStyle(fontFamily: 'Tj', fontSize: 14.sp),)),
//             ),
//
//             Container(
//               width: MediaQuery.of(context).size.width/4,
//               height: 30.h,
//               decoration: BoxDecoration(
//                 border: Border.all(color: Colors.grey),
//                 borderRadius: BorderRadius.circular(5),
//
//               ),
//               child: Center(child: Text('استثمار', style: TextStyle(fontFamily: 'Tj', fontSize: 14.sp),)),
//             ),
//           ],
//         ),
//         SizedBox(height: 5.h,),
//         /** Row 2  */
//
// Row(
//   mainAxisAlignment: MainAxisAlignment.spaceAround,
//   children: [
//
//      Container(
//               width: MediaQuery.of(context).size.width/5,
//               height: 60.h,
//               decoration: BoxDecoration(
//                 border: Border.all(color: Colors.grey),
//                 borderRadius: BorderRadius.circular(5),
//
//               ),
//               child: Column(
//                 children: [
//                   SizedBox(height: 10.h,),
//                   SvgPicture.asset('images/hous.svg', ),
//                   Center(child: Text('منزل', style: TextStyle(fontFamily: 'Tj', fontSize: 14.sp),)),
//                 ],
//               ),
//             ),
//              Container(
//               width: MediaQuery.of(context).size.width/5,
//               height: 60.h,
//               decoration: BoxDecoration(
//                 border: Border.all(color: Colors.grey),
//                 borderRadius: BorderRadius.circular(5),
//
//               ),
//               child: Column(
//                 children: [
//                   SizedBox(height: 10.h,),
//                   SvgPicture.asset('images/buildings-2.svg', ),
//                   Center(child: Text('شقة', style: TextStyle(fontFamily: 'Tj', fontSize: 14.sp),)),
//                 ],
//               ),
//             ),
//            Container(
//               width: MediaQuery.of(context).size.width/5,
//               height: 60.h,
//               decoration: BoxDecoration(
//                 border: Border.all(color: Colors.grey),
//                 borderRadius: BorderRadius.circular(5),
//
//               ),
//               child: Column(
//                 children: [
//                   SizedBox(height: 10.h,),
//                   SvgPicture.asset('images/buildings.svg',color: Color(0xff797979), ),
//                   Center(child: Text('عمارة', style: TextStyle(fontFamily: 'Tj', fontSize: 14.sp),)),
//                 ],
//               ),
//             ),
//             Container(
//               width: MediaQuery.of(context).size.width/5,
//               height: 60.h,
//               decoration: BoxDecoration(
//                 border: Border.all(color: Colors.grey),
//                 borderRadius: BorderRadius.circular(5),
//
//               ),
//               child: Column(
//                 children: [
//                   SizedBox(height: 10.h,),
//                   SvgPicture.asset('images/building-4.svg',color: Color(0xff797979), ),
//                   Center(child: Text('أرض', style: TextStyle(fontFamily: 'Tj', fontSize: 14.sp),)),
//                 ],
//               ),
//             ),
//   ],
// ),
// SizedBox(height: 5.h,),
// /**Row 3 */
// Row(
//   mainAxisAlignment: MainAxisAlignment.spaceAround,
//   children: [
//       Container(
//               width: MediaQuery.of(context).size.width/5,
//               height: 30.h,
//               decoration: BoxDecoration(
//                 border: Border.all(color: Colors.grey),
//                 borderRadius: BorderRadius.circular(5),
//
//               ),
//               child: Center(child: Text('وطأة الكلفة', style: TextStyle(fontFamily: 'Tj', fontSize: 14.sp),)),
//             ),
//               Container(
//               width: MediaQuery.of(context).size.width/5,
//               height: 30.h,
//               decoration: BoxDecoration(
//                 border: Border.all(color: Colors.grey),
//                 borderRadius: BorderRadius.circular(5),
//
//               ),
//               child: Center(child: Text('مركز المدينة', style: TextStyle(fontFamily: 'Tj', fontSize: 14.sp),)),
//             ),
//               Container(
//               width: MediaQuery.of(context).size.width/5,
//               height: 30.h,
//               decoration: BoxDecoration(
//                 border: Border.all(color: Colors.grey),
//                 borderRadius: BorderRadius.circular(5),
//
//               ),
//               child: Center(child: Text('التأميم', style: TextStyle(fontFamily: 'Tj', fontSize: 14.sp),)),
//             ),
//               Container(
//               width: MediaQuery.of(context).size.width/5,
//               height: 30.h,
//               decoration: BoxDecoration(
//                 border: Border.all(color: Colors.grey),
//                 borderRadius: BorderRadius.circular(5),
//
//               ),
//               child: Center(child: Text('ال5 كيلو', style: TextStyle(fontFamily: 'Tj', fontSize: 14.sp),)),
//             ),
//   ],
// ),
//
// SizedBox(height: 10.h,),
//         InkWell(
//           onTap: (){
//             Navigator.push(context, MaterialPageRoute(builder: (context)=> BuildingDetails()));
//           },
//           child: homewidget(
//             image: 'images/example.png',
//             title: 'بيت الخلفونا| شقة | للبيع ',
//             total_price: '20000',
//             location: 'الرمادي, الشارع اللي ماندله',
//             size: '200',
//             tabo_id:'طابو صرف',
//             rooms: '6',
//           )
//           ),
//
//
//       ],
//     );
//   }
// }
