import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:com.rrk.wallpaper_app_firebase/screens/bottomNavPages/wallpaper_page/add_wallpaper_page.dart';
import 'package:com.rrk.wallpaper_app_firebase/screens/bottomNavPages/wallpaper_page/view_wallpaper_page.dart';
import 'package:com.rrk.wallpaper_app_firebase/utils/routers.dart';
import 'package:flutter/material.dart';

class WallpaperHomePage extends StatefulWidget {
  const WallpaperHomePage({Key? key}) : super(key: key);

  @override
  State<WallpaperHomePage> createState() => _WallpaperHomePageState();
}

class _WallpaperHomePageState extends State<WallpaperHomePage> {
  final CollectionReference wallpaper =
      FirebaseFirestore.instance.collection('addWallpaper');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: wallpaper.get(),
        builder: (context,AsyncSnapshot<QuerySnapshot> snapshot){
          print('Kawchar : ${snapshot.data}');
          if(snapshot.hasData){
            if(snapshot.data!.docs.isEmpty){
              return const Center(child: Text("No Wallpaper"),);
            }else{
              final data=snapshot.data!.docs;
              return Container(
                padding: EdgeInsets.all(10),
                child: GridView.count(
                    crossAxisCount: 2,
                    mainAxisSpacing: 5,
                    crossAxisSpacing: 5,
                   childAspectRatio: 0.6,
                  children: List.generate(data.length, (index){
                    final image=data[index];
                    return GestureDetector(
                      onTap: (){
                       nextPage(context: context,page: ViewWallpaperPage(data: image,),);
                      },
                      child: Container(
                        height: 250,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(
                              image.get('wallpaper_image')
                            ),
                          )
                        ),
                        child: image.get('price')==''?const Text(''): Center(
                          child: CircleAvatar(
                            radius: 18,
                            backgroundColor: Colors.white,
                            child: Text(image.get('price'),
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
                ),
              );
            }
          }else{
            return const Center(child: CircularProgressIndicator(),);
          }
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            nextPage(context: context, page: const AddNewWallpaperPage());
          },
          label: const Text('Upload')),
    );
  }
}
