import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/svg.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../screens/Home/model/bn_screens.dart';
import '../screens/Home/search.dart';
import 'FavoriteUn.dart';
import 'ProfileUN.dart';
import 'home_un.dart';

class MainScreenUN extends StatefulWidget {
  const MainScreenUN({Key? key}) : super(key: key);

  @override
  State<MainScreenUN> createState() => _MainScreenUNState();
}

class _MainScreenUNState extends State<MainScreenUN> {
   int _currentIndex = 0;
  final List<BnScreen> _bnScreens = <BnScreen>[
    
    const BnScreen(title: 'الرئيسية', widget: HomeUN()),
    const BnScreen(title: 'الفلتر', widget: Search()),
    const BnScreen(title: 'مميزة', widget: FavoriteUn()),
    const BnScreen(title: 'حسابي', widget: ProfileUN()),
  ];
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
       appBar: AppBar(
        
           leading: 
            IconButton(onPressed: (){
            //  Navigator.pushNamed(context, '/notifications');
            }, icon: Image.asset('images/notification.png'), color: Colors.black,),
       
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.white,
          title: Text(_bnScreens[_currentIndex].title, style: TextStyle(fontFamily: 'Tj',fontSize: 24.sp, color: Colors.black )),
        ),
    
        body: _bnScreens[_currentIndex].widget,
         bottomNavigationBar: BottomNavigationBar(
                  onTap: (int value) {
            setState(() {
              _currentIndex = value;
            });
          },
          currentIndex: _currentIndex,
           type: BottomNavigationBarType.fixed,
    
          showSelectedLabels: true,
          showUnselectedLabels: true,
    
          backgroundColor: Colors.white,
          elevation: 10,
    
           selectedItemColor: Colors.blueAccent,
          selectedIconTheme: IconThemeData(color: Colors.blueAccent),
          selectedFontSize: 18,
          selectedLabelStyle:
             TextStyle(fontFamily: 'Tj'),
    
          unselectedItemColor: Colors.grey,
          unselectedIconTheme: IconThemeData(color: Colors.grey.shade700),
          unselectedFontSize: 12,
          unselectedLabelStyle:
              TextStyle(fontFamily: 'Tj', color: Color(0xff848484)),
          iconSize: 16,
          items: [
          BottomNavigationBarItem(
              backgroundColor: Colors.blueAccent,
              icon: SvgPicture.asset('images/homeuns.svg',),
              activeIcon:SvgPicture.asset('images/homeuns.svg',color: Color(0xff3D6CF0),),
              label: 'الرئيسية',
            ),
              BottomNavigationBarItem(
              backgroundColor: Colors.blueAccent,
              icon: SvgPicture.asset('images/search.svg',),
              activeIcon:SvgPicture.asset('images/search.svg',color: Color(0xff3D6CF0),),
              label: 'بحث',
            ),
              BottomNavigationBarItem(
              backgroundColor: Colors.blueAccent,
              icon: SvgPicture.asset('images/heart.svg',),
              activeIcon:SvgPicture.asset('images/heart.svg',color: Color(0xff3D6CF0),),
              label: 'مميزة',
            ),
              BottomNavigationBarItem(
              backgroundColor: Colors.blueAccent,
              icon: SvgPicture.asset('images/profile.svg',),
              activeIcon:SvgPicture.asset('images/profile.svg',color: Color(0xff3D6CF0),),
              label: 'حسابي',
            ),
    
         ]),
    floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    floatingActionButton: FloatingActionButton(
      backgroundColor: Color(0xff3D6CF0),
      child: SvgPicture.asset('images/float.svg'),
      onPressed: (){
        Navigator.pushNamed(context, '/unregister');
      }, )
      ),
    );
  }
}