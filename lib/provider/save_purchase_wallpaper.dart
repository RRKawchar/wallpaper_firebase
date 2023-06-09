import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SavePurchasedProvider {

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  void save({

    required String? wallpaperImage,
  }) async {
    CollectionReference _products = _firestore.collection("PurchasedWallpaper");

    final uid = FirebaseAuth.instance.currentUser!.uid;
    try {
      Map<String, dynamic> data = <String, dynamic>{
        "price": '',
        "uid": uid,
        "wallpaper_image": wallpaperImage,
      };
      _products.doc(uid).collection('Wallpaper').add(data);

    } catch (e) {
      print(e);
    }

    ///
  }
}