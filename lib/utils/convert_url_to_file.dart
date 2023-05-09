import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
Future<File> convertUrlToFile(String url)async{

final response =await http.get(Uri.parse(url));

final documentDirectory=await getApplicationDocumentsDirectory();

final file= File(join(documentDirectory.path,url.split('/').last));

file.writeAsBytesSync(response.bodyBytes);

return file;

}