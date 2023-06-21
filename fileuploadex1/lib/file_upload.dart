import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';

class FileUPload{
  static void uploadFile() async{
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if(result != null){
     final filePath = result.files.single.path;

     var dio = Dio();

     var formData = FormData.fromMap({
       "file" : await MultipartFile.fromFile(filePath!),
       "id" : "hello"
     });
     final response = await dio.post("http://10.0.2.2:7000/catalog-service/fileupload",
     data: formData);
     print(response.statusCode);
    }
  }
}