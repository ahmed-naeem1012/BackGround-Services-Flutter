// ignore_for_file: deprecated_member_use

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
      onSelectNotification: _onSelectNotification,
    );
  }

  final List<String> _notificationMessages = [
    'لا تشارك كود الواتسب مع أي شخص', // 'Do not share your WhatsApp code with anyone'
    'لا تفتح رابط مشبوه', // 'Do not open a suspicious link'
    'أجعل الارقام السرية قوية' // 'Make your passwords strong'
  ];
  void _onSelectNotification(String? payload) {}

  void startCounting() {
    Stream.periodic(Duration(seconds: 10)).listen((_) async {
      _counter.increment();
      await _scheduleNotification(_counter.count.value);
    });
  }

  Future<void> _scheduleNotification(int count) async {
    // Step 2: Modify the method to select a message based on the count
    var scheduledNotificationDateTime =
        DateTime.now().add(const Duration(seconds: 10));
    var androidDetails = const AndroidNotificationDetails(
      'channel_id',
      'channel_name',
      importance: Importance.max,
      priority: Priority.high,
    );
    var platformDetails = NotificationDetails(android: androidDetails);

    // Step 3: Use modulo operator to loop through the notifications
    String notificationMessage =
        _notificationMessages[count % _notificationMessages.length];

    await _flutterLocalNotificationsPlugin.schedule(
      0,
      'Abtzaz',
      '$notificationMessage',
      scheduledNotificationDateTime,
      platformDetails,
    );
  }
}
