import 'dart:io';

abstract interface class MediaServiceRepo{
  Future<String?> pickImageFromGallery();
}