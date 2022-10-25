import 'dart:io';
import 'package:image_picker/image_picker.dart';


class SettingsController{

  Future<File?> getImage()async{

    final imagePicker = ImagePicker();
    final xFileImage = await imagePicker.pickImage(source: ImageSource.gallery);

    if (xFileImage != null) {

      return File(xFileImage.path);
      
    }

    return null;

  } 

}