
import 'package:shared_preferences/shared_preferences.dart';

import '../controllers/home_api_controller.dart';
import '../screens/Home/model/UserData.dart';

enum PrefKeys { loggedIn, name,  email, token ,max,min,phone , password}


class SharedPrefController {
   static final SharedPrefController _instance = SharedPrefController._();

  SharedPrefController._();

  late SharedPreferences _sharedPreferences;

  factory SharedPrefController() {
    return _instance;
  }

  Future<void> initPref() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  //required String token 
Future<void> save ({required String name,required String token }) async {
print('dddddddddd');
await _sharedPreferences.setBool(PrefKeys.loggedIn.toString(), true);
await _sharedPreferences.setString(PrefKeys.name.toString(), name);
await _sharedPreferences.setString(PrefKeys.token.toString(), 'Bearer '+ token);

}
   Future<void> saveUserData ({required UserData userData }) async {
     print('dddddddddd');
     
     await _sharedPreferences.setString(PrefKeys.name.toString(), userData.name.toString());
     await _sharedPreferences.setString(PrefKeys.phone.toString(), userData.phone.toString());
     await _sharedPreferences.setString(PrefKeys.email.toString(),  userData.email.toString());

   }
  //  Future<void> saveMaxMin ({required PriceMaxMin priceMaxMin }) async {
  //    print('dddddddddd');
  //    await _sharedPreferences.setString(PrefKeys.min.toString(), priceMaxMin.min);
  //    await _sharedPreferences.setString(PrefKeys.max.toString(), priceMaxMin.max);

  //  }
   Future<void> updateProfile ({required String name,required String email,required String password, required String phone   }) async {
    await _sharedPreferences.setString(PrefKeys.name.toString(),name);
    await _sharedPreferences.setString(PrefKeys.email.toString(),email);
    await _sharedPreferences.setString(PrefKeys.password.toString(),password);
    await _sharedPreferences.setString(PrefKeys.phone.toString(), phone);
  }
   
   String get max =>
       _sharedPreferences.getString(PrefKeys.max.toString()) ?? '';
   String get min =>
       _sharedPreferences.getString(PrefKeys.min.toString()) ?? '';
 bool get loggedIn =>
      _sharedPreferences.getBool(PrefKeys.loggedIn.toString()) ?? false;

  String get token =>
      _sharedPreferences.getString(PrefKeys.token.toString()) ?? '';

  String get name =>
      _sharedPreferences.getString(PrefKeys.name.toString())??'';

   String get phone =>
       _sharedPreferences.getString(PrefKeys.phone.toString()) ?? '';

   String get email =>
       _sharedPreferences.getString(PrefKeys.email.toString())??'';
  String get gender =>
      _sharedPreferences.getString(PrefKeys.email.toString())??'';




  Future<bool> clear() async {
    return await _sharedPreferences.clear();
  }

}