import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:whatsapp_unilink/whatsapp_unilink.dart';
class CallUs extends StatefulWidget {
  const CallUs({Key? key}) : super(key: key);

  @override
  State<CallUs> createState() => _CallUsState();
}

class _CallUsState extends State<CallUs> {
  launchWhatsApp() async {
  final link = WhatsAppUnilink(
    phoneNumber: '',
    text: "",
  );
  await launch('$link');
  }



  

  @override

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
         leading: 
            IconButton(onPressed: (){
              Navigator.pop(context);
            }, icon: Icon(Icons.arrow_back_ios) , color: Colors.black,),
        
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.white,
          title: Text('تواصل معنا ', style: TextStyle(fontFamily: 'Tj',fontSize: 24.sp, color: Colors.black )),
        ),

        body: ListView(
          physics: BouncingScrollPhysics(),
          children: [
             SizedBox(height: 20.h,),
            Image.asset('images/callus.png', height: 193.h , width: 204.w,),
            SizedBox(height: 40.h,),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(width: 10.w,),
                Container( 
             padding: EdgeInsets.all(10),
             width: 70.w,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(5)
              ),
              child: InkWell(
                onTap: (){
                   launch("tel://+96407832170007");
                },
                child: Column(
                  children: [
                    SvgPicture.asset('images/call.svg'),
                    SizedBox(height: 10.h,),
                    Text('الهاتف', style: TextStyle(fontFamily: 'Tj',fontSize: 12.sp ),),
              
                  ],
                ),
              ),
            ),

            //
            SizedBox(width: 10.w,),
                Container(
             padding: EdgeInsets.all(10),
             width: 70.w,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(5)
              ),
              child: InkWell(
                onTap: ()async{
 print('email');
                         String email = Uri.encodeComponent("almohandesrealestate1@gmail.com");
                        String subject = Uri.encodeComponent("");
                        String body = Uri.encodeComponent("");
                        print(subject); //output: Hello%20Flutter
                        Uri mail = Uri.parse("mailto:$email?subject=$subject&body=$body");
                        if (await launchUrl(mail)) {
                            //email app opened
                        }else{
                            //email app is not opened
                        }
                },
                child: Column(
                  children: [
                    SvgPicture.asset('images/bareed.svg'),
                    SizedBox(height: 10.h,),
                    Text('البريد', style: TextStyle(fontFamily: 'Tj',fontSize: 12.sp ),),
              
                  ],
                ),
              ),
            ),
              SizedBox(width: 10.w,),
                InkWell(
                  onTap: (){
                    launchWhatsApp();
                  },
                  child: Container(
                             padding: EdgeInsets.all(10),
                             width: 70.w,
                              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(5)
                              ),
                              child: Column(
                  children: [
                    SvgPicture.asset('images/whatsapp.svg'),
                    SizedBox(height: 10.h,),
                    Text('واتساب', style: TextStyle(fontFamily: 'Tj',fontSize: 12.sp,),),
                
                  ],
                              ),
                            ),
                ),
              SizedBox(width: 10.w,),
                InkWell(
                    onTap: (){
                      // launch("/-https://fb.watch/fNt3tWfgR");
                      String facebook = "https://www.facebook.com/watch/?extid=NS-UNK-UNK-UNK-IOS_GK0T-GK1C-GK2T&v=506399970669186";
                      canLaunchUrlString(facebook).then((canLaunch) {
              if(canLaunch){
                launchUrlString(facebook);
              }
              else{
                print('error');
              }
                      });
                    },
                  child: Container(
                             padding: EdgeInsets.all(10),
                             width: 70.w,
                              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(5)
                              ),
                              child: Column(
                  children: [
                    SvgPicture.asset('images/face.svg'),
                    SizedBox(height: 10.h,),
                    Text('فيسبوك', style: TextStyle(fontFamily: 'Tj',fontSize: 12.sp ),),
                
                  ],
                              ),
                            ),
                ),
              ],
            )
          ],
        ),
    );
  }
}