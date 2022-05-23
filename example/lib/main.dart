import 'package:dashx_flutter/dashx_flutter.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String message = 'Unknown';
  String uid = '';
  DashXPlugin dashxFlutterPlugin = DashXPlugin();
  DashX dx = DashX(
    publicKey: '',
    baseUri: '',
    targetEnvironment: '',
  );

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.

    try {
      dashxFlutterPlugin;
      uid = await dx.getUuid().then((value) => value);
    } on PlatformException {
      message = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        title: const Text('Plugin example app'),
      ),
      body: Center(
          child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text('Anonymous UID'),
          ),
          Text(uid.toString()),
          TextButton(
              onPressed: () {
                dx.identify();
              },
              child: const Text("Identify ")),
          TextButton(onPressed: () {}, child: const Text("Update Profile ")),
          TextButton(onPressed: () {}, child: const Text("Logout ")),
          TextButton(onPressed: () {}, child: const Text("Start Game "))
        ],
      )),
    ));
  }
}
