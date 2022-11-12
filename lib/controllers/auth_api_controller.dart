import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';

import 'package:http/http.dart' as http;

import '../models/register_user.dart';
import '../prefs/shared_prefrences_controller.dart';
import '../screens/Home/model/UserData.dart';
import 'api_helper.dart';
import 'api_settings.dart';


class AuthApiController with ApiHelper {
  Future<bool> register(BuildContext context,
      {required RegisterUser user}) async {
    var url = Uri.parse(ApiSettings.register);
    var response = await http.post(url,
        body: {
          'name': user.name,
          'email': user.email,
          'password': user.password,
          'c_password': user.c_password
        },
        headers: headers);

    print(user.c_password);
    if (response.statusCode == 200) {
      showSnackBar(context,
          message: jsonDecode(response.body)['message'].toString());
      return true;
    } else {
      var message = jsonDecode(response.body)['data'].toString();
      showSnackBar(context, message: message, error: true);
      print(message);
    }
    return false;
  }

  /**Login */

  Future<bool> login(BuildContext context,
      {required String email, required String password}) async {
    var url = Uri.parse(ApiSettings.login);
    var response = await http.post(url, body: {
      'email': email,
      'password': password,
    });
    if (response.statusCode == 200) {
      //TODO: SHARED PREFERENCES - SAVE LOGGED IN USER DATA!!
      print(jsonDecode(response.body)['data']["token"]);
   await   SharedPrefController().save(
          name: jsonDecode(response.body)['data']["name"],
          token: jsonDecode(response.body)['data']["token"] , );
          
  await getUserData();
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
      return false;
    }
    else{
      return false;
    }

  }
  Future<UserData?> getUserData() async {
    var url = Uri.parse(ApiSettings.user);
    var response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      UserData userData=UserData.fromJson(jsonDecode(response.body)['data']);
      await SharedPrefController().saveUserData(userData: userData);
      return userData;
    }
    return null;
  }

// forget password 

 Future<bool> forgetPassword(BuildContext context,
      {required String email}) async {
    var url = Uri.parse(ApiSettings.forget_pass);
    var response = await http.post(url, body: {
      'email': email,
    });

    if (response.statusCode == 200) {
      print(jsonDecode(response.body)['message']);
      showSnackBar(

        context,
        message: jsonDecode(response.body)['message'],
        error: false,
      );
      return true;
    } else if (response.statusCode == 400) {
      showSnackBar(

        context,
        message: jsonDecode(response.body)['message'],
        error: true,
      );
    } else {
      showSnackBar(
        context,
        message: 'Something went wrong, please try again!',
        error: true,
      );
    }
    return false;
  }

// password reset check token 

 Future<bool> resetPassword(
      BuildContext context, {
        required String email,
        required String code,
        
      }) async {
    var url = Uri.parse(ApiSettings.resetPass);
    var response = await http.post(
      url,
      body: {
        'email':email,
        'token': code,
        
      },
     headers: {HttpHeaders.acceptHeader: 'application/json'},
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
    } else if (response.statusCode == 500) {
      showSnackBar(
        context,
        message: 'Something went wrong, try again',
        error: true,
      );
    }
    return false;
  }

  // change password 


   Future<bool> changePassword(
      BuildContext context, {
        required String email,
        required String code,
        required String password,
        required String c_password
        
      }) async {
    var url = Uri.parse(ApiSettings.changepass);
    var response = await http.post(
      url,
      body: {
        'email':email,
        'token': code,
        'password':password,
        'c_password':c_password
        
      },
      headers: {HttpHeaders.acceptHeader: 'application/json'},
    );

    if (response.statusCode == 200) {
      showSnackBar(
        context,
        message: 'تم تغيير كلمة السر بنجاح '
        //message: jsonDecode(response.body)['message'],
      );
      return true;
    } else if (response.statusCode == 400) {
      showSnackBar(
        context,
        message: jsonDecode(response.body)['message'],
        error: true,
      );
    } else if (response.statusCode == 500) {
      showSnackBar(
        context,
        message: 'Something went wrong, try again',
        error: true,
      );
    }
    return false;
  }



  Future<bool> logout() async {
    var url = Uri.parse(ApiSettings.logout);
    var response = await http.get(url, headers: {
      HttpHeaders.authorizationHeader: SharedPrefController().token,
      HttpHeaders.acceptHeader: 'application/json'
    });
    print(response.statusCode);
    if (response.statusCode == 200 || response.statusCode ==401) {
      SharedPrefController().clear();
      return true;
    }
    return false;
  }

}
