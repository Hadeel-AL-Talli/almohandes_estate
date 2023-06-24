import 'package:flutter/material.dart';

import '../controllers/home_api_controller.dart';
import '../models/home.dart';

class BuildingProvider extends ChangeNotifier {

  List<HomeModel> listSelected = [];
  List<HomeModel> listBased = [];
  List<HomeModel> listSherch= [];

  final HomeApiController _HomeApiController = HomeApiController();
  bool loding = true;

  Future<void> getData({
    String category = "",
    String type = "",
    String city = "",
    String priceMin = "",
    String priceMax = "",
  }) async {
    loding = true;
    listSelected = await _HomeApiController.search(
      category: category,
      city: city,
      priceMax: priceMax,
      priceMin: priceMin,
      type: type,
    );
    listBased=listSelected;
    loding = false;
    notifyListeners();
  }
  Future<void> sherch({
    String text = "",
  }) async {
    loding = true;
    listSherch.clear();
    notifyListeners();
    for(int i=0;i<listBased.length;i++)
    {
      //typeName + city
      if(listBased[i].tabooName.toLowerCase().contains(text.toLowerCase()) || listBased[i].typeName.toLowerCase().contains(text.toLowerCase()) )
      {
        listSherch.add(listBased[i]);
      }
    }
    listSelected=listSherch;
    loding = false;
    notifyListeners();
  }
}