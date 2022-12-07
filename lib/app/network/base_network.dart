import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:dio/dio.dart';
import 'package:flutter_crud_example/app/model/gorest_entity.dart';

class BaseNetwork {
  static const String baseUrl = "https://gorest.co.in/public/v2/users";

  static const Map<String, dynamic> headerConfig = {
    HttpHeaders.contentTypeHeader: "application/json",
    HttpHeaders.authorizationHeader:
        "Bearer f313e77cbfa81153fd31356d6ead6538dfa602530118908a55a96053ffaa1933"
  };

  ///get data
  static Future<List<dynamic>> get(String? partUrl) async {
    final fullUrl = "$baseUrl${partUrl!}";

    debugPrint("BaseNetwork = fullUrl : $fullUrl");

    try {
      final response =
          await Dio().get(fullUrl, options: Options(headers: headerConfig));
      debugPrint(response.data.toString());
      return response.data;
    } catch (e) {
      debugPrint(e.toString());
      return [
        {
          "error": true,
          "message": e.toString(),
        }
      ];
    }
  }

  ///post data
  static Future<dynamic> post(
      String? partUrl, GorestEntity gorestEntity) async {
    final fullUrl = "$baseUrl${partUrl!}";

    debugPrint("BaseNetwork = fullUrl : $fullUrl");

    try {
      final response = await Dio().post(fullUrl,
          data: gorestEntityToJson(gorestEntity),
          options: Options(headers: headerConfig));
      debugPrint(response.toString());
      return {
        "error": false,
        "message": "Data baru berhasil ditambahkan !",
      };
    } catch (e) {
      debugPrint(e.toString());
      return {
        "error": true,
        "message": e.toString(),
      };
    }
  }

  ///put data
  static Future<dynamic> put(
      String? partUrl, String id, GorestEntity gorestEntity) async {
    final fullUrl = "$baseUrl${partUrl!}/$id";

    debugPrint("BaseNetwork = fullUrl : $fullUrl");

    try {
      final response = await Dio().put(fullUrl,
          data: gorestEntityToJson(gorestEntity),
          options: Options(headers: headerConfig));
      debugPrint(response.toString());
      return {
        "error": false,
        "message": "Data berhasil diubah !",
      };
    } catch (e) {
      debugPrint(e.toString());
      return {
        "error": true,
        "message": e.toString(),
      };
    }
  }

  ///delete data
  static Future<dynamic> delete(String? partUrl, String id) async {
    final fullUrl = "$baseUrl${partUrl!}/$id";

    debugPrint("BaseNetwork = fullUrl : $fullUrl");

    try {
      final response =
          await Dio().delete(fullUrl, options: Options(headers: headerConfig));
      debugPrint(response.toString());
      return {
        "error": false,
        "message": "Data dengan Id $id berhasil dihapus !",
      };
    } catch (e) {
      debugPrint(e.toString());
      return {
        "error": true,
        "message": e.toString(),
      };
    }
  }
}
