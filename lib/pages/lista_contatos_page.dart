import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:trabalhos_dio/database/repository/contato_repository.dart';
import 'package:trabalhos_dio/models/contato_model.dart';

class ContatosPage extends StatefulWidget {
  const ContatosPage({super.key});

  @override
  State<ContatosPage> createState() => _ContatosPageState();
}

class _ContatosPageState extends State<ContatosPage> {

  ContatoRepository contatoRepository = ContatoRepository();
  var _contatos = const <ContatoModel>[];
  bool loading = false;
  bool flagSalvarAtualizar = false;

  var nomeController = TextEditingController();
  var telefoneController = TextEditingController();


  @override
  void initState() {
    obterContatos();
    super.initState();
   
}

void obterContatos() async {
  setState(() {loading = true;});
  _contatos = await contatoRepository.obterDados();
  setState(() {loading = false;});
}

  @override
  Widget build(BuildContext context) {
    return SafeArea(child:
    Scaffold(
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
          onPressed:(){
            _dialogSalvar(0);
            }
      ),
      appBar: AppBar(title: const Text("Contatos"),),
      body: Container(
        margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Text("data"),
        const SizedBox(height: 25,),
        loading ?
        const Center(child: CircularProgressIndicator()) :
              Expanded(
                  child: ListView.builder(
                      itemCount: _contatos.length,
                      itemBuilder: (BuildContext dc, int index){
                        var contato = _contatos[index];
                        return Dismissible (
                            onDismissed:  (DismissDirection dismissDirection) async {
                            await contatoRepository.deletar(contato!.id!);
                            obterContatos();
                          },
                           key: Key(contato!.nome!),
                           child: ListTile(
                             onTap: (){
                              flagSalvarAtualizar = true;
                              nomeController.text = contato!.nome!;
                              telefoneController.text = contato!.telefone!;
                              _dialogSalvar(contato!.id!);
                              ///foto
                             },
                             title: Text(contato!.nome!),
                             trailing: Text(contato!.telefone!),
                             
                           ));
                      }))
          ],
        ),
      ),
    ));
  }
  _dialogSalvar(int id){

    showDialog(
        context: context,
        builder: (BuildContext bc) {
          return AlertDialog(
            title: const Text("Adicionar Contato"),
            content: Wrap(
              children: [
                const Text("Nome"),
                TextFormField(
                  controller: nomeController,
                  keyboardType: TextInputType.text,
                  inputFormatters: const [
                    // obrigatório
                    //FilteringTextInputFormatter.digitsOnly,
                    //CepInputFormatter(),
                  ],
                ),
                const SizedBox(height: 50,),
                const Text("Telefone"),
                TextFormField(
                  controller: telefoneController,
                  keyboardType: TextInputType.phone,
                  inputFormatters: [
                    // obrigatório
                     FilteringTextInputFormatter.digitsOnly,
                     TelefoneInputFormatter(),
                  ],
                ),
              ],
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("Cancelar")),
              TextButton(
                  onPressed: () async {
                    ///
                    setState(() {loading = true;});
                    if(!flagSalvarAtualizar) {
                      print('salvar');
                      await contatoRepository.salvar(ContatoModel(
                          0, nomeController.text, telefoneController.text, ""));
                    }else{
                      print('atualizar');
                      await contatoRepository.atualizar(ContatoModel(
                          id, nomeController.text, telefoneController.text, ""));
                    }
                    if(mounted) Navigator.pop(context);
                    obterContatos();
                    setState(() {loading = false;});

                    },
                  child: const Text("Salvar"))
            ],
          );
        }
    );
    }
  }

