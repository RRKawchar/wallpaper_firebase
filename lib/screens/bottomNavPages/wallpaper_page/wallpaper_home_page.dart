import 'package:com.rrk.wallpaper_app_firebase/screens/bottomNavPages/wallpaper_page/add_wallpaper_page.dart';
import 'package:com.rrk.wallpaper_app_firebase/utils/routers.dart';
import 'package:flutter/material.dart';

class WallpaperHomePage extends StatefulWidget {
  const WallpaperHomePage({Key? key}) : super(key: key);

  @override
  State<WallpaperHomePage> createState() => _WallpaperHomePageState();
}

class _WallpaperHomePageState extends State<WallpaperHomePage> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: const Center(
        child: Text("All Wallpaper page"),
      ),
      floatingActionButton: FloatingActionButton.extended(onPressed: (){
        nextPage(context: context,page: const AddNewWallpaperPage());
      }, label:const Text('Upload')),
    );

  }

}
