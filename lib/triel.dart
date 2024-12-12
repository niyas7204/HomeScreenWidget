import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:home_screeen_widget/home.dart';

class TrielView extends StatefulWidget {
  const TrielView({super.key});

  @override
  State<TrielView> createState() => _TrielViewState();
}

class _TrielViewState extends State<TrielView> {
  static const platform =
      MethodChannel("com.example.home_screeen_widget/widget");
  Future<void> openWidgetPicker() async {
    try {
      log("openWidgetPicker in futter");
      await platform.invokeMethod("openWidgetPicker");
    } catch (e) {
      log("openWidgetPicker error :$e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
            onPressed: () async {
              await openWidgetPicker();
            },
            child: Text("go")),
      ),
    );
  }
}
