class CepBack4AppModel {
  List<Results>? results;

  CepBack4AppModel({this.results});

  CepBack4AppModel.fromJson(Map<String, dynamic> json) {
    if (json['results'] != null) {
      results = <Results>[];
      json['results'].forEach((v) {
        results!.add(new Results.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.results != null) {
      data['results'] = this.results!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Results {
  String? objectId;
  String? createdAt;
  String? updatedAt;
  String? uf;
  String? cep;
  String? gia;
  String? localidade;
  String? siafi;
  String? ibge;
  String? bairro;
  String? logradouro;
  String? ddd;

  Results(
      {this.objectId,
        this.createdAt,
        this.updatedAt,
        this.uf,
        this.cep,
        this.gia,
        this.localidade,
        this.siafi,
        this.ibge,
        this.bairro,
        this.logradouro,
        this.ddd});

  Results.fromJson(Map<String, dynamic> json) {
    objectId = json['objectId'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    uf = json['uf'];
    cep = json['cep'];
    gia = json['gia'];
    localidade = json['localidade'];
    siafi = json['siafi'];
    ibge = json['ibge'];
    bairro = json['bairro'];
    logradouro = json['logradouro'];
    ddd = json['ddd'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['objectId'] = this.objectId;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['uf'] = this.uf;
    data['cep'] = this.cep;
    data['gia'] = this.gia;
    data['localidade'] = this.localidade;
    data['siafi'] = this.siafi;
    data['ibge'] = this.ibge;
    data['bairro'] = this.bairro;
    data['logradouro'] = this.logradouro;
    data['ddd'] = this.ddd;
    return data;
  }
}