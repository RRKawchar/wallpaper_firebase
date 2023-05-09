import 'package:com.rrk.wallpaper_app_firebase/provider/apply_wallpaper_provider.dart';
import 'package:com.rrk.wallpaper_app_firebase/provider/upload_wallpaper_provider.dart';
import 'package:com.rrk.wallpaper_app_firebase/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_)=>UploadWallpaperProvider()),
        ChangeNotifierProvider(create: (_)=>ApplyWallpaperProvider())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const SplashScreen(),
      ),
    );
  }
}


