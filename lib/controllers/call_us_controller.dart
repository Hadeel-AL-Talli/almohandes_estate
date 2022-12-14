import 'dart:convert';

import 'package:almohandes_estate/controllers/api_helper.dart';
import 'package:almohandes_estate/controllers/api_settings.dart';
import 'package:almohandes_estate/models/call_us.dart';
import 'package:almohandes_estate/screens/callus.dart';
import 'package:http/http.dart' as http;

class CallUsController with ApiHelper{
  Future<List<Object>> callus(
    ) async {
    var url = Uri.parse(ApiSettings.contactus);
    var response = await http.post(
      url,
      
     headers: headers,
    );

    if (response.statusCode == 200) {
       var callJsonArray = jsonDecode(response.body)['data']as List;
        return callJsonArray
        .map((jsonObject) => CallUsModel.fromJson(jsonObject)).toList();
      }
      return [];
  }
}