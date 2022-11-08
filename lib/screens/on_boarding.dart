import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../widgets/on_boarding_content.dart';
import '../widgets/on_boarding_indicator.dart';

class OnBoarding extends StatefulWidget {
  const OnBoarding({Key? key}) : super(key: key);

  @override
  _OnBoardingState createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  late PageController _pageController;
  int _currentpage = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
      body: ListView(
      
        children: [
        
          ConstrainedBox(
            constraints:  BoxConstraints(
                minWidth: 0,
                maxWidth: double.infinity,
                minHeight: 0,
                maxHeight: 700.h),
            child: PageView(
                controller: _pageController,
                scrollDirection: Axis.horizontal,
                onPageChanged: (value) {
                  setState(() {
                    _currentpage = value;
                    print(value);
                  });
                },
                children: [
                  
                  OnBoardingContent(
                  
                    imagepath: 'images/on1.png',
                    title: 'ابحث الآن عن منزل أحلامك  ',
                    subTitle:
                        ' الان كل ما عليك البحث عن منطقتك \n واحصل على أفضل عروض العقارات ',
                      
                  ),
                  
                  OnBoardingContent(
                    imagepath: 'images/on2.png',
                    title: 'نوفر أفضل عروض العقارات ',
                    subTitle:
                        'يمكنك الان الاستمتاع بالعديد من العروض المميزة وبامكانك شراء,ايجار,واستثمار العقارات...',
                  ),
                  OnBoardingContent(
                    imagepath: 'images/on3.png',
                    title: 'ابدأ الان لتجد منزلك المثالي ',
                    subTitle: 'تعرف على أحدث العقارات التي تضاف بشكل يومي على التطبيق وتحقق من الأسعار ',
                    
                  ),

                  
                ]),
          ),
        Row(
            mainAxisAlignment: MainAxisAlignment.center,
         
            children: [
              OnBoardingIndicator(
                marginEnd: 10,
                selected: _currentpage == 0,
              ),
              OnBoardingIndicator(
                marginEnd: 10,
                selected: _currentpage == 1,
              ),
              OnBoardingIndicator(
                selected: _currentpage == 2,
              )
            ],
          ),
        
        ],
      ),
    );
  }
}
