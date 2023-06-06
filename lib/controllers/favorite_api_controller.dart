import 'package:almohandes_estate/controllers/api_helper.dart';
import 'package:almohandes_estate/controllers/api_settings.dart';
import 'package:almohandes_estate/models/favorite.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';

import '../models/IsFav.dart';

class FavoriteApiController with ApiHelper {
  Future<List<FavoriteModel>> getFavouriteLists() async {
    var url = Uri.parse(ApiSettings.getfav);
    var response = await http.get(url,
        headers: headers);
    print("ahmed FavouriteAPIControler" + response.statusCode.toString());
    print("ahmed FavouriteAPIControler" + jsonDecode(response.body).toString());
    if (response.statusCode == 200) {
      var categoriesJsonArray = jsonDecode(response.body)['data'] as List;
      return categoriesJsonArray
          .map((jsonObject) => FavoriteModel.fromJson(jsonObject))
          .toList();
    }
    return [];
  }
  Future<bool> unFavourite(
      BuildContext context, {
        required String id,
      }) async {
    var url = Uri.parse(ApiSettings.removefromfav);
    var response = await http.post(url,
        headers: headers,
    body: {
      "property_id":id
    }
    );
    print(jsonDecode(response.body)['status'].toString()+"ahmed");
    if (response.statusCode == 200) {
      {
        showSnackBar(
          context,
          message: jsonDecode(response.body)['message'].toString(),
        );
        print(jsonDecode(response.body)['status']);
        return true;
      }
    }  else {
      showSnackBar(
        context,
        message: jsonDecode(response.body)['message'].toString(),
        error: true,
      );
      return false;
    }
  }
  Future<bool> addToFavourite(
      BuildContext context, {
        required String id,
      }) async {
    var url = Uri.parse(ApiSettings.addtofav);
    var response = await http.post(url,
        headers: headers,
        body: {
          "property_id":id
        }
    );
    print(jsonDecode(response.body)['status'].toString()+"ahmed");
    if (response.statusCode == 200) {
      {
        showSnackBar(
          context,
          message: jsonDecode(response.body)['message'].toString(),
        );
        print(jsonDecode(response.body)['status']);
        return true;
      }
    }  else {
      showSnackBar(
        context,
        message: jsonDecode(response.body)['message'].toString(),
        error: true,
      );
      return false;
    }
  }


  //isFav
  // Future<bool> isFavourite(
  //     BuildContext context, {
  //       required String id,
  //     }) async {
  //   var url = Uri.parse(ApiSettings.isFav);
  //   var response = await http.post(url,
  //       headers: headers,
  //       body: {
  //         "property_id":id
  //       }
  //   );
  //   print(jsonDecode(response.body)['favorite'].toString());
  //   if (response.statusCode == 200) {
  //     {
  //       showSnackBar(
  //         context,
  //         message: jsonDecode(response.body)['message'].toString(),
  //       );
  //       print(jsonDecode(response.body)['favorite']);
  //       return true;
  //     }
  //   }  else {
  //     showSnackBar(
  //       context,
  //       message: jsonDecode(response.body)['message'].toString(),
  //       error: true,
  //     );
  //     return false;
  //   }
  // }

  



    

 Future<bool> isFav (BuildContext context,  String id )async{
       var url = Uri.parse(ApiSettings.isFav);
       var response = await http.post(url, headers: headers,  body: {
         "property_id":id
       });
if(response.statusCode == 200){
  // showSnackBar(
  //       context,
  //       message: jsonDecode(response.body)['message'],
  //     );
      print(jsonDecode(response.body)['message']);
  return true;
}
else if (response.statusCode == 400) {
      var message = jsonDecode(response.body)['message'];
    //  showSnackBar(context, message: message, error: true);
    } else {
      // showSnackBar(context,
      //     message: 'Something went wrong, please try again!', error: true);
    }
return false;

     }

   
}
