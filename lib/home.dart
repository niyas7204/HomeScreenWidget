import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:home_widget/home_widget.dart';

class HomScreen extends StatefulWidget {
  const HomScreen({super.key});

  @override
  State<HomScreen> createState() => _HomScreenState();
}

class _HomScreenState extends State<HomScreen> {
  final String appGroupId = 'group.triel_home_widget';
  final String iosWidgetName = "triel_ios_home_widget";
  final String androidWidgetName = "triel_android_home_widget";
  final globalKey = GlobalKey();
  String? imagePath;
  @override
  void initState() {
    HomeWidget.setAppGroupId(appGroupId);
    super.initState();
  }

  Future updateWidget() async {
    final r0 = await HomeWidget.saveWidgetData<String>("tittle", "App host");
    log("save tittle status0 $r0");
    final r1 =
        await HomeWidget.saveWidgetData<String>("body", "App description");
    log("save body status1 $r1");
    final r2 = await HomeWidget.saveWidgetData<String>("widget_key", imagePath);
    log("save body status2 $r2");
    await Future.delayed(Duration(milliseconds: 500));
    final r = await HomeWidget.updateWidget(
        iOSName: iosWidgetName, androidName: androidWidgetName);
    log("update status $r");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 200,
              width: 200,
              color: Colors.red,
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: () async {
                  //   try {
                  //     var path = await HomeWidget.renderFlutterWidget(
                  //         Container(
                  //           key: globalKey,
                  //           height: 200,
                  //           width: 200,
                  //           color: Colors.red,
                  //         ),
                  //         key: "widget_key",
                  //         pixelRatio: .5);
                  //     setState(() {
                  //       imagePath = path;
                  //     });
                  //   } catch (e) {
                  //     log("set path error $e");
                  //   }

                  //   log("call update");
                  //   if (imagePath != null) {
                  //     await updateWidget();
                  //   } else {
                  //     log("path is  null");
                  //   }
                },
                child: const Text("Update")),
          ],
        ),
      )),
    );
  }
}
