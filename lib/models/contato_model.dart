class ContatoModel {
  int? _id;
  String? _nome;
  String? _telefone;
  String? _urlFoto;

  ContatoModel(int? id, String? nome, String? telefone, String? urlFoto) {
    if (id != null) {
      this._id = id;
    }
    if (nome != null) {
      this._nome = nome;
    }
    if (telefone != null) {
      this._telefone = telefone;
    }
    if (urlFoto != null) {
      this._urlFoto = urlFoto;
    }
  }

  int? get id => _id;
  set id(int? id) => _id = id;
  String? get nome => _nome;
  set nome(String? nome) => _nome = nome;
  String? get telefone => _telefone;
  set telefone(String? telefone) => _telefone = telefone;
  String? get urlFoto => _urlFoto;
  set urlFoto(String? urlFoto) => _urlFoto = urlFoto;

  ContatoModel.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _nome = json['nome'];
    _telefone = json['telefone'];
    _urlFoto = json['urlFoto'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = this._id;
    data['nome'] = this._nome;
    data['telefone'] = this._telefone;
    data['urlFoto'] = this._urlFoto;
    return data;
  }
  Map<String, dynamic> createJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['nome'] = this._nome;
    data['telefone'] = this._telefone;
    data['urlFoto'] = this._urlFoto;
    return data;
  }
}
