import 'package:com.rrk.wallpaper_app_firebase/Widgets/custom_button.dart';
import 'package:com.rrk.wallpaper_app_firebase/provider/auth_provider.dart';
import 'package:com.rrk.wallpaper_app_firebase/screens/main_activity_page.dart';
import 'package:com.rrk.wallpaper_app_firebase/utils/routers.dart';
import 'package:com.rrk.wallpaper_app_firebase/utils/show_alert.dart';
import 'package:flutter/material.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Center(
          child: CustomButton(
            text: 'Continue with google',
            icon: const Icon(
              Icons.mail_outline,
              color: Colors.red,
            ),
            onTap: (){
             AuthProvider().signInWithGoogle().then((value){
               nextPageOnly(context: context,page: const MainActivityPage());
             }).catchError((e){
               showAlert(context, e.toString());
             });
            },
            bgColor: Colors.blue,
            textColor: Colors.white
          ),
        ),
      ),
    );
  }
}
