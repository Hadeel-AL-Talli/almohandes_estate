import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../models/favorite.dart';
import 'api_helper.dart';
import 'api_settings.dart';
class FavoriteApiController with ApiHelper{


    Future<List<FavoriteModel>> getFav()async{
      var url = Uri.parse(ApiSettings.getfav);
      var response = await http.get(url, headers: headers);
       if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['data'] as List;
      List<FavoriteModel> favorite =
          data.map((e) => FavoriteModel.fromJson(e)).toList();
      return favorite;
    }
    return [];

    }
      
     Future<bool> addFavorite(BuildContext context,
      {required int id}) async {
    var url = Uri.parse(ApiSettings.addtofav);
    

    var request = http.MultipartRequest('POST', url);
    request.fields.addAll({'property_id': '$id' /*,"rate":"1"*/});

    request.headers.addAll(headers);

    http.StreamedResponse responseStreamed = await request.send();

    var response = await http.Response.fromStream(responseStreamed);
    if (kDebugMode) {
      print(response.body);
    }
    if (response.statusCode == 200) {
    
      return true;
    } else {
     
      showSnackBar(context, error: true, message: 'تمت الاضافة الى المفضلة ');
    }
    return false;
  }


  Future<bool> removeFavorite(BuildContext context,
      {required int id}) async {
    var url = Uri.parse(ApiSettings.removefromfav);
    

    var request = http.MultipartRequest('POST', url);
    request.fields.remove({'property_id': '$id' /*,"rate":"1"*/});

    request.headers.addAll(headers);

    http.StreamedResponse responseStreamed = await request.send();

    var response = await http.Response.fromStream(responseStreamed);
    if (kDebugMode) {
      print(response.body);
    }
    if (response.statusCode == 200) {
    
      return true;
    } else {
     
      showSnackBar(context, error: true, message: 'تمت عملية الحذف بنجاح');
    }
    return false;
  }

}