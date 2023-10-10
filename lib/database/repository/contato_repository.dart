
import 'package:projeto_dio_flutter/model/tarefa_model.dart';
import 'package:projeto_dio_flutter/pages/sqflitte/database_sqflitte.dart';

class TarefaRepository{

  Future<List<TarefaModel>> obrterDados (bool naoConcluidos) async {

    List<TarefaModel> tarefas = [];
    var db = await DataBaseSqFlitte().obterDatabase();
    var result = await db.rawQuery(
        naoConcluidos ?
        "SELECT id, descricao, cloncluido FROM tarefas WHERE cloncluido = 0 ":
        "SELECT id, descricao, cloncluido FROM tarefas");
    for(var item in result){
      tarefas.add(TarefaModel(int.parse(item["id"].toString()),
                              item["cloncluido"].toString() == 1,
                              item["descricao"].toString(),
                              ));
    }
    return tarefas;
  }
  Future<void> salvar(TarefaModel model) async{
    var db = await DataBaseSqFlitte().obterDatabase();
    await db.rawInsert("INSERT INTO tarefas (descricao, cloncluido) values (?,?)",
    [model.descricao, model.concluido]);

  }
  Future<void> atualizar(TarefaModel model) async{
    var db = await DataBaseSqFlitte().obterDatabase();
    await db.rawUpdate("UPDATE tarefas  set descricao = ?, cloncluido = ? WHERE id = ? ",
        [model.descricao, model.concluido, model.id]);

  }
  Future<void> deletar(int id) async{
    var db = await DataBaseSqFlitte().obterDatabase();
    await db.rawDelete("DELETE FROM tarefas WHERE = ?",[id]);

  }
}