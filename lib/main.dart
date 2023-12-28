import 'dart:developer';
import 'dart:ui';

import 'package:abtzaz/app_retain_widget.dart';
import 'package:abtzaz/background_main.dart';
import 'package:abtzaz/counter_service.dart';
import 'package:abtzaz/services/notification_services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:flutter/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());

  var channel = const MethodChannel('com.example/background_service');
  var callbackHandle = PluginUtilities.getCallbackHandle(backgroundMain);
  channel.invokeMethod('startService', callbackHandle!.toRawHandle());

  CounterService.instance().startCounting();
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Abtzaz',
      home: AppRetainWidget(
        child: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  NotificationServices notificationServices = NotificationServices();
  @override
  void initState() {
    notificationServices.requestNotificationPermission();
    notificationServices.firebaseInit(context);
    notificationServices.isTokenRefresh();

    notificationServices.getDeviceToken().then((value) => print(value));
    super.initState();
  }

  bool check = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(221, 226, 226, 226),
      appBar: AppBar(
        title: Row(
          children: [
            Text(
              ' Abtzaz',
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
        backgroundColor: Colors.black,
      ),
      body: Column(
        mainAxisAlignment:
            MainAxisAlignment.spaceBetween, // Adjusts main axis alignment
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.only(right: 15, left: 15, top: 30),
            child: Text(
              'تطبيق الابتزاز يقدم نصائح فورية لتوعية المستخدمين حول مخاطر الابتزاز الإلكتروني، ضمانًا لسلامتهم الرقمية',
              textAlign: TextAlign.right,
              style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                  color: Color.fromARGB(255, 14, 12, 64)),
            ),
          ),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 0.0),
                child: Center(
                  child: ValueListenableBuilder(
                    valueListenable: CounterService.instance().count,
                    builder: (context, count, child) {
                      return Padding(
                        padding: EdgeInsets.only(top: 0, right: 20, left: 25),
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              check = true;
                              log(check.toString());
                            });
                          },
                          child: SizedBox(
                              child: Image.asset(
                            check == false
                                ? 'assets/images/1.png'
                                : 'assets/images/2.png',
                            height: 200,
                            width: 200,
                          )),
                        ),
                      );
                    },
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 20, left: 25, bottom: 35),
                child: Text(
                  '"نحن مستعدون لاستماع اقتراحاتكم ومشاركتكم في تطوير التطبيق. يُرجى التواصل معنا عبر الأرقام التالية لتبادل أفكاركم وتجاربكم. شكرًا لتعاونكم في جعل التطبيق أفضل!"',
                  textAlign: TextAlign.right,
                  style: TextStyle(),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 20.0),
            child: Text(
              '0317043169',
              style: TextStyle(
                  fontSize: 14, color: Color.fromARGB(250, 60, 60, 60)),
            ),
          )
        ],
      ),
    );
  }
}
