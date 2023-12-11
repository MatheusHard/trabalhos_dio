import 'package:get/get.dart';
import 'package:trabalhos_dio/apis/tarefa_api.dart';
import 'package:trabalhos_dio/models/tarefa_model_getx.dart';

class TarefaGetxController extends GetxController {

  TarefaApi tarefaApi = TarefaApi();

  //var lista = await tarefaApi.getAllBy4App(true);

  var _apenasconcluidos = false.obs;
  RxList<TarefaModel> _tarefas = <TarefaModel>[].obs;

  Future<List<TarefaModel>> get tarefas async =>  await tarefaApi.getAllBy4App(_apenasconcluidos.value);

  bool get apenasConcluidos => _apenasconcluidos.value;

  void setApenasConcluidos(bool value) {
    _apenasconcluidos.value = value;
  }

  adicionar(String descricao) async {
    await tarefaApi.add(TarefaModel(descricao: descricao,concluida: false));
  }

  atualizar(String id, String tDescricao, bool tConcluido){

   /* var tarefa = _tarefas.firstWhere((element) => element.id == id);
    tarefa.concluido = tConcluido;
    tarefa.descricao = tDescricao;
    _tarefas.refresh();*/
  }
  excluir(String id){
    _tarefas.removeWhere((element) => element.objectId == id);
  }
}