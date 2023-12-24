import 'dart:ui';

import 'package:abtzaz/app_retain_widget.dart';
import 'package:abtzaz/background_main.dart';
import 'package:abtzaz/counter_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
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
      body: Center(
        child: ValueListenableBuilder(
          valueListenable: CounterService.instance().count,
          builder: (context, count, child) {
            return Padding(
              padding: EdgeInsets.only(top: 30, right: 20, left: 25),
              child: SizedBox(
                width: double
                    .infinity, // to make the button take the full available width
                child: ElevatedButton(
                  onPressed: () {},
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                        Color.fromARGB(255, 71, 114, 145)),
                    padding: MaterialStateProperty.all(
                        const EdgeInsets.symmetric(
                            horizontal: 13, vertical: 15)),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                    ),
                  ),
                  child: Text(
                    ('Let Me In'),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
