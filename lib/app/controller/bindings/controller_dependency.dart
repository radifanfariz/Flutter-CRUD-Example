import 'package:flutter_crud_example/app/controller/global_controller.dart';
import 'package:flutter_crud_example/app/network/data_source.dart';
import 'package:get/get.dart';

void bindingGlobalController() => Get.lazyPut<GlobalController>(
      () => GlobalController(dataSource: Get.find<DataSource>()),
);