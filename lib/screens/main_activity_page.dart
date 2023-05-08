import 'package:com.rrk.wallpaper_app_firebase/provider/auth_provider.dart';
import 'package:com.rrk.wallpaper_app_firebase/screens/auth/auth_page.dart';
import 'package:com.rrk.wallpaper_app_firebase/screens/bottomNavPages/download_page.dart';
import 'package:com.rrk.wallpaper_app_firebase/screens/bottomNavPages/wallpaper_page/wallpaper_home_page.dart';
import 'package:com.rrk.wallpaper_app_firebase/utils/routers.dart';
import 'package:flutter/material.dart';

class MainActivityPage extends StatefulWidget {
  const MainActivityPage({Key? key}) : super(key: key);

  @override
  State<MainActivityPage> createState() => _MainActivityPageState();
}

class _MainActivityPageState extends State<MainActivityPage> {
  int pageIndex=0;
  List<Map> bottomNavItems=[
    {
      "icon":Icons.home,
       "title":"Home"
    },
    {
      "icon":Icons.download,
      "title":'Download'
    }
  ];
  List<Widget> bottomNavPages=[
    const WallpaperHomePage(),
    const DownloadPage()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Wallpaper app"),
        actions: [
          IconButton(
            onPressed: () {
              AuthProvider().signOut().then((value){
                nextPageOnly(context: context,page: const AuthPage());
              });
            },
            icon: const Icon(Icons.exit_to_app),
          )
        ],
      ),
      body: bottomNavPages[pageIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: (value){
          setState(() {
            pageIndex=value;
          });
        },
        currentIndex: pageIndex,
        items: List.generate(bottomNavItems.length, (index){
          final data=bottomNavItems[index];
          return BottomNavigationBarItem(icon: Icon(data['icon']),label: data['title']);
        }),
      ),
    );
  }
}
