

class TarefaGetxModel {

  List<TarefaModel>? results;

  TarefaGetxModel({this.results});

  TarefaGetxModel.fromJson(Map<String, dynamic> json) {
    if (json['results'] != null) {
      results = <TarefaModel>[];
      json['results'].forEach((v) {
        results!.add(TarefaModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (results != null) {
      data['results'] = results!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TarefaModel {
  String? objectId;
  String? createdAt;
  String? updatedAt;
  bool? concluida;
  String? descricao;

  TarefaModel(
      {this.objectId,
        this.createdAt,
        this.updatedAt,
        this.concluida,
        this.descricao});

  TarefaModel.fromJson(Map<String, dynamic> json) {
    objectId = json['objectId'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    concluida = json['concluida'];
    descricao = json['descricao'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['objectId'] = objectId;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['concluida'] = concluida;
    data['descricao'] = descricao;
    return data;
  }
}