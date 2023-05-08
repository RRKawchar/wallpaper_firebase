import 'package:com.rrk.wallpaper_app_firebase/screens/auth/auth_page.dart';
import 'package:com.rrk.wallpaper_app_firebase/screens/main_activity_page.dart';
import 'package:com.rrk.wallpaper_app_firebase/utils/routers.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final FirebaseAuth  auth=FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 2),(){
      if(auth.currentUser==null){
        nextPageOnly(context: context,page: const AuthPage());
      }else{
        nextPageOnly(context: context,page: const MainActivityPage());
      }

    });
    return const Scaffold(
      body: Center(
        child: FlutterLogo(size: 100,),
      ),
    );
  }
}
