import 'package:firebase_messaging/firebase_messaging.dart';

abstract interface class NotificationHandler {

  void handle(RemoteMessage remoteMessage);
}

class NotificationFactory {

}