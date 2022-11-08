import 'package:get/get.dart';

import '../controllers/add_build_controller.dart';
import '../models/option.dart';


class OptionGetxController extends GetxController{
Data? options;
bool loading = false;
static OptionGetxController get to => Get.find<OptionGetxController>();
final AddBuildingController _apiController = AddBuildingController();
@override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getOptions();
  }


  Future<void> getOptions() async {
    loading = true;
    options = await _apiController.showOptions();
    loading = false;
    update();
  }

}