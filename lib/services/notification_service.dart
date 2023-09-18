import 'dart:developer';
import 'package:firebase_messaging/firebase_messaging.dart';

Future<void> backgroundHandler(RemoteMessage message) async {
  log("Message Reciver ${message.notification!.title.toString()}");
}

class NotificationSerivce {
  static Future<void> initialize() async {
    NotificationSettings setting =
        await FirebaseMessaging.instance.requestPermission();
    if (setting.authorizationStatus == AuthorizationStatus.authorized) {
      String? token = await FirebaseMessaging.instance.getToken();
      if (token != null) {
        log(token);
      }
      FirebaseMessaging.onBackgroundMessage(backgroundHandler);
      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        log("Message Received (Foreground): ${message.notification!.title.toString()}");
      });

      log("Notificaiton  Initilized");
    }
  }
}
