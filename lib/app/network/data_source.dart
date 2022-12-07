import 'package:flutter_crud_example/app/model/gorest_entity.dart';
import 'package:flutter_crud_example/app/network/base_network.dart';

class DataSource {
  static DataSource instance = DataSource();

  Future<dynamic> loadData(){
    return BaseNetwork.get("");
  }

  Future<dynamic?> loadDataPagination(int page, int perPage){
    return BaseNetwork.get("?page=$page&per_page=$perPage");
  }

  Future<dynamic> loadDataSearch(String value){
    return BaseNetwork.get(value);
  }

  Future<dynamic?> createData(GorestEntity gorestEntity){
    return BaseNetwork.post("",gorestEntity);
  }

  Future<dynamic?> updateData(int id,GorestEntity gorestEntity){
    return BaseNetwork.put("","$id",gorestEntity);
  }

  Future<dynamic?> deleteData(int id){
    return BaseNetwork.delete("","$id");
  }

}