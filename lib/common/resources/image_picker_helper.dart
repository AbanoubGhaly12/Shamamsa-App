import 'dart:io';

import 'package:image_picker/image_picker.dart';

class ImagePickerHelper {
  Future<File?> pickImageFromGallery({required Sink imageSink}) async {
    File? image;
    var galleryImage = await ImagePicker.platform.pickImage(source: ImageSource.gallery, imageQuality: 10);
    image = File(galleryImage!.path);
    imageSink.add(image);
    return image;
  }

  Future<File?> pickImageFromCamera({required Sink imageSink}) async {
    File? image;

    var galleryImage = await ImagePicker.platform.pickImage(source: ImageSource.camera, imageQuality: 10);

    image = File(galleryImage!.path);

    imageSink.add(image);
    return image;

  }
}
