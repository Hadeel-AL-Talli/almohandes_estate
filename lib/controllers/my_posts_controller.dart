import 'dart:convert';

import 'package:flutter/widgets.dart';

import 'package:http/http.dart' as http;

import '../models/my_post.dart';
import 'api_helper.dart';
import 'api_settings.dart';

class MyPostController with ApiHelper{
 

  Future<List<MyPostsModel>> getMyPosts()async{
      var url = Uri.parse(ApiSettings.myposts);
      print(url);
      var response = await http.get(url, headers: headers);
      if (response.statusCode ==200){
        var myPostsJsonArray = jsonDecode(response.body)['data']as List;
        return  myPostsJsonArray
        .map((jsonObject) => MyPostsModel.fromJson(jsonObject)).toList();
      }
      return [];

     }



     Future<bool> deletePost (BuildContext context , {required String id })async{
       var url = Uri.parse(ApiSettings.deletepost.replaceFirst("{id}", id));
       var response  = await http.delete(url ,headers: headers);
if(response.statusCode == 200){
  showSnackBar(
        context,
        message: jsonDecode(response.body)['message'],
      );
      print(jsonDecode(response.body)['message']);
  return true;
}
else if (response.statusCode == 400) {
      var message = jsonDecode(response.body)['message'];
      showSnackBar(context, message: message, error: true);
    } else {
      showSnackBar(context,
          message: 'Something went wrong, please try again!', error: true);
    }
return false;

     }

}