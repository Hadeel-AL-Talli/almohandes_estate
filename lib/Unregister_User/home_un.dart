import 'package:almohandes_estate/models/home.dart';
import 'package:almohandes_estate/models/option.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:provider/provider.dart';

import '../Provider/building_provider_vandor.dart';
import '../get/options_getx_controller.dart';
import '../screens/Home/main_screen.dart';
import '../widgets/homeWidget.dart';
import '../widgets/search_form.dart';




class HomeUN extends StatefulWidget {
  const HomeUN({Key? key}) : super(key: key);

  @override
  State<HomeUN> createState() => _HomeUNState();
}

class _HomeUNState extends State<HomeUN> {
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
                        child: SvgPicture.asset("images/Filter.svg"),
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
                      height: 40.h,
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
                              margin: EdgeInsets.symmetric(horizontal: 16.w),
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
                      height: 70.h,
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
                              margin: EdgeInsets.symmetric(horizontal: 8.w),
                              width: MediaQuery.of(context).size.width / 5,
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
                              margin: EdgeInsets.symmetric(horizontal: 8.w),
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
                                    style: TextStyle(fontFamily: 'Tj', fontSize: 14.sp,
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
                                    // Navigator.push(context,
                                    //     MaterialPageRoute(builder: (context) {
                                    //       print(value.listSelected[index].id);
                                    //   return  BuildingDetails(id: value.listSelected[index].id);
                                      
                                    //     }
                                    //     ));
                                  
                                  },
                                  child: homewidget(
                                    homeModel:value.listSelected[index] ,
                                    // tabo: 'طابو صرف',

                                  ));
                            },);
                        }
                        else
                        {
                          return Center(child: Text("لا يوجد نتائج ",
                          style: TextStyle(fontFamily: 'Tj',fontSize: 14.sp, color: Colors.black ,fontWeight: FontWeight.bold,)));
                        }
                      },),

                  ],
                ),
              ),
            ],
          );
        } else {
          return Center(child: Text("لا يوجد نتائج ",
                          style: TextStyle(fontFamily: 'Tj',fontSize: 14.sp, color: Colors.black ,fontWeight: FontWeight.bold,)));
        }
      });
  }
}
