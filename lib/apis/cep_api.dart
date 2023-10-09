import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:trabalhos_dio/models/cep_back4app_model.dart';


import '../models/cep_model.dart';

class CepApi{

  var url = "https://parseapi.back4app.com/classes/ceps";

  Future<CepModel> getByCep(String cep)async{
    var response = await http.get(Uri.parse("https://viacep.com.br/ws/$cep/json/"));

    if(response.statusCode == 200){
      var json = jsonDecode(response.body);
      return CepModel.fromJson(json);
    }else{
      return CepModel();
    }


  }

  Future<CepBack4AppModel> getAllBy4App(String? cep) async{
    var dio = Dio();
    dio.options.headers["X-Parse-Application-Id"] = "dkQpjL9UrLtmVQGCSu3MDXgq4ZiPQzY9HbrjXBSq";
    dio.options.headers["X-Parse-REST-API-Key"] = "OJhmqZWPhUQSae0f87mASDvI7tjwFp7DJ0iRmSOT";
    dio.options.headers["Content-Type"] = "application/json";

    if(cep != null){
      url+="?where={\"cep\":\"${cep.toString()}\"}";
    }
    var result = await dio.get(url);
    return CepBack4AppModel.fromJson(result.data);
  }
  Future<void> add(CepModel model) async {
    var dio = Dio();
    try{
      var response = await dio.post('''url/${model.objectId}''', data: model.toCreateJson());
      if(response.statusCode == 201){
        print("salvo");
      }
    }catch(e){
      rethrow;
    }


  }
  Future<void> update(CepModel model) async {
    var dio = Dio();

    var response = await dio.put(url, data: model);
    if(response.statusCode == 201){
      print("salvo");
    }

  }
  Future<void> delete(String id) async {
    var dio = Dio();

    var response = await dio.delete('url', data: model);
    if(response.statusCode == 201){
      print("salvo");
    }

  }
}