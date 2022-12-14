import 'package:almohandes_estate/prefs/shared_prefrences_controller.dart';
import 'package:almohandes_estate/screens/Home/profile.dart';
import 'package:almohandes_estate/screens/Home/search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/svg.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'favorite.dart';
import 'home.dart';
import 'model/bn_screens.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key,this.currentIndex=0}) : super(key: key);
 final int currentIndex;
  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
 late  int _currentIndex ;
  final List<BnScreen> _bnScreens = <BnScreen>[
    
    const BnScreen(title: 'الرئيسية', widget: Home()),
    const BnScreen(title: 'الفلتر', widget: Search()),
    const BnScreen(title: 'مميزة', widget: Favorite()),
    const BnScreen(title: 'حسابي', widget: Profile()),
  ];
  @override
  void initState() {
    _currentIndex=widget.currentIndex;
    // TODO: implement initState
    super.initState();
  }
  Future<void> _copyToClipboard() async {
    await Clipboard.setData(ClipboardData(text: SharedPrefController().token));
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('Copied to clipboard'),
    ));
  }
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
    //    extendBodyBehindAppBar: false,
    //     resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
       appBar: AppBar(
         leading: 
            IconButton(onPressed: (){
              Navigator.pushNamed(context, '/notifications');
            }, icon: Icon(Icons.notifications) , color: Colors.black,),
        actions: [
          // TextButton(onPressed: (){
          //   _copyToClipboard();
          // }, child: Container(
          //   color: Colors.red,
          //   child: Text(SharedPrefController().token)))
        ],
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
        Navigator.pushNamed(context, '/addBuilding');
      }, )
      ),
    );
  }
}