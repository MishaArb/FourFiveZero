import 'dart:io';

import '../../core/usecase/no_params.dart';
import '../../core/usecase/usecase.dart';

import '../repositories/media_service_repo.dart';

class PickImageUseCase implements UseCase<String?, NoParams> {
  PickImageUseCase(this.mediaService);

  final MediaServiceRepo mediaService;

  @override
  Future<String?> call({NoParams? params}) async {
    return await mediaService.pickImageFromGallery();
  }
}
