import 'package:flutter_crud_example/app/controller/bindings/controller_dependency.dart';
import 'package:flutter_crud_example/app/controller/bindings/datasource_dependency.dart';
import 'package:get/get.dart';

class ControllerBindings extends Bindings {
  @override
  void dependencies() {
    bindingDataSource();
    bindingGlobalController();
  }
}