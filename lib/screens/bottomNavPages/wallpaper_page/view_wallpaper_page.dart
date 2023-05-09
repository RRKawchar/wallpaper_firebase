import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:com.rrk.wallpaper_app_firebase/provider/apply_wallpaper_provider.dart';
import 'package:com.rrk.wallpaper_app_firebase/utils/show_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_wallpaper_manager/flutter_wallpaper_manager.dart';
import 'package:provider/provider.dart';

class ViewWallpaperPage extends StatefulWidget {
  final QueryDocumentSnapshot<Object?>? data;
  final String? path;
  const ViewWallpaperPage({Key? key, this.data, this.path = ''})
      : super(key: key);

  @override
  State<ViewWallpaperPage> createState() => _ViewWallpaperPageState();
}

class _ViewWallpaperPageState extends State<ViewWallpaperPage> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Stack(
        fit: StackFit.expand,
        alignment: AlignmentDirectional.center,
        children: [
          Image.network(
            widget.data!.get('wallpaper_image'),
            fit: BoxFit.cover,
          ),
          Positioned(
              bottom: 10,
              child: GestureDetector(
                onTap: () {
                  if (widget.data!.get('price') != '') {
                    // Make a payment with PayStack
                  } else {
                    showModalSheet();
                  }
                },
                child: Container(
                  width: size.width - 50,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.blue),
                      borderRadius: BorderRadius.circular(8)),
                  child: Text(
                    widget.data!.get('price') == '' ? 'Apply' : 'Purchase',
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
              ))
        ],
      ),
    );
  }

  void showModalSheet() {
    List<String> applyText = ['Home Screen', 'Lock Screen', 'Both'];
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return SizedBox(
            height: 250,
            child: Consumer<ApplyWallpaperProvider>(
                builder: (context, applyProvider, child) {
              WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                if (applyProvider.message != '') {
                  showAlert(context, applyProvider.message);
                  applyProvider.clearMessage();
                  Navigator.pop(context);
                }
              });
              return Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    child: Text(applyProvider.status == true
                        ? "Please wait...Applying"
                        : 'Apply'),
                  ),
                  ...List.generate(applyText.length, (index) {
                    final data = applyText[index];

                    return GestureDetector(
                      onTap: () {
                        print(index);
                        final image = widget.data!.get('wallpaper_image');
                        switch (index) {
                          case 0:
                            applyProvider.apply(image,
                                WallpaperManager.HOME_SCREEN, widget.path);

                            break;
                          case 1:
                            applyProvider.apply(image,
                                WallpaperManager.LOCK_SCREEN, widget.path);
                            break;

                          case 2:
                            applyProvider.apply(image,
                                WallpaperManager.BOTH_SCREEN, widget.path);
                            break;
                        }
                      },
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 5),
                        width: MediaQuery.of(context).size.width - 50,
                        alignment: Alignment.center,
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.blue),
                            borderRadius: BorderRadius.circular(8)),
                        child: Text(
                          data,
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                    );
                  })
                ],
              );
            }),
          );
        });
  }
}
