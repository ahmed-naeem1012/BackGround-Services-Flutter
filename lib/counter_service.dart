// ignore_for_file: deprecated_member_use, unused_element

import 'dart:math';

import 'package:flutter/foundation.dart';

import 'counter.dart';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class CounterService {
  factory CounterService.instance() => _instance;

  CounterService._internal() {
    _initializeNotifications();
  }

  static final _instance = CounterService._internal();

  final _counter = Counter();
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  ValueListenable<int> get count => _counter.count;

  Future<void> _initializeNotifications() async {
    var initializationSettingsAndroid =
        const AndroidInitializationSettings('@mipmap/ic_launcher');
    var initSettings =
        InitializationSettings(android: initializationSettingsAndroid);

    await _flutterLocalNotificationsPlugin.initialize(
      initSettings,
      // onSelectNotification: _onSelectNotification,
    );
  }

  final List<String> _notificationMessages = [
    // 'This is a long test notification message to check if the expandable feature works correctly when the notification is pulled down by the user.'

    "تأكد من مصداقية المصادر التي تطلب منك معلومات حساسة.",
    "قم بتحديث كلمات المرور الخاصة بك بشكل دوري",
    "لا تشارك أبدًا معلومات حساب البنك عبر الهاتف أو البريد الإلكتروني",
    "تأكد من إغلاق جميع الجلسات الخاصة بك عند استخدام أجهزة عامة",
    "استخدام كلمات مرور قوية: اختر كلمات مرور قوية وفريدة لكل حساب، وتجنب استخدام نفس كلمة المرور لأكثر من حساب",
    "تغيير كلمات المرور بانتظام: قم بتحديث كلمات المرور بشكل دوري لزيادة مستوى الأمان.",
    "التحقق الثنائي للهوية: فعّل خاصية التحقق الثنائي لحساباتك الحساسة لإضافة طبقة إضافية من الحماية.",
    "تفعيل إعدادات الأمان في الأجهزة: استخدم إعدادات الأمان المتاحة في أجهزتك مثل قفل الشاشة وميزات الحماية الأخرى.",
    "تحديد الأذونات للتطبيقات: قم بمراجعة وتحديد الأذونات التي تمنحها لتطبيقاتك لتقليل المخاطر الأمانية.",
    "التبليغ عن الاختراقات: في حال الشك في اختراق أو نشاط غير مألوف، قم بالإبلاغ فورًا إلى الجهات المعنية.",
    "التوعية الرقمية: قم بتوعية نفسك والآخرين حول مخاطر الأمان الرقمي وكيفية تجنبها.",
    "الابتعاد عن الشكل العاملي: تجنب مشاركة معلومات حساسة عبر الهاتف أو البريد الإلكتروني إلا إذا كنت واثقًا من المصدر.",
    "التحقق من فواتير البنك: راجع فواتير البنك بانتظام للكشف عن أي نشاط غير مألوف.",
  ];

  void _onSelectNotification(String? payload) {}

  void startCounting() {
    Stream.periodic(Duration(minutes: 1)).listen((_) async {
      // _counter.increment();
      // await _scheduleNotification(_counter.count.value);
    });
  }

  Future<void> _scheduleNotification(int count) async {
    var androidDetails = const AndroidNotificationDetails(
      'channel_id',
      'channel_name',
      importance: Importance.max,
      priority: Priority.high,
      styleInformation: BigTextStyleInformation(''),
    );
    var platformDetails = NotificationDetails(android: androidDetails);

    String notificationMessage =
        _notificationMessages[count % _notificationMessages.length];
    int notificationId = Random().nextInt(1000000);

    await _flutterLocalNotificationsPlugin.show(
      notificationId,
      'Abtzaz', // Title
      notificationMessage, // Body
      platformDetails, // Notification details
      payload: 'Item $count',
    );
  }
}
