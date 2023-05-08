import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class UploadWallpaperProvider extends ChangeNotifier {
  String _message = '';
  bool _status = false;
  String get message => _message;
  bool get status => _status;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  void clear() {
    _message = "";
    notifyListeners();
  }

  void addWallpaper({
    File? wallpaperImage,
    String? uid,
    String? price,
  }) async {
    _status = true;
    notifyListeners();

    CollectionReference collectionRef = _firestore.collection('addWallpaper').doc(uid!).collection('users');

    String imagePath = '';

    try {
      _message = "Uploading image...";
      notifyListeners();

      final imageName = wallpaperImage!.path.split('/').last;
      await _storage
          .ref()
          .child("$uid/wallpaper/$imageName")
          .putFile(wallpaperImage)
          .whenComplete(() async {
        await _storage
            .ref()
            .child("$uid/wallpaper/$imageName")
            .getDownloadURL()
            .then((value) {
          imagePath = value;
        });

        final data = {
          'price': price,
          'uid': uid,
          'wallpaper_image': imagePath,
        };

        await collectionRef.add(data);
        _status=false;
        _message='Successful';
        notifyListeners();

      });
    } on FirebaseException catch (e) {
      _status = false;
      _message = e.message.toString();
      notifyListeners();
    } on SocketException catch (_) {
      _status = false;
      _message = "Internet is required to perform this action";
      notifyListeners();
    } catch (e) {
      print(e);
      _status = false;
      _message = "please try again....";
      notifyListeners();
    }
  }
}
