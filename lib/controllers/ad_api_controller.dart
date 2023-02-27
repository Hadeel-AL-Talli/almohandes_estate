import 'dart:convert';

import 'package:almohandes_estate/controllers/api_helper.dart';
import 'package:almohandes_estate/controllers/api_settings.dart';
import 'package:almohandes_estate/models/ad_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class ADController with ApiHelper{
   Future<List<AdModel>> getadUrl() async {
    var url = Uri.parse(ApiSettings.ad);
    print(url);
    var response = await http.get(url, headers: headers);
    print(response.statusCode);
    print(response.body);
    if (response.statusCode == 200) {
      var productsJsonObject = jsonDecode(response.body)['data'] as List ;
      return productsJsonObject.map((e) => AdModel.fromJson(e)).toList();
    }
   return [];
    
  }
}