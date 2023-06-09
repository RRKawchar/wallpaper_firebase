import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:com.rrk.wallpaper_app_firebase/screens/bottomNavPages/wallpaper_page/view_wallpaper_page.dart';
import 'package:com.rrk.wallpaper_app_firebase/utils/routers.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class DownloadPage extends StatefulWidget {
  const DownloadPage({Key? key}) : super(key: key);

  @override
  State<DownloadPage> createState() => _DownloadPageState();
}

class _DownloadPageState extends State<DownloadPage> {
  final CollectionReference wallpaper =
  FirebaseFirestore.instance.collection('PurchasedWallpaper');

  final uid = FirebaseAuth.instance.currentUser!.uid;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: wallpaper.doc(uid).collection('Wallpaper').get(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data!.docs.isEmpty) {
              return const Center(child: Text("No Saved WallPaper"));
            } else {
              final data = snapshot.data!.docs;

              return Container(
                  padding: const EdgeInsets.all(10),
                  child: GridView.count(
                    crossAxisCount: 2,
                    mainAxisSpacing: 5,
                    crossAxisSpacing: 5,
                    childAspectRatio: 0.6,
                    children: List.generate(data.length, (index) {
                      final image = data[index];

                      return GestureDetector(
                        onTap: () {
                          nextPage(
                              context: context,
                              page: ViewWallpaperPage(data: image, path: 'saved',));
                        },
                        child: Container(
                            height: 250,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(
                                        image.get('wallpaper_image')))),
                            child: Center(
                              child: image.get('price') == ''
                                  ? const Text('')
                                  : CircleAvatar(
                                backgroundColor: Colors.white,
                                child: Text(image.get('price')),
                              ),
                            )),
                      );
                    }),
                  ));
            }

            ///
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}