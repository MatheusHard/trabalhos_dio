import 'package:flutter/material.dart';
import 'package:trabalhos_dio/apis/tarefa_api.dart';
import 'package:trabalhos_dio/database/repository/contato_repository.dart';
import 'package:trabalhos_dio/models/contato_model.dart';
import 'package:trabalhos_dio/pages/home/home_page.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  ContatoRepository contatoRepository = ContatoRepository();

 // await contatoRepository.salvar(ContatoModel(0,  "Irineu, voce não sabe, nem eu", "88709000", "foto/fff"));

  TarefaApi tarefaApi = TarefaApi();

  var lista = await tarefaApi.getAllBy4App(true);

  runApp(
      MaterialApp(
        title: 'DIO',
        debugShowCheckedModeBanner: false,
        routes: {
          '/home_page': (BuildContext context) => const HomePage(),

        },
        initialRoute: '/home_page',
      ));
}
