import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:trabalhos_dio/models/cep_back4app_model.dart';

import '../models/tarefa_model_getx.dart';



class TarefaGetxApi{


  Future<TarefaGetxModel> getAllBy4App(String? cep) async{

    var url = "https://parseapi.back4app.com/classes/ceps";
    var dio = Dio();
    dio.options.headers["X-Parse-Application-Id"] = "dkQpjL9UrLtmVQGCSu3MDXgq4ZiPQzY9HbrjXBSq";
    dio.options.headers["X-Parse-REST-API-Key"] = "OJhmqZWPhUQSae0f87mASDvI7tjwFp7DJ0iRmSOT";
    dio.options.headers["Content-Type"] = "application/json";

    if(cep != null){
      url+="?where={\"cep\":\"${cep.toString()}\"}";
    }
    var result = await dio.get(url);
    return TarefaGetxModel.fromJson(result.data);
  }
  Future<void> add(CepModel model) async {

    var url = "https://parseapi.back4app.com/classes/ceps";
    var dio = Dio();
    dio.options.headers["X-Parse-Application-Id"] = "dkQpjL9UrLtmVQGCSu3MDXgq4ZiPQzY9HbrjXBSq";
    dio.options.headers["X-Parse-REST-API-Key"] = "OJhmqZWPhUQSae0f87mASDvI7tjwFp7DJ0iRmSOT";
    dio.options.headers["Content-Type"] = "application/json";
    try{
      var response = await dio.post(url, data: model.toCreateJson());
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
      var response = await dio.put('''$url/${model.results[0].}''', data: model.toCreateJson());
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