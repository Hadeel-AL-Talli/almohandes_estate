import 'dart:convert';

import 'package:flutter/cupertino.dart';

import 'package:http/http.dart' as http;

import '../models/register_user.dart';
import 'api_helper.dart';
import 'api_settings.dart';

class UpdateProfileController with ApiHelper{
  Future<bool> updateProfile (BuildContext context,{ required RegisterUser user})async{
     var url = Uri.parse(ApiSettings.updateProfile);
     var response = await http.post(url,
      body: {
     'name':user.name,
     'email':user.email,
     'password':user.password,
     'phone':user.phone
     }, headers: headers
     );
     
    if (response.statusCode == 200) {
      showSnackBar(
        context,
        message: jsonDecode(response.body)['message'],
      );

      return true;
    } else if (response.statusCode == 400) {
      showSnackBar(
        context,
        message: jsonDecode(response.body)['message'],
        error: true,
      );
    }
    return false;
  }
}