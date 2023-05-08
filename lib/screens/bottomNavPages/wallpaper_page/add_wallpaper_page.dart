import 'dart:io';

import 'package:com.rrk.wallpaper_app_firebase/Widgets/custom_button.dart';
import 'package:com.rrk.wallpaper_app_firebase/provider/upload_wallpaper_provider.dart';
import 'package:com.rrk.wallpaper_app_firebase/utils/pick_files.dart';
import 'package:com.rrk.wallpaper_app_firebase/utils/show_alert.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddNewWallpaperPage extends StatefulWidget {
  const AddNewWallpaperPage({Key? key}) : super(key: key);

  @override
  State<AddNewWallpaperPage> createState() => _AddNewWallpaperPageState();
}

class _AddNewWallpaperPageState extends State<AddNewWallpaperPage> {
  final TextEditingController controller = TextEditingController();
  String image = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add New Wallpaper"),
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: controller,
                    decoration: const InputDecoration(
                        label: Text('Enter price (Optional)'),
                        border: OutlineInputBorder()),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    onTap: () {
                      pickImage().then((value) {
                        setState(() {
                          image = value;
                        });
                      });
                    },
                    child: const SizedBox(
                      height: 50,
                      width: 50,
                      child: Icon(Icons.camera),
                    ),
                  ),
                  if (image != '') Image.file(File(image)),
                  Consumer<UploadWallpaperProvider>(
                      builder: (context, add, child) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      if (add.message != '') {
                        showAlert(context, add.message);
                        add.clear();
                      }
                    });
                    return CustomButton(
                        text: 'Upload',
                        onTap: add.status == true
                            ? null
                            : () {
                                final uid =
                                    FirebaseAuth.instance.currentUser!.uid;

                                if (image != '') {
                                  add.addWallpaper(
                                      wallpaperImage: File(image),
                                      uid: uid,
                                      price: controller.text);
                                } else {
                                  showAlert(context, 'Upload image');
                                }
                              },
                        bgColor: add.status == true ? Colors.grey : Colors.blue,
                        textColor: Colors.white);
                  }),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
