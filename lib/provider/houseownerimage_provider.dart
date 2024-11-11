import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class HouseOwnerImageProvider extends ChangeNotifier {
  File? _image;
  final picker = ImagePicker();

  File? get image => _image;

  Future<void> getImageGallery() async {
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
    );
    if (pickedFile != null) {
      _image = File(pickedFile.path);
      print("The Image Path of Sandeep is:::: ${_image!.path}");
      notifyListeners();
    } else {
      print("No Image Picked");
    }
  }

  void removeImage() {
    _image = null;
    notifyListeners();
  }
}
