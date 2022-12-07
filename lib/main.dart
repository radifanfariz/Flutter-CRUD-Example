import 'package:flutter/material.dart';
import 'package:flutter_crud_example/app/controller/bindings/controller_bindings.dart';
import 'package:flutter_crud_example/app/view/CreateScreen.dart';
import 'package:flutter_crud_example/app/view/DetailScreen.dart';
import 'package:get/get.dart';

import 'app/view/HomeScreen.dart';

void main() {
  runApp(GetMaterialApp(
    initialRoute: '/',
    getPages: [
      GetPage(name: '/', page: () => const HomeScreen(), binding: ControllerBindings()),
    ],
  ));
}
