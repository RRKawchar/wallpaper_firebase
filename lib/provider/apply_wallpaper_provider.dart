import 'package:com.rrk.wallpaper_app_firebase/provider/save_purchase_wallpaper.dart';
import 'package:com.rrk.wallpaper_app_firebase/utils/convert_url_to_file.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_wallpaper_manager/flutter_wallpaper_manager.dart';

class ApplyWallpaperProvider extends ChangeNotifier{

  String _message='';
  bool _status=false;

  String get message=> _message;
  bool get status=> _status;



  void apply(String? image, int? location, String? path)async{


    _status=true;
    notifyListeners();


    try{
    final file=await convertUrlToFile(image!);
     await WallpaperManager.setWallpaperFromFile(file.path, location!);
     
     if(path!='saved'){
       SavePurchasedProvider().save(wallpaperImage: image);
     }
     
     _status=false;
     _message='Applied';
     notifyListeners();
    }catch(e){
      print(e);
   _status=false;
   _message="Error Occured";
   notifyListeners();



    }
  }
  void clearMessage(){
    _message="";
    notifyListeners();
  }
}