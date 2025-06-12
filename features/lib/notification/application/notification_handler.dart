import 'package:firebase_messaging/firebase_messaging.dart';

abstract interface class FcmHandler {

  void handle(RemoteMessage remoteMessage);
}

class FcmForegroundHandler implements FcmHandler{

  @override
  void handle(RemoteMessage remoteMessage) {

  }
}