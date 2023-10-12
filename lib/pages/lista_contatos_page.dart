import 'dart:io';

import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:image_picker/image_picker.dart';
import 'package:trabalhos_dio/database/repository/contato_repository.dart';
import 'package:trabalhos_dio/models/contato_model.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:path/path.dart';
import 'package:trabalhos_dio/utils/utils.dart';

import '../utils/app_images.dart';

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
  XFile? _selectedFile;

  var nomeController = TextEditingController();
  var telefoneController = TextEditingController();
  String fotoUrl = "";
  //XFile? photo;

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
            _dialogSalvar(0, context);
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
                              _dialogSalvar(contato!.id!, context);
                              ///foto
                             },
                             title: Text(contato!.nome!),
                             trailing: Text('''${contato!.telefone!} ${contato!.urlFoto!}'''),
                             
                           ));
                      }))
          ],
        ),
      ),
    ));
  }
  _dialogSalvar(int id, BuildContext contexto){

    showDialog(
        context: contexto,
        builder: (BuildContext bc) {

          return StatefulBuilder(
            builder: (context, _setState){

          return AlertDialog(
              title: const Text('Contato'),
              content: SingleChildScrollView(
                child: ListBody(
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
                    const SizedBox(height: 25,),
                    GestureDetector(
                      onTap: () async {
                        await getImage(_setState);
                        setState(() {});
                        // cropImage(photo!);

                      },
                      child: const ListTile(
                        title: Text("Camera"),
                        leading: Icon(Icons.camera),

                      ),
                    ),

                    _selectedFile != null ?  Image.file(
                      File(_selectedFile!.path),
                      width: 250,
                      height: 250,
                      fit: BoxFit.cover,
                    ) : Image.asset(
                      AppImages.no_image,
                      width: 250,
                      height: 250,
                      fit: BoxFit.cover,
                    )
                  ],
                ),
              ),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(bc);
                    },
                    child: const Text("Cancelar")),
                TextButton(
                    onPressed: () async {
                      ///
                      setState(() {loading = true;});
                      if(!flagSalvarAtualizar) {
                        print('salvar');
                        await contatoRepository.salvar(ContatoModel(
                            0, nomeController.text, telefoneController.text,fotoUrl));
                      }else{
                        print('atualizar');
                        await contatoRepository.atualizar(ContatoModel(
                            id, nomeController.text, telefoneController.text, fotoUrl));
                      }
                      if(mounted) Navigator.pop(bc);
                      _clearControllers();
                      obterContatos();
                      setState(() {loading = false;});

                    },
                    child: const Text("Salvar"))
              ],
            );
            }
          );

        }
    );
    }
      Future getImage (StateSetter _setState) async {
        final ImagePicker _picker = ImagePicker();
        var _file = await _picker.pickImage(source: ImageSource.camera);

        if (_file != null) {
          String path = (await path_provider
              .getApplicationDocumentsDirectory())
              .path;
          String name = basename(_file!.path);

          fotoUrl = "$path/$name";
          await _file!.saveTo("$path/$name");

          await GallerySaver.saveImage(_file!.path);

          // cropImage(photo!);
        }

        _setState(() {
          // fotoUrl;
          _selectedFile = _file;

        });
      }

    _clearControllers(){
      nomeController.clear();
      telefoneController.clear();
    }
  }

