import '../../models/contato_model.dart';
import '../database_sqflitte.dart';

class ContatoRepository{

  Future<List<ContatoModel>> obterDados () async {

    List<ContatoModel> contatos = [];
    var db = await DataBaseSqFlitte().obterDatabase();
    var result = await db.rawQuery(" SELECT id, nome, telefone, urlFoto FROM contatos ");
    for(var item in result){
      contatos.add(ContatoModel(int.parse(item["id"].toString()),
                              item["nome"].toString(),
                              item["telefone"].toString(),
                              item["urlFoto"].toString(),
                              ));
    }
    return contatos;
  }
  Future<void> salvar(ContatoModel model) async{
    var db = await DataBaseSqFlitte().obterDatabase();
    await db.rawInsert("INSERT INTO contatos (nome, telefone, urlFoto) values (?,?,?)",
    [model.nome, model.telefone, model.urlFoto]);
  }

  Future<void> atualizar(ContatoModel model) async{
    var db = await DataBaseSqFlitte().obterDatabase();
    await db.rawUpdate("UPDATE contatos  set nome = ?, telefone = ?, urlFoto = ? WHERE id = ? ",
        [model.nome, model.telefone, model.urlFoto, model.id]);
  }

  Future<void> deletar(int id) async{
    var db = await DataBaseSqFlitte().obterDatabase();
    await db.rawDelete("DELETE FROM contatos WHERE id = ?",[id]);

  }
}