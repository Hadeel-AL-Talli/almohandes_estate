import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/option.dart';
import '../prefs/shared_prefrences_controller.dart';
import 'api_helper.dart';
import 'api_settings.dart';
typedef UploadImageCallback = void Function({
required String status,
required String message,
});
class AddBuildingController  with ApiHelper{

   Future<Data?> showOptions() async {
    var url = Uri.parse(ApiSettings.option);
    var response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      return Data.fromJson(jsonDecode(response.body)['data']);
    }
    return null;
  }

   Future<void> propertyAdd(
       {
         required String title,
         required String location,
         required String total_price,
         required String meter_price,
         required String floors,
         required String property_floor,
         required String size,
         required String number,
         required String rooms,
         required String nzal,
         required String front,
         required String street,
         required String description,
         required String lease_type,
         required String category,
         required String type,
         required String taboo,
         required String city,
         required String features,
         required String name,
         required String phone,
         required List<XFile?> images,
          UploadImageCallback?  uploadImageCallback
       }) async {
     var request = http.MultipartRequest("POST", Uri.parse(ApiSettings.propertyAdd));
     request.fields['title'] = title;
     request.fields['location'] = location;
     request.fields['total_price'] = total_price;
     request.fields['meter_price'] = meter_price;
     request.fields['floors'] = floors;
     request.fields['property_floor'] = property_floor;
     ///
     request.fields['size'] = size;
     request.fields['number'] = number;
     request.fields['rooms'] = rooms;
     request.fields['nzal'] = nzal;
     request.fields['front'] = front;
     request.fields['street'] = street;
     request.fields['user_name'] = name;
     request.fields['user_email'] = phone;
     request.fields['description'] = description;
     request.fields['lease_type'] = lease_type;
     request.fields['category'] = category;
     request.fields['type'] = type;
     request.fields['taboo'] = taboo;
     request.fields['city'] = city;
     request.fields['features'] = features;
     request.headers['Authorization']=SharedPrefController().token;
     request.headers['Accept']="application/json";

     // request.headers['Authorization']="Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxNSIsImp0aSI6IjlkZGIwNjk5NTBlODcxZmY5OWFlOGFmOGQ4OTNkN2EyZGZmYWJjODE3Yzc0ZTI5ZGRiMzA4ZTBjNmZmZjc3MmI4NDA2Y2Y0NmQxNmVkZjhlIiwiaWF0IjoxNjU4NDIzNzY2LjE5ODYxMSwibmJmIjoxNjU4NDIzNzY2LjE5ODYxNywiZXhwIjoxNjg5OTU5NzY2LjE5NDc4Nywic3ViIjoiMiIsInNjb3BlcyI6W119.rP1wl9JXao_nLFVqDjxa9A8f-Wjpn-PZOI4IVqNkNb7gXFeYDQgS7oVCm0DIGUHz4QhRjiLPBqm6xB4s6BojCdfN50QhEHmYe6tLNoBJMJmTICh8ce_fb9Zu4zQMVP63Yekcto-LywoQYzpC-vwJqHM4B4CQiLbLvlID-peRb_rhJeQIuzluD6nr0lgGg1UOlTOKoRS3vyYKoemqBW7VJ16E5ZhmNeDguhTtzbdSQiw63Cw6ZZ84u8zjjkRjrThYt9hLTYIK6KJV28gOyndD2kx2sshrfoNPUG43GNlKkUDUjhh3nWioHI_pgtVTKweLtbV1BbhmQ15POe6NWc5j3MG63lySYy5lmd20HzhghVby3cWUgP5XtL5sNHmuZ_5jBK2mwyINdQmJ34zZ-dm7nqm6UKxbhxLIgwPZy27c3Lk74seD6i5qSsRbsXc-oWKUH1rQVKCEz8vjapZjXeGEBp1n6mSzDTL60rNbNbPw2wSDjg82q74YvgwUSjyQolTxc3pR9EOJhLOo-TekUN1hESwhvK9m2C3rAcdGrjU5QqzqpOVmUuGCMUDvUKvwkFGJaF7E8jcpnccxCUz0QjnBOvqKReFMi-rEfgC00KYulokChOAh6XU1W_Njf3bgySlRqT2cC-KC7fP6N9GeE2b5KZCfXJTQJaQss3Br-tWYpO0";
     if(images.isNotEmpty){
       for(int i=0;i<images.length;i++){
         request.files.add( await http.MultipartFile.fromPath('images[]', images[i]!.path));
       }
     }
     var response = await request.send();
     print('StatusCOde: ${response.statusCode}');
     response.stream.transform(utf8.decoder).listen((value) {
       print('StatusCOde: ${response.statusCode}');
       if (response.statusCode == 200) {
         var jsonResponse = jsonDecode(value);

         uploadImageCallback!(
             status: "200",
             message: jsonResponse['message'],
          );

         // showSnackBar(context: context, message: jsonResponse['message']);

       } else if (response.statusCode == 400) {
         uploadImageCallback!(
           status: "400",
           message: jsonDecode(value)['message'],
         );

         // showSnackBar(context: context, message: jsonDecode(value)['message'],error: true);

       } else if (response.statusCode == 500) {
         uploadImageCallback!(
           status: "500",
           message: 'Something went wrong, try again!',
         );

         // showSnackBar(context: context, message: 'Something went wrong, try again!',error: true);
       }
       else{
         uploadImageCallback!(
           status: "400",
           message: 'Something went wrong, try again!',
         );
       }
     });
   }
  

}