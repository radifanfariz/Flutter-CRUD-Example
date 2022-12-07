import 'package:flutter_crud_example/app/network/data_source.dart';
import 'package:get/get.dart';

void bindingDataSource() => Get.lazyPut<DataSource>(
      () => DataSource(),
);