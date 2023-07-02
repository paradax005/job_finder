import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:job_finder/constants/app_constants.dart';
import 'package:uuid/uuid.dart';

class ImageHelper extends ChangeNotifier {
  var uuid = const Uuid();
  final ImagePicker _picker = ImagePicker();

  String? imageUrl;
  String? imagePath;

  List<String> imageF = [];

  void pickImage() async {
    XFile? imageFile = await _picker.pickImage(source: ImageSource.gallery);

    imageFile = await cropImage(imageFile!);

    if (imageFile != null) {
      imageF.add(imageFile.path);

      uploadImage(imageFile);

      imagePath = imageFile.path;
    } else {
      return;
    }
  }

  Future<XFile?> cropImage(XFile imageFile) async {
    CroppedFile? croppedFile = await ImageCropper.platform.cropImage(
        sourcePath: imageFile.path,
        maxHeight: 800,
        maxWidth: 600,
        compressQuality: 70,
        cropStyle: CropStyle.rectangle,
        aspectRatioPresets: [
          CropAspectRatioPreset.ratio5x4
        ],
        uiSettings: [
          AndroidUiSettings(
            toolbarTitle: "JobHub Cropper",
            toolbarColor: Color(kLightBlue.value),
            toolbarWidgetColor: Color(kLight.value),
            initAspectRatio: CropAspectRatioPreset.ratio5x4,
            lockAspectRatio: true,
          ),
          IOSUiSettings(
            title: "JobHub Cropper",
          ),
        ]);

    if (croppedFile != null) {
      notifyListeners();
      return XFile(croppedFile.path);
    } else {
      return null;
    }
  }

  Future<String?> uploadImage(XFile file) async {
    File image = File(file.path);

    final ref = FirebaseStorage.instance
        .ref()
        .child("jobhub")
        .child("${uuid.v1()}.jpg");

    await ref.putFile(image);

    imageUrl = await (ref.getDownloadURL());

    notifyListeners();

    return imageUrl;
  }
}
