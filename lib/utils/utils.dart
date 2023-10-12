
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';


import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';



  class Utils {



  static String URL_WEB_SERVICE = "http://192.168.0.11:8080/api/";
  //String URL_WEB_SERVICE = "http://avaliacoes-backend.herokuapp.com/";
  static const String IMG_KEY = 'IMAGE_KEY';






  /***************DataHora***************/

  static DateTime getDataHora(){
  return DateTime.now();
  }
  static DateTime? stringToDate(String dataHora){
    return DateTime.tryParse(dataHora);
  }
  static String formatarData(String data, bool small){
    var formater;

    initializeDateFormatting("pt_BR");
    if(small){
      formater = DateFormat("dd/MM/y");
    }else{
      formater = DateFormat("dd/MM/y H:m");
    }
    DateTime dataConvertida =  DateTime.parse(data);
    String date = formater.format(dataConvertida);

    return date;
  }
  /**************Mostrar Texto**************/
  static void showDefaultSnackbar(BuildContext context, String texto) {
  //Scaffold.of(context).showSnackBar(
    final snackBar = SnackBar(
      content: Text((texto.isEmpty) ? "" : texto.toString()),
      action: SnackBarAction(
        label: 'Ok',
        onPressed: () {
          // Some code to undo the change.
        },
      ),
  );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);

  }




  static String base64String(Uint8List bytes){
    return base64Encode(bytes);
  }

  static String formatarDateTime(DateTime? data){
      if(data != null ){
        if(data.month < 10 && data.day < 10){
          return '0${data.day}/0${data.month}/${data.year}';
        }else if(data.day >= 10 && data.month < 10){
          return '${data.day}/0${data.month}/${data.year}';
        }else if(data.day < 10 && data.month >= 10){
          return '0${data.day}/${data.month}/${data.year}';
        }else{
          return '${data.day}/${data.month}/${data.year}';
        }
      }
      return data.toString();

  }

  static Image imageFromBase64String(String bytes){
    return Image.memory(

        base64Decode(bytes),
        height: 80.0,
        width: 80.0,
        fit: BoxFit.fill,
        alignment: Alignment.center,

        );
  }
    static Uint8List fileFromBase64String(String bytes)=> base64.decode(bytes);

  }














































