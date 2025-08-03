import 'dart:io';
import 'package:image_picker/image_picker.dart';

import '../../domain/repositories/media_service_repo.dart';

class MediaServiceRepoImpl implements MediaServiceRepo {
  @override
  Future<String?> pickImageFromGallery() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    return pickedFile?.path;
  }
}
