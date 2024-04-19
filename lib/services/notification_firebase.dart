import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_blog/routes/routes.dart';
import 'package:get/get.dart';

class FirebaseAPI {
  final _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> initNotification() async {
    // request permission
    await _firebaseMessaging.requestPermission();

    // token for device
    final fcmToken = await _firebaseMessaging.getToken();
    // print token
    print('FCM Token: $fcmToken');
    initPushNotification();
  }

  // handle received message
  void handleNotificationMessage(RemoteMessage? message) {
    if (message == null) return;

    Get.toNamed(
      Routes.notificationPage,
      arguments: message,
    );
  }

  Future initPushNotification() async {
    // handle notification when app was terminated and opened by tapping on notification
    FirebaseMessaging.instance
        .getInitialMessage()
        .then((handleNotificationMessage));

    // attach event listener for when notificaiton opens the app
    FirebaseMessaging.onMessageOpenedApp.listen((handleNotificationMessage));
  }
}
