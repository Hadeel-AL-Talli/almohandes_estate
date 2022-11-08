
import 'package:get/get.dart';

import '../controllers/home_api_controller.dart';
import '../models/home.dart';



class HomeGetxController extends GetxController{
  HomeModel? home;
  bool loading = false;
  final HomeApiController _apiController = HomeApiController();


  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    // getHome();

  }

// Future<void> getHome() async {
//     loading = true;
//     home = await _apiController.showHome();
//     loading = false;
//     update();
//   }

  
}