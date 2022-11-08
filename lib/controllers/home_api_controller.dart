import 'dart:convert';


import 'package:http/http.dart' as http;

import '../models/details.dart';
import '../models/home.dart';
import '../prefs/shared_prefrences_controller.dart';
import 'api_helper.dart';
import 'api_settings.dart';


class HomeApiController with ApiHelper {
  Future<List<HomeModel>> showHome() async {
    var url = Uri.parse(ApiSettings.home);
    var response = await http.get(
      url,
      headers: {'Content-type': 'application/json'},
    );

    if (response.statusCode == 200) {
      var categoriesJsonArray = jsonDecode(response.body)['data'] as List;
      return categoriesJsonArray
          .map((jsonObject) => HomeModel.fromJson(jsonObject))
          .toList();
    }
    return [];
  }

  Future<List<HomeModel>> search({
    String category = "",
    String type = "",
    String city = "",
    String priceMin = "",
    String priceMax = "",
  }) async {
    var url = Uri.parse(ApiSettings.search);
    var response = await http.post(url, headers: {
      'Accept': 'application/json'
    }, body: {
      "category": category,
      "type": type,
      "city":city,
      "price_min": priceMin,
      "price_max": priceMax,
    });

    if (response.statusCode == 200) {
      var categoriesJsonArray = jsonDecode(response.body)['data'] as List;
      return categoriesJsonArray
          .map((jsonObject) => HomeModel.fromJson(jsonObject))
          .toList();
    }
    return [];
  }

  Future<void> getPriceMaxMin() async {
    var url = Uri.parse(ApiSettings.minmax);
    var response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      var categoriesJsonArray = jsonDecode(response.body)['data'] as List;
      List<PriceMaxMin> list = categoriesJsonArray
          .map((jsonObject) => PriceMaxMin.fromJson(jsonObject))
          .toList();
      if (list.isNotEmpty) {
        await SharedPrefController().saveMaxMin(priceMaxMin: list[0]);
      }
    }
  }
     Future<List<Details>> getDetails(String id )async{
      var url = Uri.parse(ApiSettings.propertyDetails.replaceFirst("{id}", id));
      print(url);
      var response = await http.get(url, headers: headers);
      if (response.statusCode ==200){
        var propertyDetailsJsonArray = jsonDecode(response.body)['data']as List;
        return  propertyDetailsJsonArray
        .map((jsonObject) => Details.fromJson(jsonObject)).toList();
      }
      return [];

     }


}

class PriceMaxMin {
  late String max;
  late String min;

  PriceMaxMin({required this.max, required this.min});

  PriceMaxMin.fromJson(Map<String, dynamic> json) {
    max = json['max'] ?? "";
    min = json['min'] ?? "";
  }
}
