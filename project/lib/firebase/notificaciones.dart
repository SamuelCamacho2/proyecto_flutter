// import 'dart:convert';
// import 'dart:io';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// Future<void> handleBackgroundMessage(RemoteMessage message) async{
//     print('Title : ${message.notification?.title}');
//     print('Body : ${message.notification?.body}');
//     print('Payload : ${message.data}');
//   }

// class Notificaciones {

//   final FirebaseMessaging messaging = FirebaseMessaging.instance;
//   String? token;

//   Future<void> initializeApp() async {
//     await messaging.requestPermission();
//     token = await messaging.getToken();
//     print("TOKEN: $token");
//     initPushNotifications();
//   }

//   Future notificaciones() async {
//     FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
//     FirebaseMessaging.onMessage.listen((RemoteMessage message) {
//         print('Title : ${message.notification?.title}');
//         print('Body : ${message.notification?.body}');
//         print('Payload : ${message.data}');
//         print('Payload : ${message.data}');
//         print('Payload : ${message.data}');
//         if(message.notification != null){
//           print('aaaaaaa ${message.notification}');
//         }
//       });
//   }

//   void handleMessage(RemoteMessage? message) {
//     if(message == null) return;
//   }  

//   Future initPushNotifications() async {
//     await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
//       alert: true,
//       badge: true,
//       sound: true,
//     );
//     FirebaseMessaging.instance.getInitialMessage().then(handleMessage);

//     FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
//   }
// }

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

  Future<void> backgrounNoti(RemoteMessage message) async{
    print('Title: ${message.notification?.title}');
    print('Body: ${message.notification?.body}');
    print('Payload: ${message.data}');
  }


class NotificationService {

  final messaging = FirebaseMessaging.instance;

  final _androidChannel = const AndroidNotificationChannel(
    'high_importance_channel',
    'High Importance Notifications',
    description: 'This channel is used for important notifications',
    importance: Importance.defaultImportance,
  );

  final _localnotification = FlutterLocalNotificationsPlugin();

  Future initLocalNotifications() async{
    const android = AndroidInitializationSettings('@drawable/ic_launcher');
    const setting = InitializationSettings(android: android);

    await _localnotification.initialize(
      setting
    );

    final platform = _localnotification.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>();
    await platform?.createNotificationChannel(_androidChannel);
  }

  Future<void> initNotifications() async{
    await messaging.requestPermission();
    final token = await FirebaseMessaging.instance.getToken();
    print('Token: $token');
    FirebaseMessaging.onBackgroundMessage(backgrounNoti);
    FirebaseMessaging.onMessage.listen((mensaje) { 
      final notificacion = mensaje.notification;
      if (notificacion == null) return;
      _localnotification.show(notificacion.hashCode, notificacion.title, notificacion.body, NotificationDetails(
        android: AndroidNotificationDetails(
          _androidChannel.id, 
          _androidChannel.name,
          channelDescription: _androidChannel.description,
          icon: '@drawable/ic_launcher'
        )
      ),
      payload: jsonEncode(mensaje.toMap()),
      );
    });
    initLocalNotifications();
  }
  
}