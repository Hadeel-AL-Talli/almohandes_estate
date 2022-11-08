import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../controllers/home_api_controller.dart';
import '../../get/options_getx_controller.dart';
import '../../models/home.dart';
import '../../prefs/shared_prefrences_controller.dart';
import '../../widgets/homeWidget.dart';
import '../../widgets/search_form.dart';
import '../building_details.dart';


class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  RangeValues _currentRangeValues = RangeValues(
      double.parse(SharedPrefController().min.toString()),
      double.parse(SharedPrefController().max.toString()));
  String categoryId = "";
  String typeId = "";
  String tabooId = "";
  String cityId = "";
  List<HomeModel> homeModel=[];
  static String _valueToString(double value) {
    return value.toStringAsFixed(0);
  }
 late TextEditingController textEditingController;
  List<HomeModel>? listSelected;
  bool loding = false;
  List<HomeModel> listSharsh=[];

  Future<List<HomeModel>?> getData({
    String priceMin = "",
    String priceMax = "",
  }) async {
    listSelected = await HomeApiController().search(
      category: categoryId,
      city: cityId,
      priceMax: priceMax,
      priceMin: priceMin,
      type: tabooId,
    );
    return listSelected;
  }


  @override
  void initState() {
    textEditingController=TextEditingController();
    OptionGetxController.to.getOptions();
    // TODO: implement initState
    super.initState();
  }
@override
  void dispose() {
  textEditingController.dispose();
    // TODO: implement dispose
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return GetBuilder<OptionGetxController>(builder: (controller) {
      if (controller.loading) {
        return Center(
          child: CircularProgressIndicator(),
        );
      } else if (controller.options != null) {
        return  listSelected != null ? ListView(
          physics: BouncingScrollPhysics(),
          shrinkWrap: true,
          children: [
            TextFormField(
              controller: textEditingController,
              onSaved: (value) {},
              onChanged: (value) {
                for(int i=0;i<listSelected!.length;i++)
                {
                  if(listSelected![i].title.toLowerCase().contains(value.toLowerCase()))
                  {
                    listSharsh.add(listSelected![i]);
                  }
                }
                setState(() {
                });
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
                  padding: EdgeInsets.symmetric(
                      horizontal: 16, vertical: 8),
                  child: SizedBox(
                    width: 48,
                    height: 48,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Color(0xff3D6CF0),
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                        ),
                      ),
                      onPressed: () {
                        setState(() {
                          listSelected=null;
                        });
                      },
                      child: SvgPicture.asset("images/Filter.svg"),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
         textEditingController.text.isNotEmpty? ListView.builder(
           itemCount: listSharsh.length,
           shrinkWrap: true,
           physics: NeverScrollableScrollPhysics(),
           itemBuilder: (context, index) {
             return InkWell(
                 onTap: () {
                   Navigator.push(context,
                       MaterialPageRoute(
                           builder: (context) => BuildingDetails(id:homeModel[index].id )));
                 },
                 child: homewidget(
                   homeModel: listSharsh[index],
                   // tabo: 'طابو صرف',
                 ));
           },):
         ListView.builder(
              itemCount: listSelected!.length,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return InkWell(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(
                              builder: (context) => BuildingDetails(id: homeModel[index].id,)));
                    },
                    child: homewidget(
                      homeModel: listSelected![index],
                      // tabo: 'طابو صرف',
                    ));
              },)

          ],
        ):
        ListView(
          physics: BouncingScrollPhysics(),
          shrinkWrap: true,
          children: [
            SizedBox(
              height: 30.h,
            ),
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
            controller.options!.categories.isNotEmpty ? SizedBox(
              height: 40.h,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: controller.options!.categories.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return InkWell(
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
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 16.w),
                      width: MediaQuery
                          .of(context)
                          .size
                          .width / 4,
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
            ) : SizedBox(),
            SizedBox(
              height: 20.h,
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
            controller.options!.types.isNotEmpty ? SizedBox(
              height: 70.h,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: controller.options!.types.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
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
                      setState(() {});
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 8.w),
                      width: MediaQuery
                          .of(context)
                          .size
                          .width / 5,
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
                                ? Colors.white : Color(0xff797979),
                          ),
                          Center(
                              child: Text(
                                controller.options!.types[index].name,
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
            ) : SizedBox(),
            SizedBox(
              height: 10.h,
            ),
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
            controller.options!.cities.isNotEmpty ? SizedBox(
              height: 40.h,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: controller.options!.cities.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
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
                      setState(() {});
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 8.w),
                      width: MediaQuery
                          .of(context)
                          .size
                          .width / 4,
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
            ) : SizedBox(),
            SizedBox(
              height: 10.h,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 10.0, bottom: 10),
              child: Text(
                'السعر',
                textDirection: TextDirection.rtl,
                style: TextStyle(
                    fontFamily: 'Tj',
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold),
              ),
            ),
            RangeSlider(
              values: _currentRangeValues,
              min: double.parse(SharedPrefController().min.toString()),
              max: double.parse(SharedPrefController().max.toString()),
              // min: 1000,
              // max: 10000000,
              divisions: 10,
              labels: RangeLabels(
                _currentRangeValues.start.round().toString(),
                _currentRangeValues.end.round().toString(),
              ),
              onChanged: (RangeValues values) {
                setState(() {
                  _currentRangeValues = values;
                });
                print( _currentRangeValues.start.round().toString(),);
              },
            ),
            SizedBox(
              height: 20.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
             loding?Center(child: CircularProgressIndicator(),):   ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Color(0xff3D6CF0),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      minimumSize: const Size(150, 50),
                    ),
                    onPressed: () async{
                      setState(() {
                        loding=true;

                      });
                      await getData(
                        priceMin:_currentRangeValues.start.round().toString(),
                        priceMax: _currentRangeValues.end.round().toString()
                      );
                      setState(() {
                        loding=false;

                      });
                    },
                    child: Text('عرض النتائج',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w900,
                            fontFamily: 'Tj'))),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      minimumSize: const Size(150, 50),
                    ),
                    onPressed: () {
                      
                    },
                    child: Text('إعادة تعيين',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w900,
                            fontFamily: 'Tj')))
              ],
            )
          ],
        );
      } else {
        return Text("No Data");
      }
    });
  }

}

