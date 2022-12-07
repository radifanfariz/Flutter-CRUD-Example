import 'package:flutter/material.dart';
import 'package:flutter_crud_example/app/controller/global_controller.dart';
import 'package:flutter_crud_example/app/view/CreateScreen.dart';
import 'package:flutter_crud_example/app/view/DetailScreen.dart';
import 'package:get/get.dart';

class HomeScreen extends GetView<GlobalController> {
  const HomeScreen({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
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
            title: const Text("Flutter CRUD"),
          ),
          floatingActionButton: FloatingActionButton(
            child: const Icon(Icons.add),
            onPressed: (){
                Get.to(CreateScreen());
            },
          ),
          body: Container(
            child: Column(
              children: [
                Obx(() => TextField(
                      controller: controller.textEditingController,
                      decoration: const InputDecoration(
                          icon: Icon(Icons.search), hintText: "Serach"),
                    )),
                Obx(() => Flexible(
                      child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        controller: controller.scrollController,
                        itemCount: controller.gorestEntityList.length,
                        itemBuilder: (BuildContext context, int index) {
                          int? id = controller.gorestEntityList
                              .elementAt(index)
                              ?.id;
                          String? name = controller.gorestEntityList
                              .elementAt(index)
                              ?.name;
                          String? email = controller.gorestEntityList
                              .elementAt(index)
                              ?.email;
                          String? gender = controller.gorestEntityList
                              .elementAt(index)
                              ?.gender;
                          String? status = controller.gorestEntityList
                              .elementAt(index)
                              ?.status;
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SizedBox(
                              height: 120,
                              child: Card(
                                color: Colors.black,
                                child: ListTile(
                                  onTap: () {
                                    Get.to(DetailScreen(controller
                                        .gorestEntityList
                                        .elementAt(index)));
                                  },
                                  subtitle: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Id : $id",
                                        style: const TextStyle(
                                            color: Colors.white),
                                      ),
                                      Text(
                                        "Name : $name",
                                        style: const TextStyle(
                                            color: Colors.white),
                                      ),
                                      Text(
                                        "Email : $email",
                                        style: const TextStyle(
                                            color: Colors.white),
                                      ),
                                      Text(
                                        "Gender : $gender",
                                        style: const TextStyle(
                                            color: Colors.white),
                                      ),
                                      Text(
                                        "Status : $status",
                                        style: const TextStyle(
                                            color: Colors.white),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    )),
                Obx(() {
                  return Visibility(
                      visible: controller.isLoading.value,
                      child: const Padding(
                        padding: EdgeInsets.all(20.0),
                        child: CircularProgressIndicator(),
                      ));
                })
              ],
            ),
          )),
    );
  }
}
