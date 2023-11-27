// ignore_for_file: unused_local_variable, avoid_print

import 'package:callkit_test/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotificationServices {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  void onDidReceiveLocalNotification(
    int id,
    String? title,
    String? body,
    String? payload,
  ) async {
    print("Payload: $payload>>>>>>>>>>>>>>>> Call Accepted ");
  }

  showNotification() async {
    print("Showing Notification");
    var androidPlatformChannelSpecifics = const AndroidNotificationDetails(
      '0',
      'incoming_call',
      channelDescription: 'For incoming calls',
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
      enableVibration: true,
      playSound: true,
      ongoing: true,
      autoCancel: false,
      sound: UriAndroidNotificationSound("ringtones/incomingcall.mp3"),
      actions: [
        AndroidNotificationAction(
          'accept',
          'Accept',
          titleColor: Colors.green,
        ),
        AndroidNotificationAction(
          'decline',
          'Decline',
          titleColor: Colors.red,
        )
      ],
    );

    var iOSPlatformChannelSpecifics = const DarwinNotificationDetails(
      badgeNumber: 0,
      presentSound: true,
      // sound: 'slow_spring_board.aiff',
      sound: 'incomingcall.mp3',
      categoryIdentifier: darwinNotificationCategoryText,
    );
    var notificationDetails = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iOSPlatformChannelSpecifics,
    );
    await flutterLocalNotificationsPlugin.show(
      0,
      'Fake Incoming Call',
      'Call from Fake Caller',
      notificationDetails,
      payload: 'item x',
    );
  }

  Future<void> scheduleNotification() async {
    // await Future.delayed(const Duration(seconds: 5));

    await showNotification();

    // Wait for 1 minute
    await Future.delayed(const Duration(minutes: 1));

    // Cancel the notification after 1 minute
    await flutterLocalNotificationsPlugin
        .cancel(0); // Cancel notification with ID 0

    print("Closed notification");
  }
}
