import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_crud_example/app/model/gorest_entity.dart';
import 'package:flutter_crud_example/app/network/data_source.dart';
import 'package:get/get.dart';

class GlobalController extends GetxController {
  DataSource? dataSource;

  GlobalController({this.dataSource});

  ScrollController scrollController = ScrollController();

  TextEditingController textEditingController = TextEditingController();

  RxList<GorestEntity?> gorestEntityList = <GorestEntity?>[].obs;

  // var dataGorest = [].obs;

  ////infinte scroll
  var page = 0.obs;
  var perPage = 10.obs;
  var isLoading = true.obs;

  ////search
  var textSearchValue = "".obs;

  ////forms
  int? idValue;
  var textNameValue = "";
  var textEmailValue = "";
  var textGenderValue = "";
  var textStatusValue = "";

  ////debounce
  Timer? _debounce;

  @override
  void onInit() {
    _resetData();
    _fetchDataPaginationInit();
    _fetchDataPagination();
    _fetchDataSearch();
    super.onInit();
  }

  @override
  void onClose() {
    _resetData();
    super.onClose();
  }

  void _fetchData() async {
    try {
      gorestEntityList.value = await dataSource?.loadData();
      debugPrint("Data From Gorest : ${gorestEntityList.toString()}");
    } catch (e) {
      debugPrint("error: ${e.toString()}");
    }
  }

  void _fetchDataPaginationInit() async {
    page.value = page.value + 1;
    try {
      isLoading(true);
      List<dynamic>? dataList =
          await dataSource?.loadDataPagination(page.value, perPage.value);
      dataList?.forEach((item) => gorestEntityList.add(GorestEntity(
            id: item["id"],
            name: item["name"],
            email: item["email"],
            gender: item["gender"],
            status: item["status"],
          )));
      gorestEntityList.value = gorestEntityList.reversed.toList();
      debugPrint("GorestEntity Length : ${gorestEntityList.length}");
    } catch (e) {
      isLoading(true);
      debugPrint("error: ${e.toString()}");
    } finally {
      isLoading(false);
    }
  }

  void _fetchDataPagination() {
    scrollController.addListener(_scrollListenerFetch);
  }

  void _fetchDataSearch() {
    textEditingController.addListener(_textEditingListenerFetch);
  }

  dynamic createData() async {
    try {
      isLoading(true);
      dynamic info = await dataSource?.createData(
          GorestEntity(
            name: textNameValue,
            email: textEmailValue,
            gender: textGenderValue,
            status: textStatusValue,
          ));
      if(info["error"] == false) {
        gorestEntityList.add(GorestEntity(
          id: idValue,
          name: textNameValue,
          email: textEmailValue,
          gender: textGenderValue,
          status: textStatusValue,
        ));
      }
      debugPrint("dataList item : ${info?.toString()}");
      return info;
    } catch (e) {
      isLoading(true);
      debugPrint("error: ${e.toString()}");
    } finally {
      isLoading(false);
    }
  }

  dynamic updateData() async {
    try {
      isLoading(true);
      dynamic info = await dataSource?.updateData(
          idValue!,
          GorestEntity(
            name: textNameValue,
            email: textEmailValue,
            gender: textGenderValue,
            status: textStatusValue,
          ));
      if(info["error"] == false) {
        gorestEntityList[gorestEntityList
            .indexWhere((element) => element?.id == idValue)] = GorestEntity(
          id: idValue,
          name: textNameValue,
          email: textEmailValue,
          gender: textGenderValue,
          status: textStatusValue,
        );
      }
      debugPrint("dataList item : ${info?.toString()}");
      return info;
    } catch (e) {
      isLoading(true);
      debugPrint("error: ${e.toString()}");
    } finally {
      isLoading(false);
    }
  }

  dynamic deleteData() async {
    try {
      isLoading(true);
      dynamic info = await dataSource?.deleteData(
          idValue!);
      if(info["error"] == false) {
        gorestEntityList.removeWhere((element) => element?.id == idValue);
      }
      debugPrint("dataList item : ${info?.toString()}");
      return info;
    } catch (e) {
      isLoading(true);
      debugPrint("error: ${e.toString()}");
    } finally {
      isLoading(false);
    }
  }

  ///////////////////////////////////////////////////////////////////////////////////////////////
  ////scrollListener
  void _scrollListenerFetch() async {
    if (scrollController.position.maxScrollExtent ==
        scrollController.position.pixels) {
      page.value = page.value + 1;
      try {
        isLoading(true);
        List<dynamic?>? dataList =
            await dataSource?.loadDataPagination(page.value, perPage.value);
        dataList?.forEach((item) => gorestEntityList.add(GorestEntity(
              id: item["id"],
              name: item["name"],
              email: item["email"],
              gender: item["gender"],
              status: item["status"],
            )));
        gorestEntityList.value = gorestEntityList.reversed.toList();
        debugPrint("Loading State: $isLoading");
        debugPrint(
            "<For Pagination> gorestEntity Length : ${gorestEntityList.length}");
      } catch (e) {
        isLoading(true);
        debugPrint("error: ${e.toString()}");
      } finally {
        isLoading(false);
      }
    }
  }

  ////textEditingListener
  void _textEditingListenerFetch() async {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () async {
      _resetData();
      textSearchValue.value = "?name=${textEditingController.value.text}";
      debugPrint("Test Search: ${textSearchValue.value}");
      if (textEditingController.value.text == "") {
        _fetchDataPaginationInit();
        _fetchDataPagination();
      } else {
        scrollController.removeListener(_scrollListenerFetch);
        try {
          isLoading(true);
          List<dynamic>? dataList =
              await dataSource?.loadDataSearch(textSearchValue.value);
          dataList?.forEach((item) => gorestEntityList.add(GorestEntity(
                id: item["id"],
                name: item["name"],
                email: item["email"],
                gender: item["gender"],
                status: item["status"],
              )));
          gorestEntityList.value = gorestEntityList.reversed.toList();
          debugPrint("gorestEntity Length : ${gorestEntityList.length}");
        } catch (e) {
          isLoading(true);
          debugPrint("error: ${e.toString()}");
        } finally {
          isLoading(false);
        }
      }
    });
  }

  void _resetData() {
    gorestEntityList.clear();
  }
}
