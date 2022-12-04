import 'dart:convert';
import 'dart:io';

import 'package:almohandes_estate/controllers/api_helper.dart';
import 'package:almohandes_estate/controllers/api_settings.dart';
import 'package:almohandes_estate/models/user_notifications.dart';
import 'package:http/http.dart'as http;
class UserNotificationsController with ApiHelper{
  Future<List<UserNotifications>> userNotifications(
    ) async {
    var url = Uri.parse(ApiSettings.userNotifications);
    var response = await http.post(
      url,
      
     headers: headers,
    );

    if (response.statusCode == 200) {
       var userNotificationsJsonArray = jsonDecode(response.body)['data']as List;
        return  userNotificationsJsonArray
        .map((jsonObject) => UserNotifications.fromJson(jsonObject)).toList();
      }
      return [];
  }
}