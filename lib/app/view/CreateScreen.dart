import 'package:flutter/material.dart';
import 'package:flutter_crud_example/app/controller/bindings/controller_bindings.dart';
import 'package:flutter_crud_example/app/controller/global_controller.dart';
import 'package:flutter_crud_example/app/model/gorest_entity.dart';
import 'package:get/get.dart';

void initValue(GlobalController controller) {
  controller.idValue = null;
  controller.textNameValue = "";
  controller.textEmailValue = "";
  controller.textGenderValue = "";
  controller.textStatusValue = "";
}

class CreateScreen extends GetView<GlobalController> {

  const CreateScreen({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    initValue(controller);
    return MaterialApp(
      title: 'Flutter CRUD',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            title: const Text("Create"),
            leading: InkWell(
              onTap: () {
                Get.back();
              },
              child: const Icon(
                Icons.arrow_back,
              ),
            ),
          ),
          body: Container(
            padding: EdgeInsets.only(top: 20),
            child: Obx(() {
              return Stack(children: [
                Visibility(
                    visible: controller.isLoading.value,
                    child: const Center(
                      child: CircularProgressIndicator(),
                    )),
                Visibility(
                  visible: !(controller.isLoading.value),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: TextFormField(
                          onChanged: (value) {
                            controller.textNameValue = value;
                          },
                          initialValue: controller.textNameValue,
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(), labelText: "Name"),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: TextFormField(
                          onChanged: (value) {
                            controller.textEmailValue = value;
                          },
                          initialValue: controller.textEmailValue,
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(), labelText: "Email"),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: TextFormField(
                          onChanged: (value) {
                            controller.textGenderValue = value;
                          },
                          initialValue: controller.textGenderValue,
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: "Gender"),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: TextFormField(
                          onChanged: (value) {
                            controller.textStatusValue = value;
                          },
                          initialValue: controller.textStatusValue,
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: "Status"),
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: ElevatedButton(
                            onPressed: () async {
                              dynamic info = await controller.createData();
                              Get.back();
                              Get.snackbar(
                                'Info',
                                (info != null)
                                    ? (info["error"] == false) ? info["message"] : "Ada input yang tidak valid !"
                                    : "Terjadi kesalahan !",
                                snackPosition: SnackPosition.TOP,
                              );
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue),
                            child: const Text("Buat Pengguna")),
                      ),
                    ],
                  ),
                ),
              ]);
            }),
          )),
    );
  }
}
