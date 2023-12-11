import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:trabalhos_dio/models/cep_back4app_model.dart';

import '../models/tarefa_model_getx.dart';



class TarefaApi{


  Future<List<TarefaModel>> getAllBy4App(bool concluidos) async{

    var url = "https://parseapi.back4app.com/classes/Tarefas";
    var dio = Dio();

    RxList<TarefaModel> lista = <TarefaModel>[].obs;

    dio.options.headers["X-Parse-Application-Id"] = "dkQpjL9UrLtmVQGCSu3MDXgq4ZiPQzY9HbrjXBSq";
    dio.options.headers["X-Parse-REST-API-Key"] = "OJhmqZWPhUQSae0f87mASDvI7tjwFp7DJ0iRmSOT";
    dio.options.headers["Content-Type"] = "application/json";

    url+="?where={\"concluida\":${concluidos.toString()}}";

    var result = await dio.get(url);
    var response =  TarefaGetxModel.fromJson(result.data);

    for(var item in response.results!){
      lista.add(item);
    }
    return lista;

  }
  Future<void> add(TarefaModel model) async {

    var url = "https://parseapi.back4app.com/classes/Tarefas";
    var dio = Dio();
    dio.options.headers["X-Parse-Application-Id"] = "dkQpjL9UrLtmVQGCSu3MDXgq4ZiPQzY9HbrjXBSq";
    dio.options.headers["X-Parse-REST-API-Key"] = "OJhmqZWPhUQSae0f87mASDvI7tjwFp7DJ0iRmSOT";
    dio.options.headers["Content-Type"] = "application/json";
    try{
      var response = await dio.post(url, data: model.toJson());
      if(response.statusCode == 201){
        print("salvo");
      }
    }catch(e){
      rethrow;
    }


  }
  Future<void> update(TarefaModel model) async {
    try{
      var dio = Dio();
      dio.options.headers["X-Parse-Application-Id"] = "dkQpjL9UrLtmVQGCSu3MDXgq4ZiPQzY9HbrjXBSq";
      dio.options.headers["X-Parse-REST-API-Key"] = "OJhmqZWPhUQSae0f87mASDvI7tjwFp7DJ0iRmSOT";
      dio.options.headers["Content-Type"] = "application/json";

      var url = "https://parseapi.back4app.com/classes/ceps";
      var response = await dio.put('''$url/${model.objectId}''', data: model.toJson());
      if(response.statusCode == 201){
        if (kDebugMode) {
          print("salvo");
        }
      }}catch(e){
      rethrow;
    }

  }
  Future<void> delete(String id) async {
    try{
      var dio = Dio();
      dio.options.headers["X-Parse-Application-Id"] = "dkQpjL9UrLtmVQGCSu3MDXgq4ZiPQzY9HbrjXBSq";
      dio.options.headers["X-Parse-REST-API-Key"] = "OJhmqZWPhUQSae0f87mASDvI7tjwFp7DJ0iRmSOT";
      dio.options.headers["Content-Type"] = "application/json";
      var url = "https://parseapi.back4app.com/classes/ceps";
      var response = await dio.delete('''$url/$id''');
      if(response.statusCode == 200){
        print("deletado");
      }}catch(e){
      rethrow;
    }

  }
}