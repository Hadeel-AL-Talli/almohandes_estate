import 'package:almohandes_estate/screens/building_details.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../controllers/my_posts_controller.dart';
import '../../models/my_post.dart';
import '../../widgets/custom_button.dart';

class MyPosts extends StatefulWidget {
  const MyPosts({Key? key}) : super(key: key);

  @override
  State<MyPosts> createState() => _MyPostsState();
}

class _MyPostsState extends State<MyPosts> {
  late Future<List<MyPostsModel>> _future;
  List<MyPostsModel> _myposts = <MyPostsModel>[];
 String text='حالة العقار';

 Color color = Colors.white;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _future = MyPostController().getMyPosts();
   
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(
         leading: 
            IconButton(onPressed: (){
              Navigator.pop(context);
            }, icon: Icon(Icons.arrow_back_ios) , color: Colors.black,),
        
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.white,
          title: Text('منشوراتي', style: TextStyle(fontFamily: 'Tj',fontSize: 24.sp, color: Colors.black )),
        ),

        body: FutureBuilder<List<MyPostsModel>>(
          future: _future,
          
          builder: (context, snapshot){
                if(snapshot.connectionState == ConnectionState.waiting){
  return Center(child: CircularProgressIndicator(),);
}
else if(snapshot.hasData && snapshot.data!.isNotEmpty){
  _myposts = snapshot.data ??[];
  return ListView.builder(
    physics: BouncingScrollPhysics(),
    itemCount: _myposts.length,
    itemBuilder: ((context, index) {
    return InkWell(
      onTap: (){
         Navigator.push(context, MaterialPageRoute(builder: (context) {
           return  BuildingDetails(id: _myposts[index].id,);
         },));
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
                //
      //           CachedNetworkImage(
      //     imageUrl: _myposts[index].images!,
      //     placeholder: (context, url) => new CircularProgressIndicator(),
      //     errorWidget: (context, url, error) => new Icon(Icons.error),
      //  ),
           Image.network(_myposts[index].images! ,
           errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
      // Return a default image if the API image fails to load
      return Image.network('https://app1.tp-iraq.com/property_images/default.png');
      },
           ),
               // Image.asset('images/code.png'),
                Positioned(
              top:20.h,
              right: 10.w,
               child: Container(
                
               width: 80.w,
               height: 40.h,
               child: CustomButton(onPress: (){
                confirmDelete(_myposts[index].id.toString());
               }, text: 'حذف', color: Colors.white, textcolor: Colors.black,)),
             ),
             
             Positioned(
              top:20.h,
              left: 0.w,
               child: Container(
               padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color:_myposts[index].status =='0'? Colors.blueAccent:_myposts[index].status =='1'?Colors.green:Colors.red,
                  border: Border.all(color: Colors.white),
                  borderRadius: BorderRadius.circular(10)
                ),
              
              child: Text(_myposts[index].status =='0'? 'معلق':_myposts[index].status =='1'?'مقبول':'مرفوض', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w900,
                  fontFamily: 'Tj', fontSize: 16), ),
              //  child: CustomButton(
              //   onPress: (){
              //    String statusnum;
                 
              //     switch (_myposts[index].status) {
              //      case '0':
              //        statusnum = 'معلق';
              //        setState(() {
              //          text = statusnum;
              //          color = Colors.blueAccent;
              //        });
                      
                    
              //        break;
              //        case '1':
              //  statusnum = 'مقبول';
              //  setState(() {
              //  text = statusnum;
              //   color = Colors.green;
              //  });
               
               
              //        break;
               
              //        case '-1':
              //        statusnum = 'مرفوض';
              //        setState(() {
              //          text = statusnum;
              //           color = Colors.red;
              //        });
                 
               
              //        break;
              //      default:
              //    }
                
            //    }, text:
            //      text
               
            //    , color: color, textcolor: Colors.black,
            //  //  )
               ),
             ),
              ],
            ),
    SizedBox(height: 10.h,),
            Row(
            //  mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                          Text('${_myposts[index].totalPrice}''د.ع', style: TextStyle(fontFamily: 'Tj', fontSize: 16.sp, color: Color(0xff3D6CF0), fontWeight: FontWeight.bold),),
                          SizedBox(width: 40.w,),
    
                   Text(_myposts[index].tabooName  , style: TextStyle(fontFamily: 'Tj', color: Colors.black,fontSize: 14.sp),),
                      Text(' | ', style: TextStyle(fontFamily: 'Tj', color: Colors.black,fontSize: 14.sp),),
    
            Text(_myposts[index].typeName  , style: TextStyle(fontFamily: 'Tj', color: Colors.black,fontSize: 14.sp),),
    
           // SizedBox(width: 40.w,),
      //               Text(
      //   _myposts[index].totalPrice+'د.ع',
      //   textDirection: TextDirection.rtl,
      //   style: TextStyle(
      //       fontFamily: 'Tj',
      //       fontSize: 18.sp,
      //       color: Color(0xff3D6CF0),
      //       fontWeight: FontWeight.bold),
      // ),
      //             Text(
      //   _myposts[index].tabooName,
      //   textDirection: TextDirection.rtl,
      //   style: TextStyle(
      //       fontFamily: 'Tj',
      //       fontSize: 18.sp,
      //       color: Colors.black,
      //       fontWeight: FontWeight.bold),
      // ),
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
            _myposts[index].location,
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
      'عدد الغرف '+ _myposts[index].rooms,
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
        _myposts[index].tabooName,
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
      'مساحة'+ _myposts[index].size,
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


} else{
  return Center(child: Column(
    
    children: [
      SizedBox(height: 80.h,),
      Image.asset('images/noposts.png', height: 200.h,),
      SizedBox(height: 30.h,),
      Text('لا توجد منشورات حتى الان', textDirection: TextDirection.rtl,style: TextStyle(fontFamily: 'Tj', fontSize: 24.sp,color: Colors.black, fontWeight: FontWeight.w400),),
      SizedBox(height: 5,),
    Text('قم بإضافة منشورات جديدة ليتم عرضها هنا ', textDirection: TextDirection.rtl,style: TextStyle(fontFamily: 'Tj', fontSize: 14.sp,color: Color(0xff8A8A8A), ),),


    ],
  ),);

}

        })
    );

    
  }


   confirmDelete(String Id){
    showDialog(context: context, builder: (BuildContext context)=>AlertDialog(
     // content:Text( 'هل ترغب حقاً أن تحذف المنشور', style: TextStyle(fontFamily: 'Tj', fontSize: 20.sp, fontWeight: FontWeight.w500),),
    title: Text( 'هل ترغب حقاً أن تحذف المنشور', style: TextStyle(fontFamily: 'Tj', fontSize: 20.sp, fontWeight: FontWeight.w500),),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                
                minimumSize: Size(120,50),
                primary: Colors.white,
                shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              ),
              onPressed: (){
                Navigator.pop(context);
              }, child: Text('إلغاء', style: TextStyle(fontFamily: 'Tj', color: Colors.black,fontSize: 14.sp),)),
            ElevatedButton(
          style: ElevatedButton.styleFrom(
             minimumSize: Size(120,50),
         shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          ),
          onPressed: () async{
await MyPostController().deletePost(context, id:Id);

Navigator.of(context).pop();
setState(() {
   _future = MyPostController().getMyPosts();
});

//Navigator.push(context, MaterialPageRoute(builder: ((context) =>MyPosts())));
        }, child: Text('حذف',style: TextStyle(fontFamily: 'Tj', fontSize: 14.sp, fontWeight: FontWeight.w500),)
        ),

        
          ],
        )
        

       
        
      ],
    ));
  }
}