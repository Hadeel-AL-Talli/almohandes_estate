import 'dart:convert';
import 'dart:io';


import 'package:almohandes_estate/controllers/api_settings.dart';
import 'package:almohandes_estate/firebase/fb_notifications.dart';
import 'package:almohandes_estate/prefs/shared_prefrences_controller.dart';
import 'package:almohandes_estate/screens/Home/model/UserData.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

import '../../controllers/api_helper.dart';
import '../../controllers/auth_api_controller.dart';
import '../../widgets/app_text_feild.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/social_button.dart';
import 'package:http/http.dart' as http;

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> with ApiHelper, FbNotifications {
  String? _token;
  late TextEditingController _emailTextController;
  late TextEditingController _passwordTextController;
  final FacebookLogin _fb = FacebookLogin();
  bool loding = false;
// GoogleSignIn _googleSignIn = GoogleSignIn(
//
//   // The OAuth client id of your app. This is required.
//  // clientId:'1052048950734-fn8787cumgcqlbl6b12gfi33k3skvo2v.apps.googleusercontent.com',
//   // If you need to authenticate to a backend server, specify its OAuth client. This is optional.
//   serverClientId: '',
// );
  GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
      // 'https://www.googleapis.com/auth/contacts.readonly'
    ],
  );




  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _emailTextController = TextEditingController();
    _passwordTextController = TextEditingController();
    FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
    //  _firebaseMessaging.getToken().then((token){

    // });

    requestNotificationPermissions();
  }

  Future<UserData?> getUserData() async {
    var url = Uri.parse(ApiSettings.user);
    var response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      UserData userData = UserData.fromJson(jsonDecode(response.body)['data']);
      await SharedPrefController().saveUserData(userData: userData);
      return userData;
    }
    return null;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailTextController.dispose();

    _passwordTextController.dispose();
  }

  void _facebookLogin() async {
    final result = await _fb.logIn();
    switch (result.status) {
      case FacebookLoginStatus.success:
        sendToken(result.accessToken!.token);
        break;

      case FacebookLoginStatus.cancel:
        break;

      case FacebookLoginStatus.error:
        break;
    }
  }

  void sendToken(String facebookToken) async {
    var url = Uri.parse(ApiSettings.facebooklogin);
    var response = await http.post(url,
        body: json.encode({"token": facebookToken}),
        headers: {"Content-Type": "application/json"});

    if (response.statusCode == 200) {
      await SharedPrefController().save(
        name: jsonDecode(response.body)['data']["name"],
        token: jsonDecode(response.body)['data']["token"],
      );
      await Navigator.pushReplacementNamed(
          context, '/main_screen');
    }
  }

  Future<void> _handleSignIn() async {
    try {
      var x = await _googleSignIn
          .signIn()
          .then((value) => value!.authentication
              .then((googleKey) => sendGoogleToken(googleKey.accessToken!)))
          .catchError((err) => print(err))
          .catchError((error) => print(error));
    } catch (error) {
      print(error);
    }
  }

  void sendGoogleToken(String googleToken) async {
    var url = Uri.parse(ApiSettings.googlelogin);
    var response = await http.post(url,
        body: json.encode({"token": googleToken}),
        headers: {"Content-Type": "application/json"});
    var body = json.decode(response.body);
    if(response.statusCode == 200 && body["success"] == true){
      await SharedPrefController().save(
        name: jsonDecode(response.body)['data']["name"],
        token: jsonDecode(response.body)['data']["token"],
      );
      await Navigator.pushReplacementNamed(
          context, '/main_screen');
    }

  }
  //apple login api
  void sendAppleToken(String appleToken) async {
    print('token apple : $appleToken') ;
    var url = Uri.parse(ApiSettings.applelogin);
    var response = await http.post(url,
        body: json.encode({"token": appleToken}),
        headers: {"Content-Type": "application/json"});
    var body = json.decode(response.body);
    if(response.statusCode == 200 && body["success"] == true){
      await SharedPrefController().save(
        name: jsonDecode(response.body)['data']["name"],
        token: jsonDecode(response.body)['data']["token"],
      );
      await Navigator.pushReplacementNamed(
          context, '/main_screen');
    }

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          SizedBox(
            height: 10.h,
          ),
          SizedBox(
            height: 40.h,
          ),
          Center(
              child: Text(
            ' تسجيل دخول ',
            style: TextStyle(
                fontFamily: 'Tj',
                fontSize: 16.sp,
                color: Colors.black,
                fontWeight: FontWeight.bold),
          )),
          SizedBox(
            height: 25.h,
          ),
          Center(
              child: Text(
            ' سجل دخول على التطبيق باستخدام فيسبوك أو غوغل أو أبل ',
            style: TextStyle(
                fontFamily: 'Tj', fontSize: 12.sp, color: Color(0xff797979)),
          )),
          SizedBox(
            height: 25.h,
          ),
           
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: SignInWithAppleButton(
              borderRadius:   const BorderRadius.all(Radius.circular(8.0)),
            
              style: SignInWithAppleButtonStyle.whiteOutlined,
                onPressed: () async {
                print('call ____') ;
              
                  final credential = await SignInWithApple.getAppleIDCredential(
                    scopes: [
                      //AppleIDAuthorizationScopes.email,
                      AppleIDAuthorizationScopes.fullName,
                    ],
                     webAuthenticationOptions: WebAuthenticationOptions(
                    //   // TODO: Set the `clientId` and `redirectUri` arguments to the values you entered in the Apple Developer portal during the setup
                       clientId:
                           'almohandesEstate.com.example',

                  redirectUri:
                        // For web your redirect URI needs to be the host of the "current page",
                        // while for Android you will be using the API server that redirects back into your app via a deep link
                      
                            Uri.parse(
                                'https://example.com/callbacks/sign_in_with_apple',
                              ),
                     ),
                 
                  );

                  // ignore: avoid_print
                  //print(credential);
                  sendAppleToken(credential.identityToken!);

                  // This is the endpoint that will convert an authorization code obtained
                  // via Sign in with Apple into a session in your system
                /*
                  final signInWithAppleEndpoint = Uri(
                    scheme: 'https',
                    host: 'flutter-sign-in-with-apple-example.glitch.me',
                    path: '/sign_in_with_apple',
                    queryParameters: <String, String>{
                      'code': credential.authorizationCode,
                      if (credential.givenName != null)
                        'firstName': credential.givenName!,
                      if (credential.familyName != null)
                        'lastName': credential.familyName!,
                       'useBundleId':
                           !kIsWeb && (Platform.isIOS || Platform.isMacOS)
                               ? 'true'
                               : 'false',
                      if (credential.state != null) 'state': credential.state!,
                    },
                  );

                  final session = await http.Client().post(
                    signInWithAppleEndpoint,
                  );

                  // If we got this far, a session based on the Apple ID credential has been created in your system,
                  // and you can now set this as the app's session
                  // ignore: avoid_print
                  print(session);

                 */
                },
              ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                  onTap: () async {
                    await _handleSignIn();
                  },
                  child: SocialButton(
                    imagepath: 'images/google.svg',
                    text: 'باستخدام غوغل ',
                  )),
              SizedBox(
                width: 10.w,
              ),
              InkWell(
                  onTap: () async {
                    _facebookLogin();
                  },
                  child: SocialButton(
                    imagepath: 'images/facebook.svg',
                    text: 'باستخدام فيسبوك ',
                  )),
                   
            ],
          ),
          SizedBox(
            height: 20.h,
          ),
          
          Row(
            children: [
              Expanded(
                  child: Divider(
                thickness: 1,
                endIndent: 5,
                indent: 15,
              )),
              Text(
                'أو',
                style: TextStyle(
                    fontFamily: 'Tj',
                    color: Color(0xff797979),
                    fontSize: 12.sp),
              ),
              Expanded(
                  child: Divider(
                thickness: 1,
                indent: 5,
                endIndent: 15,
              ))
            ],
          ),
          SizedBox(
            height: 15.h,
          ),
          Padding(
            padding: const EdgeInsets.only(right: 15.0),
            child: Text(
              'البريد الالكتروني ',
              textDirection: TextDirection.rtl,
              style: TextStyle(
                  fontFamily: 'Tj',
                  fontSize: 16.sp,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: AppTextField(
                hint: 'example@gmail.com',
                controller: _emailTextController,
                suffix: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SvgPicture.asset(
                    'images/email.svg',
                  ),
                )),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 15.0),
            child: Text(
              'كلمة السر ',
              textDirection: TextDirection.rtl,
              style: TextStyle(
                  fontFamily: 'Tj',
                  fontSize: 16.sp,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: AppTextField(
                hint: 'ادخل على الأقل 8 حروف أو أكثر ',
                controller: _passwordTextController,
                suffix: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SvgPicture.asset(
                    'images/eye.svg',
                  ),
                )),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 15.0),
            child: InkWell(
                onTap: () {
                  Navigator.pushNamed(context, '/forget_password');
                },
                child: Text(
                  'هل نسيت كلمة السر؟  ',
                  textDirection: TextDirection.rtl,
                  style: TextStyle(
                      fontFamily: 'Tj',
                      fontSize: 12.sp,
                      color: Color(0xff3D6CF0),
                      fontWeight: FontWeight.bold),
                )),
          ),
         loding? Center(child: CircularProgressIndicator()):  Padding(
            padding: const EdgeInsets.all(20.0),
            child: CustomButton(
                onPress: () async {
                  setState(() {
                        loding=true;
                      });
                  await performLogin();
                   setState(() {
                        loding=false;
                      });
                },
                text: 'تسجيل دخول ',
                color: Color(0xff3D6CF0)),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, '/register');
                  },
                  child: Text(
                    ' إنشاء حساب',
                    style: TextStyle(
                        fontFamily: 'Tj',
                        fontSize: 12.sp,
                        color: Color(0xff3D6CF0)),
                  )),
              SizedBox(
                width: 5,
              ),
              Text(
                'ليس لديك حساب ؟ ',
                style: TextStyle(
                    fontFamily: 'Tj',
                    fontSize: 12.sp,
                    color: Color(0xff797979)),
              ),
            ],
          )
        ],
      ),
    );
  }

  Future<void> performLogin() async {
    if (checkData()) {
      await login();
    }
  }

  bool checkData() {
    if (_emailTextController.text.isNotEmpty &&
        _emailTextController.text.contains('@') &&
        _passwordTextController.text.isNotEmpty &&
        _passwordTextController.text.length >= 8) {
      return true;
    }
    showSnackBar(
      context,
      message: 'من فضلك, أدخل البيانات المطلوبة بشكل صحيح ',
      error: true,
    );
    return false;
  }

  Future<void> login() async {
    bool status = await AuthApiController().login(
      context,
      email: _emailTextController.text,
      password: _passwordTextController.text,
    );

    if (status) Navigator.pushReplacementNamed(context, '/main_screen');
  }
}
