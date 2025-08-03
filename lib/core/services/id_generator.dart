import 'package:uuid/uuid.dart';

abstract class IdGeneratorService{
  int generateNotificationId();
  String generateUuid();
}


class DefaultIdGeneratorService implements IdGeneratorService {
  final Uuid _uuid = const Uuid();

  @override
  int generateNotificationId() {
    return DateTime.now().millisecondsSinceEpoch % 100000;
  }

  @override
  String generateUuid() {
    return _uuid.v4();
  }
}