import 'dart:math';

import 'package:app/main.dart';
import 'package:app/pages/quiz_execution_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;
import 'package:flutter_timezone/flutter_timezone.dart';

class NotiService {
  final notificationsPlugin = FlutterLocalNotificationsPlugin();

  bool _isInitialized = false;

  bool get isInitialized => _isInitialized;

  Future<void> initNotification() async {
    if (_isInitialized) return;

    tz.initializeTimeZones();
    final String currentTimezone = await FlutterTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(currentTimezone));

    const initSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const initSettingsIos = DarwinInitializationSettings(
        requestAlertPermission: true,
        requestBadgePermission: true,
        requestSoundPermission: true);
    const initSettings = InitializationSettings(
        android: initSettingsAndroid, iOS: initSettingsIos);

    await notificationsPlugin.initialize(initSettings,
        onDidReceiveBackgroundNotificationResponse:
            onDidReceiveNotificationResponse,
        onDidReceiveNotificationResponse: onDidReceiveNotificationResponse);
  }

  NotificationDetails notificationDetails() {
    return const NotificationDetails(
      android: AndroidNotificationDetails(
          'daily_channel_id', 'Daily Notifications',
          channelDescription: 'Daily Notification Channel',
          importance: Importance.max,
          priority: Priority.high),
      iOS: DarwinNotificationDetails(),
    );
  }

  Future<void> showNotification({
    int id = 0,
    String? title,
    String? body,
  }) async {
    return notificationsPlugin.show(id, title, body, notificationDetails());
  }

  Future<void> scheduleNotification(
      {int id = 1,
      required String title,
      required String body,
      required int hour,
      required int minute,
      required String quizId}) async {
    final now = tz.TZDateTime.now(tz.local);

    var scheduleDate =
        tz.TZDateTime(tz.local, now.year, now.month, now.day, hour, minute);

    await notificationsPlugin.zonedSchedule(
        id, title, body, scheduleDate, notificationDetails(),
        androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
        matchDateTimeComponents: DateTimeComponents.time,
        payload: quizId);
    print("Schedulata ${scheduleDate.toString()}");
  }

  Future<void> cancelAllNotifications() async {
    await notificationsPlugin.cancelAll();
  }

  Future<void> sendRandomDailyNotification() async {
    final random = Random();
    final quizzesSnapshot = await FirebaseFirestore.instance
        .collection('quizzes')
        .where('creator', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .get();
    if (quizzesSnapshot.docs.isEmpty) {
      return;
    }
    final quizzesWithFlashcards = <QueryDocumentSnapshot>[];
    for (var quiz in quizzesSnapshot.docs) {
      final flashcardsSnapshot =
          await quiz.reference.collection('flashcards').get();
      if (flashcardsSnapshot.docs.isNotEmpty) {
        quizzesWithFlashcards.add(quiz);
      }
    }

    if (quizzesWithFlashcards.isEmpty) {
      return;
    }

    final randomQuiz =
        quizzesWithFlashcards[random.nextInt(quizzesWithFlashcards.length)];

    int hour = random.nextInt(10) + 9;
    int minute = random.nextInt(60);

    String title = 'Notifica giornaliera';
    String body = 'Ripassa delle flashcard casuali';

    await scheduleNotification(
      title: title,
      body: body,
      hour: hour,
      minute: minute,
      quizId: randomQuiz.id,
    );
  }

  static void onDidReceiveNotificationResponse(
      NotificationResponse notificationResponse) async {
    final String? payload = notificationResponse.payload;
    print("Payload ricevuto: $payload");
    if (notificationResponse.payload != null &&
        notificationResponse.payload!.isNotEmpty) {
      final quizSnapshot = await FirebaseFirestore.instance
          .collection('quizzes')
          .doc(payload)
          .get();

      if (quizSnapshot.exists) {
        final flashcardsCount = await FirebaseFirestore.instance
            .collection('quizzes')
            .doc(payload)
            .collection('flashcards')
            .get()
            .then((snapshot) => snapshot.size);

        navigatorKey.currentState?.push(
          MaterialPageRoute(
            builder: (context) => QuizExecutionPage(
              quiz: quizSnapshot,
              flashcardsCount: flashcardsCount,
            ),
          ),
        );
      }
    }
  }
}
