import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../controllers/add_build_controller.dart';
import '../../get/options_getx_controller.dart';
import '../../helpers/helpers.dart';
import '../../models/option.dart';
import '../../prefs/shared_prefrences_controller.dart';
import '../../widgets/app_text_feild.dart';
import '../../widgets/custom_button.dart';


class AddBuilding extends StatefulWidget {
  const AddBuilding({Key? key}) : super(key: key);

  @override
  State<AddBuilding> createState() => _AddBuildingState();
}

class _AddBuildingState extends State<AddBuilding> with Helpers {
//  OptionGetxController _optionGetxController = Get.put(OptionGetxController());
  List<Categories> categories = <Categories>[];
  List<Types> types = <Types>[];
  List<Taboos> taboos = <Taboos>[];
  List<Cities> cities = <Cities>[];
  List<Features> features = <Features>[];
  String categoryId = "";
  String typeId = "";
  String tabooId = "";
  String cityId = "";
  String featuresId = "";
  List<String> featuresIdList=[]; 
  late TextEditingController title;
  late TextEditingController point;
  late TextEditingController interface;
  late TextEditingController totalSpase;

  late TextEditingController nzal;
  late TextEditingController area;
  late TextEditingController street;
  late TextEditingController number;
  late TextEditingController meter_price;
  late TextEditingController total_price;
  late TextEditingController floornum;
  late TextEditingController location;
  late TextEditingController rooms;
  late TextEditingController description;
  late TextEditingController name;
  late TextEditingController phone;
  ImagePicker _imagePicker = ImagePicker();
  List<XFile?> listImage = [];
  bool loding = false;
  int? selectedtype ;
  int? selectedcate;
  bool isChecked = false;
  bool isChecked2 = false;

  // Future<void> _pickImage() async {
  //   XFile? imageFile = await _imagePicker.pickImage(
  //       source: ImageSource.camera, imageQuality: 50);
  //   if (imageFile != null) {
  //     setState(() {
  //       listImage.add(imageFile);
  //     });
  //     // AppLocalizations.of(context)!.getstarted,
  //   }
  // }
  Future<void> _openCamera(BuildContext context) async {
    XFile? imageFile = await _imagePicker.pickImage(
        source: ImageSource.camera, imageQuality: 50);

       
    if (imageFile != null) {
      setState(() {
        listImage.add(imageFile);
       
      });
      // AppLocalizations.of(context)!.getstarted,
    } 

    
    // Navigator.pop(context);

    
  }

  Future<void> _openGallery(BuildContext context) async {
    
    final pickedFile = await _imagePicker.pickImage(
      source: ImageSource.gallery,
    );
    print(pickedFile);
   
    if (pickedFile != null) {
      setState(() {
        listImage.add(pickedFile);

       
        
      });
      
    }
    
  
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    OptionGetxController.to.getOptions();
  title = TextEditingController();
    point = TextEditingController();
    interface = TextEditingController();
    nzal = TextEditingController();
    area = TextEditingController();
    street = TextEditingController();
    number = TextEditingController();
    totalSpase = TextEditingController();

    meter_price = TextEditingController();
    total_price = TextEditingController();
    floornum = TextEditingController();
    location = TextEditingController();
    rooms = TextEditingController();
    description = TextEditingController();
    name = TextEditingController()..text=SharedPrefController().name;
    phone = TextEditingController()..text=SharedPrefController().phone!="null"?SharedPrefController().phone:"";
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    point.dispose();
    interface.dispose();
    nzal.dispose();
    area.dispose();
    street.dispose();
    number.dispose();
    meter_price.dispose();
    total_price.dispose();
    floornum.dispose();
    location.dispose();
    rooms.dispose();
    description.dispose();
    name.dispose();
    phone.dispose();
    totalSpase.dispose();
    title.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios),
          color: Colors.black,
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text('إضافة عقار ',
            style: TextStyle(
                fontFamily: 'Tj', fontSize: 24.sp, color: Colors.black)),
      ),
      body: GetBuilder<OptionGetxController>(builder: (controller) {
        if (controller.loading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (controller.options != null) {
          return ListView(
            physics: BouncingScrollPhysics(),
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 10.0, bottom: 10),
                child: Text(
                  'نوع العملية',
                  textDirection: TextDirection.rtl,
                  style: TextStyle(
                      fontFamily: 'Tj',
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                height: 50.h,
                child: ListView.builder(
                  reverse: true,
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemCount: controller.options!.categories.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        InkWell(
                          onTap: () {
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
                            setState(() {});
                            //change color
                            print('index $index');
                            selectedcate = index;
                            
                            
                          },
                          child: Container(
                              margin: EdgeInsets.only(left: 10, right: 20),
                              width: MediaQuery.of(context).size.width / 4,
                              height: 40.h,
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
                                      controller
                                          .options!.categories[index].name,
                                      style: TextStyle(
                                          fontFamily: 'Tj',
                                          fontSize: 14.sp,
                                          color: controller.options!
                                                  .categories[index].selected
                                              ? Colors.white
                                              : Colors.black)))),
                        ),
                      ],
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 10.0, bottom: 10),
                child: Text(
                  'نوع العقار',
                  textDirection: TextDirection.rtl,
                  style: TextStyle(
                      fontFamily: 'Tj',
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                height: 50.h,
                child: ListView.builder(
                  reverse: true,
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemCount: controller.options!.types.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        InkWell(
                          onTap: () {
                            for (int i = 0;
                                i < controller.options!.types.length;
                                i++) {
                              controller.options!.types[i].selected = false;
                            }
                            controller.options!.types[index].selected = true;
                            typeId =
                                controller.options!.types[index].id.toString();
                            setState(() {});
                            print('index $index');
                            selectedtype = index;
                          },
                          child: Container(
                              margin: EdgeInsets.only(left: 10, right: 20),
                              width: MediaQuery.of(context).size.width / 5,
                              height: 40.h,
                              decoration: BoxDecoration(
                                color: controller.options!.types[index].selected
                                    ? Color(0xff3D6CF0)
                                    : Colors.white,
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Center(
                                  child: Text(
                                      controller.options!.types[index].name,
                                      style: TextStyle(
                                          fontFamily: 'Tj',
                                          fontSize: 14.sp,
                                          color: controller.options!
                                                  .types[index].selected
                                              ? Colors.white
                                              : Colors.black)))),
                        ),
                      ],
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 10.0, bottom: 10),
                child: Text(
                  'جنس العقار',
                  textDirection: TextDirection.rtl,
                  style: TextStyle(
                      fontFamily: 'Tj',
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                height: 50.h,
                child: ListView.builder(
                  reverse: true,
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        InkWell(
                          onTap: () {
                            for (int i = 0;
                                i < controller.options!.taboos.length;
                                i++) {
                              controller.options!.taboos[i].selected = false;
                            }
                            controller.options!.taboos[index].selected = true;
                            tabooId =
                                controller.options!.taboos[index].id.toString();
                            setState(() {});
                            print('index $index');
                          },
                          child: Container(
                              margin: EdgeInsets.only(left: 10, right: 20),
                              width: MediaQuery.of(context).size.width / 4,
                              height: 40.h,
                              decoration: BoxDecoration(
                                color:
                                    controller.options!.taboos[index].selected
                                        ? Color(0xff3D6CF0)
                                        : Colors.white,
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Center(
                                  child: Text(
                                      controller.options!.taboos[index].taboo,
                                      style: TextStyle(
                                          fontFamily: 'Tj',
                                          fontSize: 14.sp,
                                          color: controller.options!
                                                  .taboos[index].selected
                                              ? Colors.white
                                              : Colors.black)))),
                        ),
                      ],
                    );
                  },
                  itemCount: controller.options!.taboos.length,
                ),
              ),
              /** Cities */
              Padding(
                padding: const EdgeInsets.only(right: 10.0, bottom: 10),
                child: Text(
                  'المنطقة',
                  textDirection: TextDirection.rtl,
                  style: TextStyle(
                      fontFamily: 'Tj',
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                height: 50.h,
                child: ListView.builder(
                  reverse: true,
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        InkWell(
                          onTap: () {
                            for (int i = 0;
                                i < controller.options!.cities.length;
                                i++) {
                              controller.options!.cities[i].selected = false;
                            }
                            controller.options!.cities[index].selected = true;
                            cityId =
                                controller.options!.cities[index].id.toString();

                            setState(() {});
                            //change color
                            print('index $index');
                          },
                          child: Container(
                              margin: EdgeInsets.only(left: 10, right: 20),
                              width: MediaQuery.of(context).size.width / 5,
                              height: 40.h,
                              decoration: BoxDecoration(
                                color:
                                    controller.options!.cities[index].selected
                                        ? Color(0xff3D6CF0)
                                        : Colors.white,
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Center(
                                  child: Text(
                                      controller.options!.cities[index].name,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontFamily: 'Tj',
                                          fontSize: 14.sp,
                                          color: controller.options!
                                                  .cities[index].selected
                                              ? Colors.white
                                              : Colors.black)))),
                        ),
                      ],
                    );
                  },
                  itemCount: controller.options!.cities.length,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 10.0, bottom: 10),
                child: Text(
                  'مميزات الموقع',
                  textDirection: TextDirection.rtl,
                  style: TextStyle(
                      fontFamily: 'Tj',
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                height: 50.h,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        InkWell(
                          onTap: () {
                            if(controller.options!.features[index].selected){
                              controller.options!.features[index].selected = false;
                              featuresIdList.remove(controller.options!.features[index].id
                                  .toString());
                            }
                            else
                            {
                              controller.options!.features[index].selected = true;
                              featuresIdList.add(controller.options!.features[index].id
                                  .toString());
                            }
                            setState(() {});
                            //change color
                            print('index $index');
                            print(featuresIdList);
                          },
                          child: Container(
                              margin: EdgeInsets.only(left: 10, right: 20),
                              width: MediaQuery.of(context).size.width / 5,
                              height: 40.h,
                              decoration: BoxDecoration(
                                color:
                                    controller.options!.features[index].selected
                                        ? Color(0xff3D6CF0)
                                        : Colors.white,
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Center(
                                  child: Text(
                                      controller.options!.features[index].name,
                                      style: TextStyle(
                                          fontFamily: 'Tj',
                                          fontSize: 14.sp,
                                          color: controller.options!
                                                  .features[index].selected
                                              ? Colors.white
                                              : Colors.black)))),
                        ),
                      ],
                    );
                  },
                  itemCount: controller.options!.features.length,
                ),
              ),
              
               
              Padding(
                padding: const EdgeInsets.only(right: 10.0, bottom: 10, top: 10),
                child: Text(
                  'أقرب نقطة دالة',
                  textDirection: TextDirection.rtl,
                  style: TextStyle(
                      fontFamily: 'Tj',
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(left: 20.0, right: 15, bottom: 15),
                child: AppTextField(hint: '', controller: point),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 15.0, bottom: 10),
                child: Text(
                  'الواجهة',
                  textDirection: TextDirection.rtl,
                  style: TextStyle(
                      fontFamily: 'Tj',
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(left: 20.0, right: 15, bottom: 10),
                child: AppTextField(hint: '15 متر ', controller: interface),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 15.0, bottom: 10),
                child: Text(
                  'النزال',
                  textDirection: TextDirection.rtl,
                  style: TextStyle(
                      fontFamily: 'Tj',
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(left: 20.0, right: 15, bottom: 10),
                child: AppTextField(hint: '10 متر ', controller: nzal),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 15.0, bottom: 10),
                child: Text(
                  'المساحة الكلية',
                  textDirection: TextDirection.rtl,
                  style: TextStyle(
                      fontFamily: 'Tj',
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(left: 20.0, right: 15, bottom: 10),
                child: AppTextField(hint: '200 متر ', controller: totalSpase),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 15.0, bottom: 10),
                child: Text(
                  'عرض الشارع',
                  textDirection: TextDirection.rtl,
                  style: TextStyle(
                      fontFamily: 'Tj',
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(left: 20.0, right: 15, bottom: 10),
                child: AppTextField(hint: '20 متر ', controller: street),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 15.0, bottom: 10),
                child: Text(
                  'رقم العقار',
                  textDirection: TextDirection.rtl,
                  style: TextStyle(
                      fontFamily: 'Tj',
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 15),
                child: AppTextField(hint: '78555', controller: number),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text('بدون رقم', style: TextStyle(
                      fontFamily: 'Tj',
                      fontSize: 12.sp,
                      color: Color(0xff3D6CF0),),),
                  Checkbox(
                  value: isChecked,
                  onChanged: (value) {
                    setState(() {
                      isChecked = value!;
                    });
                  },
            ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Visibility(
                 visible: selectedcate!=1,
                child: Padding(
                  padding: const EdgeInsets.only(right: 15.0, bottom: 10),
                  child: Text(
                    'السعر',
                    textDirection: TextDirection.rtl,
                    style: TextStyle(
                        fontFamily: 'Tj',
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Visibility(
                visible: selectedcate!=1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      width: 150.w,
                      child: AppTextField(
                        //controller.options!.categories.first.name =="بيع"? 
                          hint:selectedcate ==2?'السعر للمتر':'السعر الشهري', controller: meter_price),
                    ),
                    Container(
                        width: 150.w,
                        child: AppTextField(
                            hint: selectedcate==2?'السعر الاجمالي ':'السعر السنوي', controller: total_price)),
                  ],
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Visibility(
              
                visible: selectedtype ==1 ,
                child: Padding(
                  padding: const EdgeInsets.only(right: 15.0, bottom: 10),
                  child: Text(
                    'عدد الطوابق ',
                    textDirection: TextDirection.rtl,
                    style: TextStyle(
                        fontFamily: 'Tj',
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Visibility(
                visible: selectedtype ==1,
                // visible: controller.options!.categories.first.name =="عمارة"||controller.options!.categories.first.id ==3,
                child: Padding(
                  padding:
                      const EdgeInsets.only(left: 20.0, right: 15, bottom: 10),
                  child: AppTextField(hint: '5', controller: floornum),
                ),
              ),
              Visibility(
                visible: selectedtype==2,
                child: Padding(
                  padding: const EdgeInsets.only(right: 15.0, bottom: 10),
                  child: Text(
                    'رقم الطابق',
                    textDirection: TextDirection.rtl,
                    style: TextStyle(
                        fontFamily: 'Tj',
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Visibility(
                visible:   selectedtype==2, 
                child: Padding(
                  padding:
                      const EdgeInsets.only(left: 20.0, right: 15, bottom: 10),
                  child: AppTextField(hint: '3', controller: location),
                ),
              ),
              Visibility(
                visible: selectedtype==2 || selectedtype ==3,
                child: Padding(
                  padding: const EdgeInsets.only(right: 15.0, bottom: 10),
                  child: Text(
                    'عدد الغرف ',
                    textDirection: TextDirection.rtl,
                    style: TextStyle(
                        fontFamily: 'Tj',
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Visibility(
                 visible: selectedtype==2 || selectedtype ==3,
                child: Padding(
                  padding:
                      const EdgeInsets.only(left: 20.0, right: 15, bottom: 10),
                  child: AppTextField(hint: '2', controller: rooms),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 15.0, bottom: 10),
                child: Text(
                  'وصف العقار ',
                  textDirection: TextDirection.rtl,
                  style: TextStyle(
                      fontFamily: 'Tj',
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(left: 20.0, right: 15, bottom: 10),
                child:
                    AppTextField(hint: 'وصف العقار ', controller: description),
              ),

              /**Upload  Images  */
              Padding(
                padding: const EdgeInsets.only(right: 15.0, bottom: 10),
                child: Text(
                  'رفع الصور الخاصة بالعقار',
                  textDirection: TextDirection.rtl,
                  style: TextStyle(
                      fontFamily: 'Tj',
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold),
                ),
              ),
             
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: DottedBorder(
                  color: Color(0xff1180EC),
                  strokeWidth: 2,
                  borderType: BorderType.RRect,
                  radius: Radius.circular(10.r),
                  dashPattern: [8, 4],
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                    child: Column(children: [
                      InkWell(
                          onTap: () async {
                            await _openCamera(context);
                          },
                          child: Image.asset("images/camera.png")),
                      SizedBox(
                        height: 14.h,
                      ),
                      InkWell(
                          onTap: () async {
                            await _openGallery(context);
                          },
                          child: Image.asset("images/galary.png")),
                    ]),
                  ),
                ),
              ),
              //  Directionality(
              //   textDirection: TextDirection.rtl,
              //    child: Padding(
              //     padding: const EdgeInsets.all(15.0),
              //     child: Text('*اذا كنت لا تملك صورة للعقار ارفق اي صورة افتراضية', style: TextStyle(fontFamily: 'Tj', color: Colors.red),),
              //                ),
              //  ),
              Directionality(
                textDirection: TextDirection.rtl,
                child: Row(
                  
                      children: <Widget>[
                      
                        Checkbox(
                          checkColor: Colors.white,
                          value: isChecked2,
                          onChanged: (bool? value) {
                setState(() {
                  isChecked2 = value!;
                  print(isChecked2);
                });
                          },
                        ),
                 Text('لا يوجد صورة ', style: TextStyle(fontFamily: 'Tj', color: Colors.red)),
                      ],
                    ),
              ),
   
              SizedBox(
                height: 16.h,
              ),
              listImage.isNotEmpty?  SizedBox(
                height: 150.h,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  itemCount: listImage.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: DottedBorder(
                        color: Color(0xff1180EC),
                        strokeWidth: 2,
                        borderType: BorderType.RRect,
                        radius: Radius.circular(10.r),
                        dashPattern: [8, 4],
                        child: Container(
                          width: 120.w,
                          height: 150.h,
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                          child: Stack(
                            children: [
                              Center(
                                child: Image.file(
                                  File(listImage[index]!.path),
                                  fit: BoxFit.fill,
                                ),
                              ),
                              Center(
                                child: IconButton(
                                  onPressed: () {
                                    listImage.remove(listImage[index]);
                                    setState(() {});
                                  },
                                  icon: Icon(
                                    Icons.cancel_outlined,
                                    color: Colors.blue,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ):SizedBox(),
              SizedBox(
                height: 16.h,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 15.0, bottom: 10),
                child: Text(
                  'بيانات التواصل ',
                  textDirection: TextDirection.rtl,
                  style: TextStyle(
                      fontFamily: 'Tj',
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 15.0, bottom: 10),
                child: Text(
                  'الاسم',
                  textDirection: TextDirection.rtl,
                  style: TextStyle(
                      fontFamily: 'Tj',
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff3D6CF0)),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(left: 20.0, right: 15, bottom: 10),
                child: AppTextField(hint: 'الاسم', controller: name),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 15.0, bottom: 10),
                child: Text(
                  'رقم الهاتف',
                  textDirection: TextDirection.rtl,
                  style: TextStyle(
                      fontFamily: 'Tj',
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff3D6CF0)),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(left: 20.0, right: 15, bottom: 10),
                child: AppTextField(hint: 'رقم الهاتف', controller: phone),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 15.0, bottom: 10),
                child: Text(
                  '*لن تظهر معلوماتك في الاعلان والغرض منها هو التواصل معكم ',
                  textDirection: TextDirection.rtl,
                  style: TextStyle(
                      fontFamily: 'Tj',
                      fontSize: 12.sp,
                      color: Color(0xff3D6CF0)),
                ),
              ),
              loding?Center(child: CircularProgressIndicator(),):  Padding(
                padding: const EdgeInsets.all(20.0),
                child: CustomButton(
                    onPress: () async{
                      setState(() {
                        loding=true;
                      });
                      if(checkData())
                      {
                        await addBuilding();
                      }
                      setState(() {
                        loding=false;
                      });
                    },
                    text: 'نشر عقارك ',
                    color: Color(0xff3D6CF0)),
              )
            ],
          );
        } else {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(Icons.warning, size: 80),
              Center(
                  child: Text(
                'No Data !',
                style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 22,
                    fontWeight: FontWeight.bold),
              )),
            ],
          );
        }
      }),
    );
  }

  bool checkData() {
    if (categoryId.isNotEmpty &&
        tabooId.isNotEmpty &&
        typeId.isNotEmpty &&
        featuresIdList.isNotEmpty&&point.text.isNotEmpty && phone.text.isNotEmpty) {
      // if (listImage.isEmpty  ) {
       
      //   return true;
      // } else {
      //   print(listImage);
      //   // showSnackBar(
      //   //   context: context,
      //   //   message: ' يجب اضافة صورة واحدة على الاقل أو اختيار خيار لا يوجد صورة',
      //   //   error: true,
      //   // );
      // }
      return true;
    }
    showSnackBar(
      context: context,
      message: 'يرجى ادخال البيانات المطلوبة !!',
      error: true,
    );
    return false;
  }

  Future<void> addBuilding() async {
    for (int i = 0; i < featuresIdList.length; i++) {
      if (featuresId.isEmpty) {
        featuresId = featuresIdList[i];
      } else {
        featuresId = "$featuresId,${featuresIdList[i]}";
      }
    }
    print(featuresId+"featuresId");
    
    await AddBuildingController().propertyAdd(
        uploadImageCallback: (
            {required String message,
            required String status,
            apiRespons}) async {
            
          if (status == "200") {
            showSnackBar(context: context, message: message);
            Navigator.pushNamed(context, '/accepet');
          } else {
          
            showSnackBar(context: context, message: message, error: true);
          }
        },
        title: '',
        location: point.text.toString(),
        total_price: total_price.text.toString(),
        meter_price: meter_price.text.toString(),
        floors: floornum.text.toString(),
        property_floor: location.text.toString(),
        size: totalSpase.text.toString(),
        number: number.text.toString(),
        rooms: rooms.text.toString(),
        nzal: nzal.text.toString(),
        front: interface.text.toString(),
        street: street.text.toString(),
        description: description.text.toString(),
        lease_type: '',
        category: categoryId,
        type: typeId,
        taboo: tabooId,
        city: cityId,
        name: name.text.toString(),
        phone: phone.text.toString(),
        features: featuresId,
        images: listImage);

    
  }
  
}
